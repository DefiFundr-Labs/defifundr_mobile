import 'dart:async';
import 'dart:convert';

import 'package:defifundr_mobile/core/cache/cache_entry.dart';
import 'package:defifundr_mobile/core/cache/cache_policy.dart';
import 'package:defifundr_mobile/core/cache/storage/cache_storage.dart';
import 'package:defifundr_mobile/core/cache/storage/memory_cache_storage.dart';
import 'package:defifundr_mobile/core/cache/storage/secure_cache_storage.dart';
import 'package:defifundr_mobile/core/cache/storage/shared_prefs_cache_storage.dart';
import 'package:defifundr_mobile/core/event_bus/event_bus.dart';
import 'package:defifundr_mobile/core/retry/retryable.dart';
import 'package:logger/logger.dart';

export 'cache_policy.dart';
export 'package:defifundr_mobile/core/retry/retryable.dart';
export 'storage/cache_storage.dart';
export 'storage/memory_cache_storage.dart';
export 'storage/secure_cache_storage.dart';
export 'storage/shared_prefs_cache_storage.dart';

final _log = Logger();

const _defaultTtl = Duration(minutes: 5);
const _defaultPolicy = CachePolicy.cacheFirst;

/// Which backing store the cache uses.
enum AppCacheType {
  /// Fast, non-persistent. Cleared on app restart.
  /// Use for: computed results, paginated lists, UI state.
  memory,

  /// Persistent, non-sensitive. Survives restarts.
  /// Use for: API responses, user preferences, feature flags.
  prefs,

  /// Encrypted, persistent. Backed by Keychain / Keystore.
  /// Use for: auth tokens, wallet keys, private user data.
  secure,
}

class AppCache {
  AppCache._({required this.cacheType, required CacheStorage storage})
      : _storage = storage;

  // ── Named accessors ────────────────────────────────────────────────────────

  /// Fast, non-persistent. Cleared on app restart.
  static AppCache get memory => _memory;

  /// Persistent, non-sensitive. Survives restarts.
  static AppCache get prefs => _prefs;

  /// Encrypted, persistent. Backed by Keychain / Keystore.
  static AppCache get secure => _secure;

  /// Programmatic access — use when [AppCacheType] is a variable.
  static AppCache of(AppCacheType type) => switch (type) {
        AppCacheType.memory => _memory,
        AppCacheType.prefs => _prefs,
        AppCacheType.secure => _secure,
      };

  static final _memory = AppCache._(
    cacheType: AppCacheType.memory,
    storage: MemoryCacheStorage(),
  );
  static final _prefs = AppCache._(
    cacheType: AppCacheType.prefs,
    storage: SharedPrefsCacheStorage(),
  );
  static final _secure = AppCache._(
    cacheType: AppCacheType.secure,
    storage: SecureCacheStorage(),
  );

  final AppCacheType cacheType;
  final CacheStorage _storage;

  // ── Read ───────────────────────────────────────────────────────────────────

  Future<T?> read<T>(String key, {T Function(dynamic)? fromJson}) async {
    final entry = await _readEntry<T>(key, fromJson: fromJson);
    return entry?.data;
  }

  Future<CacheEntry<T>?> entry<T>(
    String key, {
    T Function(dynamic)? fromJson,
  }) =>
      _readEntry<T>(key, fromJson: fromJson);

  Future<bool> has(String key) async => await _readEntry(key) != null;

  Future<bool> isStale(String key) async {
    final entry = await _readEntry(key);
    return entry?.isStale ?? true;
  }

  // ── Write ──────────────────────────────────────────────────────────────────

  Future<void> write<T>(
    String key,
    T data, {
    Duration ttl = _defaultTtl,
  }) async {
    final entry = CacheEntry<T>(data: data, ttl: ttl);
    final encoded = jsonEncode({
      'data': data,
      'cachedAt': entry.cachedAt.toIso8601String(),
      'ttlMs': ttl.inMilliseconds,
    });
    await _storage.write(key, encoded);
  }

  Future<void> invalidate(String key) => _storage.delete(key);

  Future<void> invalidateWhere(bool Function(String key) test) async {
    final allKeys = await _storage.keys();
    for (final key in allKeys.where(test)) {
      await _storage.delete(key);
    }
  }

  Future<void> clear() => _storage.clear();

  // ── Fetch with policy ──────────────────────────────────────────────────────

  /// Fetch [key], applying [policy]. Returns [TaskEither] — never throws.
  ///
  /// Cache hit  → returns cached data immediately (or in background for [CachePolicy.cacheFirst]).
  /// Cache miss → calls [fetcher], stores the result, returns it.
  TaskEither<Failure, T> fetch<T>(
    String key,
    Future<T> Function() fetcher, {
    Duration ttl = _defaultTtl,
    CachePolicy policy = _defaultPolicy,
    RetryPolicy? retryPolicy,
    T Function(dynamic)? fromJson,
    Failure Function(Object)? onError,
  }) =>
      TaskEither.tryCatch(
        () => _applyPolicy(key, fetcher, ttl, policy, fromJson, retryPolicy),
        (e, _) => onError != null
            ? onError(e)
            : UnknownFailure(message: e.toString(), cause: e),
      );

  // ── Policies ───────────────────────────────────────────────────────────────

