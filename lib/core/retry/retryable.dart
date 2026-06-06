import 'package:defifundr_mobile/core/error/failure.dart';
import 'package:defifundr_mobile/core/retry/retry_policy.dart';
import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';

export 'package:fpdart/fpdart.dart';
export 'package:defifundr_mobile/core/error/failure.dart';
export 'retry_policy.dart';

final _log = Logger();

// ── Future-based (throws on failure) ─────────────────────────────────────────

/// Executes [operation] and retries according to [policy] on failure.
/// Throws the last error if all attempts are exhausted.
Future<T> retryable<T>(
  Future<T> Function() operation, {
  RetryPolicy policy = const _DefaultPolicy(),
  String? label,
}) async {
  int attempts = 0;

  while (true) {
    try {
      return await operation();
    } catch (e) {
      attempts++;
      _log.w('[Retry] ${label ?? 'operation'} failed (attempt $attempts): $e');

      final shouldRetry = await policy.shouldRetry(attempts);
      if (!shouldRetry) {
        _log.e('[Retry] ${label ?? 'operation'} giving up after $attempts attempt(s)');
        rethrow;
      }
    }
  }
}

// ── TaskEither-based (functional, composable) ─────────────────────────────────

/// Same as [retryable] but returns a [TaskEither] — never throws.
/// Left side is a [Failure], right side is the result.
///
/// ```dart
/// final result = await retryableTE(
///   () => apiClient.getBalance(userId),
///   toFailure: (e) => ServerFailure(message: e.toString()),
///   policy: RetryPolicy.exponentialBackoff(),
/// ).run();
///
/// result.fold(
///   (failure) => emit(BalanceState.failure(failure.message)),
///   (balance) => emit(BalanceState.loaded(balance)),
/// );
/// ```
TaskEither<Failure, T> retryableTE<T>(
  Future<T> Function() operation, {
  Failure Function(Object error)? toFailure,
  RetryPolicy policy = const _DefaultPolicy(),
  String? label,
}) =>
    TaskEither.tryCatch(
      () => retryable(operation, policy: policy, label: label),
      (error, _) {
        if (toFailure != null) return toFailure(error);
        return _mapToFailure(error, label);
      },
    );

Failure _mapToFailure(Object error, String? label) {
  final msg = error.toString();
  if (msg.contains('SocketException') || msg.contains('NetworkException')) {
    return NetworkFailure(cause: error);
  }
  if (msg.contains('TimeoutException')) {
    return TimeoutFailure(cause: error);
  }
  return UnknownFailure(message: label != null ? '$label failed: $msg' : msg, cause: error);
}

// Default: 3 attempts, linear backoff 2s → 4s
final class _DefaultPolicy implements RetryPolicy {
  const _DefaultPolicy();

  @override
  Future<bool> shouldRetry(int attempts) async {
    if (attempts >= 3) return false;
    await Future.delayed(Duration(seconds: attempts * 2));
    return true;
  }
}
