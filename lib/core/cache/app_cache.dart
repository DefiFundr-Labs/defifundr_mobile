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

class AppCache {
  AppCache(this._storage);

  final CacheStorage _storage;

  // ── Named instances ────────────────────────────────────────────────────────

  /// Fast, non-persistent. Cleared on app restart.
  /// Use for: computed results, paginated lists, UI state.
  static final memory = AppCache(MemoryCacheStorage());

  /// Persistent, non-sensitive. Survives restarts.
  /// Use for: API responses, user preferences, feature flags.
  static final prefs = AppCache(SharedPrefsCacheStorage());

  /// Encrypted, persistent. Survives restarts, backed by Keychain / Keystore.
  /// Use for: auth tokens, wallet keys, private user data.
  static final secure = AppCache(SecureCacheStorage());

  // ── Read ───────────────────────────────────────────────────────────────────

  Future<T?> get<T>(String key, {T Function(dynamic)? fromJson}) async {
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

  Future<void> set<T>(
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

  Future<T> fetch<T>(
    String key,
    Future<T> Function() fetcher, {
    Duration ttl = _defaultTtl,
    CachePolicy policy = _defaultPolicy,
    RetryPolicy? retryPolicy,
    T Function(dynamic)? fromJson,
  }) async {
    switch (policy) {
      case CachePolicy.noCache:
        return _noCache(key, fetcher, ttl, retryPolicy);

      case CachePolicy.useCache:
        return _useCache(key, fetcher, ttl, fromJson, retryPolicy);

      case CachePolicy.cacheFirst:
        return _cacheFirst(key, fetcher, ttl, fromJson, retryPolicy);

      case CachePolicy.networkFirst:
        return _networkFirst(key, fetcher, ttl, fromJson, retryPolicy);
    }
  }

  /// Same as [fetch] but returns a [TaskEither] — never throws.
  TaskEither<Failure, T> fetchTE<T>(
    String key,
    Future<T> Function() fetcher, {
    Duration ttl = _defaultTtl,
    CachePolicy policy = _defaultPolicy,
    RetryPolicy? retryPolicy,
    Failure Function(Object)? toFailure,
    T Function(dynamic)? fromJson,
  }) =>
      TaskEither.tryCatch(
        () => fetch(key, fetcher, ttl: ttl, policy: policy, retryPolicy: retryPolicy, fromJson: fromJson),
        (e, _) => toFailure != null ? toFailure(e) : UnknownFailure(message: e.toString(), cause: e),
      );

  // ── Policies ───────────────────────────────────────────────────────────────

  /// Always fetch. Never reads cache, but stores the result.
  Future<T> _noCache<T>(
    String key,
    Future<T> Function() fetcher,
    Duration ttl,
    RetryPolicy? retryPolicy,
  ) async {
    _log.d('[Cache:noCache] $key');
    final data = await retryable(fetcher, policy: retryPolicy ?? RetryPolicy.exponentialBackoff(), label: key);
    await set(key, data, ttl: ttl);
    return data;
  }

  /// Return fresh cache immediately. If stale or missing, fetch and wait.
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

    _log.d('[Cache:useCache] ${cached == null ? 'MISS' : 'STALE'} $key — fetching');
    return _fetchAndStore(key, fetcher, ttl, retryPolicy);
  }

  /// Return cache immediately (even if stale), refresh in background.
  /// Falls back to network if no cache exists yet.
  Future<T> _cacheFirst<T>(
    String key,
    Future<T> Function() fetcher,
    Duration ttl,
    T Function(dynamic)? fromJson,
    RetryPolicy? retryPolicy,
  ) async {
    final cached = await _readEntry<T>(key, fromJson: fromJson);

    if (cached == null) {
      _log.d('[Cache:cacheFirst] MISS $key — fetching');
      return _fetchAndStore(key, fetcher, ttl, retryPolicy);
    }

    if (cached.isFresh) {
      _log.d('[Cache:cacheFirst] HIT $key (age: ${cached.age.inSeconds}s)');
      return cached.data;
    }

    _log.d('[Cache:cacheFirst] STALE $key — returning cached, revalidating');
    _revalidateWithRetry(key, fetcher, ttl, retryPolicy);
    return cached.data;
  }

  /// Always fetch first, cache the result.
  /// Falls back to stale cache if the network fails.
  Future<T> _networkFirst<T>(
    String key,
    Future<T> Function() fetcher,
    Duration ttl,
    T Function(dynamic)? fromJson,
    RetryPolicy? retryPolicy,
  ) async {
    _log.d('[Cache:networkFirst] $key — fetching');
    try {
      final data = await retryable(fetcher, policy: retryPolicy ?? RetryPolicy.exponentialBackoff(), label: key);
      await set(key, data, ttl: ttl);
      return data;
    } catch (e) {
      final cached = await _readEntry<T>(key, fromJson: fromJson);
      if (cached != null) {
        _log.w('[Cache:networkFirst] Network failed for $key — using cache '
            '(age: ${cached.age.inSeconds}s)');
        return cached.data;
      }
      rethrow;
    }
  }

  // ── Revalidation with retry policy ────────────────────────────────────────

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
        await set(key, fresh, ttl: ttl);
        _log.d('[Cache] REVALIDATED $key');
        EventBus.instance.emit(CacheUpdated(key: key, data: fresh));
      } catch (e) {
        _log.e('[Cache] Revalidation failed for $key after retries: $e');
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
    await set(key, data, ttl: ttl);
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

      return CacheEntry<T>.fromStorage(
        data: data,
        cachedAt: cachedAt,
        ttl: ttl,
      );
    } catch (e) {
      _log.w('[Cache] Failed to read $key: $e');
      await _storage.delete(key);
      return null;
    }
  }
}