  Future<T> _applyPolicy<T>(
    String key,
    Future<T> Function() fetcher,
    Duration ttl,
    CachePolicy policy,
    T Function(dynamic)? fromJson,
    RetryPolicy? retryPolicy,
  ) =>
      switch (policy) {
        CachePolicy.noCache => _noCache(key, fetcher, ttl, retryPolicy),
        CachePolicy.useCache =>
          _useCache(key, fetcher, ttl, fromJson, retryPolicy),
        CachePolicy.cacheFirst =>
          _cacheFirst(key, fetcher, ttl, fromJson, retryPolicy),
        CachePolicy.networkFirst =>
          _networkFirst(key, fetcher, ttl, fromJson, retryPolicy),
      };

  Future<T> _noCache<T>(
    String key,
    Future<T> Function() fetcher,
    Duration ttl,
    RetryPolicy? retryPolicy,
  ) async {
    _log.d('[Cache:noCache] $key');
    final data = await retryable(
      fetcher,
      policy: retryPolicy ?? RetryPolicy.exponentialBackoff(),
      label: key,
    );
    await write(key, data, ttl: ttl);
    return data;
  }

  Future<T> _useCache<T>(
    String key,
    Future<T> Function() fetcher,
    Duration ttl,
    T Function(dynamic)? fromJson,
    RetryPolicy? retryPolicy,
  ) async {
    final cached = await _readEntry<T>(key, fromJson: fromJson);
    if (cached != null && cached.isFresh) {
      _log.d('[Cache:useCache] HIT $key (age: ${cached.age.inSeconds}s)');
      return cached.data;
    }
    _log.d('[Cache:useCache] ${cached == null ? 'MISS' : 'STALE'} $key');
    return _fetchAndStore(key, fetcher, ttl, retryPolicy);
  }

  Future<T> _cacheFirst<T>(
    String key,
    Future<T> Function() fetcher,
    Duration ttl,
    T Function(dynamic)? fromJson,
    RetryPolicy? retryPolicy,
  ) async {
    final cached = await _readEntry<T>(key, fromJson: fromJson);
    if (cached == null) {
      _log.d('[Cache:cacheFirst] MISS $key');
      return _fetchAndStore(key, fetcher, ttl, retryPolicy);
    }
    if (cached.isFresh) {
      _log.d('[Cache:cacheFirst] HIT $key (age: ${cached.age.inSeconds}s)');
      return cached.data;
    }
    _log.d('[Cache:cacheFirst] STALE $key — revalidating in background');
    _revalidateWithRetry(key, fetcher, ttl, retryPolicy);
    return cached.data;
  }

  Future<T> _networkFirst<T>(
    String key,
    Future<T> Function() fetcher,
    Duration ttl,
    T Function(dynamic)? fromJson,
    RetryPolicy? retryPolicy,
  ) async {
    _log.d('[Cache:networkFirst] $key');
    try {
      final data = await retryable(
        fetcher,
        policy: retryPolicy ?? RetryPolicy.exponentialBackoff(),
        label: key,
      );
      await write(key, data, ttl: ttl);
      return data;
    } catch (e) {
      final cached = await _readEntry<T>(key, fromJson: fromJson);
      if (cached != null) {
        _log.w('[Cache:networkFirst] Network failed — using cache '
            '(age: ${cached.age.inSeconds}s)');
        return cached.data;
      }
      rethrow;
    }
  }

  // ── Background revalidation ────────────────────────────────────────────────

  void _revalidateWithRetry<T>(
    String key,
    Future<T> Function() fetcher,
    Duration ttl,
    RetryPolicy? retryPolicy,
  ) {
    Future(() async {
      try {
        final fresh = await retryable(
          fetcher,
          policy: retryPolicy ?? RetryPolicy.exponentialBackoff(maxAttempts: 3),
          label: 'revalidate:$key',
        );
        await write(key, fresh, ttl: ttl);
        _log.d('[Cache] REVALIDATED $key');
        EventBus.instance.emit(CacheUpdated(key: key, data: fresh));
      } catch (e) {
        _log.e('[Cache] Revalidation failed for $key: $e');
        EventBus.instance.emit(CacheRevalidationFailed(
          key: key,
          error: e,
          attempts: 3,
        ));
      }
    });
  }

  // ── Internal ───────────────────────────────────────────────────────────────

  Future<T> _fetchAndStore<T>(
    String key,
    Future<T> Function() fetcher,
    Duration ttl,
    RetryPolicy? retryPolicy,
  ) async {
    final data = await retryable(
      fetcher,
      policy: retryPolicy ?? RetryPolicy.exponentialBackoff(),
      label: key,
    );
    await write(key, data, ttl: ttl);
    return data;
  }

  Future<CacheEntry<T>?> _readEntry<T>(
    String key, {
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final raw = await _storage.read(key);
      if (raw == null) return null;

      final map = jsonDecode(raw) as Map<String, dynamic>;
      final cachedAt = DateTime.parse(map['cachedAt'] as String);
      final ttl = Duration(milliseconds: map['ttlMs'] as int);
      final rawData = map['data'];
      final data = fromJson != null ? fromJson(rawData) : rawData as T;

      return CacheEntry<T>.fromStorage(data: data, cachedAt: cachedAt, ttl: ttl);
    } catch (e) {
      _log.w('[Cache] Failed to read $key: $e');
      await _storage.delete(key);
      return null;
    }
  }
}
