import 'package:defifundr_mobile/core/cache/app_cache.dart';
import 'package:defifundr_mobile/core/event_bus/event_bus.dart';
import 'package:defifundr_mobile/core/feature_flags/app_flag.dart';
import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';

export 'app_flag.dart';
export 'app_flags.dart';

const _cacheKey = 'feature_flags';
const _cacheTtl = Duration(hours: 1);

final _log = Logger();

/// Reads and refreshes feature flags.
///
/// Flags are fetched from a remote source, cached in [AppCache.prefs],
/// and kept in memory for zero-latency reads.
///
/// Setup:
/// ```dart
/// await FeatureFlagService.instance.init();
/// ```
///
/// Refresh from remote (call on app foreground or login):
/// ```dart
/// await FeatureFlagService.instance
///     .refresh(() => apiClient.getFlags())
///     .run();
/// ```
///
/// Read a flag anywhere — sync, no async:
/// ```dart
/// final enabled = FeatureFlagService.instance.isEnabled(AppFlags.newPayrollFlow);
/// final limit   = FeatureFlagService.instance.get(AppFlags.maxInvoiceLineItems);
/// ```
class FeatureFlagService {
  FeatureFlagService._();
  static final instance = FeatureFlagService._();

  Map<String, dynamic> _flags = {};
  final Map<String, dynamic> _overrides = {};

  // ── Lifecycle ──────────────────────────────────────────────────────────────

  /// Load cached flags into memory. Call once at startup before the first frame.
  Future<void> init() async {
    try {
      final cached = await AppCache.prefs.read<Map<String, dynamic>>(
        _cacheKey,
        fromJson: (raw) => Map<String, dynamic>.from(raw as Map),
      );
      if (cached != null) {
        _flags = cached;
        _log.d('[Flags] Loaded ${_flags.length} flags from cache');
      }
    } catch (e) {
      _log.w('[Flags] Failed to load from cache: $e');
    }
  }

  // ── Refresh ────────────────────────────────────────────────────────────────

  /// Fetch fresh flags from [fetcher], persist to cache, update in-memory.
  ///
  /// Emits [FlagsRefreshed] on success so BLoCs can react to flag changes.
  TaskEither<Failure, Unit> refresh(
    Future<Map<String, dynamic>> Function() fetcher, {
    Failure Function(Object)? onError,
  }) =>
      TaskEither.tryCatch(
        () async {
          final remote = await fetcher();
          _flags = remote;
          await AppCache.prefs.write(_cacheKey, remote, ttl: _cacheTtl);
          EventBus.instance
              .emit(FlagsRefreshed(flags: Map.unmodifiable(remote)));
          _log.d('[Flags] Refreshed ${remote.length} flags');
          return unit;
        },
        (e, _) {
          _log.e('[Flags] Refresh failed: $e');
          return onError != null
              ? onError(e)
              : NetworkFailure(
                  message: 'Failed to refresh feature flags', cause: e);
        },
      );

  // ── Read ───────────────────────────────────────────────────────────────────

  /// Returns the current value of [flag].
  ///
  /// Priority: dev override → remote value → [AppFlag.defaultValue].
  T get<T>(AppFlag<T> flag) {
    if (_overrides.containsKey(flag.key)) return _overrides[flag.key] as T;
    final value = _flags[flag.key];
    if (value == null) return flag.defaultValue;
    return value is T ? value : flag.defaultValue;
  }

  /// Convenience for boolean flags.
  bool isEnabled(AppFlag<bool> flag) => get(flag);

  /// True if [flag] has a non-empty string value.
  bool hasValue(AppFlag<String> flag) => get(flag).isNotEmpty;

  // ── Dev overrides ──────────────────────────────────────────────────────────

  /// Override a flag locally — useful for development and widget testing.
  void override<T>(AppFlag<T> flag, T value) {
    _overrides[flag.key] = value;
    _log.d('[Flags] Override: ${flag.key} = $value');
  }

  void clearOverride(AppFlag<dynamic> flag) => _overrides.remove(flag.key);
  void clearAllOverrides() => _overrides.clear();

  /// All active flag values (remote + defaults, before overrides).
  Map<String, dynamic> get allFlags => Map.unmodifiable(_flags);
}
