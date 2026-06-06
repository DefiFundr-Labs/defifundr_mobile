sealed class Failure {
  const Failure({required this.message, this.cause});

  final String message;
  final Object? cause;

  @override
  String toString() => '$runtimeType: $message';
}

// ── Network ───────────────────────────────────────────────────────────────────

/// Request reached the server but returned an error status code.
final class ServerFailure extends Failure {
  const ServerFailure({required super.message, this.statusCode, super.cause});
  final int? statusCode;
}

/// Device has no internet connection.
final class NetworkFailure extends Failure {
  const NetworkFailure({super.message = 'No internet connection', super.cause});
}

/// Request did not complete within the allowed time.
final class TimeoutFailure extends Failure {
  const TimeoutFailure({super.message = 'Request timed out', super.cause});
}

/// All retry attempts exhausted.
final class RetryExhaustedFailure extends Failure {
  const RetryExhaustedFailure({
    required super.message,
    required this.attempts,
    super.cause,
  });
  final int attempts;
}

// ── Cache ─────────────────────────────────────────────────────────────────────

/// Cache read/write failed or returned corrupt data.
final class CacheFailure extends Failure {
  const CacheFailure({required super.message, super.cause});
}

/// Cache miss — no entry found for the key.
final class CacheMissFailure extends Failure {
  const CacheMissFailure({required this.key})
      : super(message: 'No cache entry for key: $key');
  final String key;
}

// ── Auth ──────────────────────────────────────────────────────────────────────

final class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({super.message = 'Unauthorized', super.cause});
}

final class SessionExpiredFailure extends Failure {
  const SessionExpiredFailure({super.message = 'Session expired', super.cause});
}

// ── Domain ────────────────────────────────────────────────────────────────────

/// Business rule violation (e.g. insufficient balance, invalid state).
final class DomainFailure extends Failure {
  const DomainFailure({required super.message, super.cause});
}

/// Input validation failed.
final class ValidationFailure extends Failure {
  const ValidationFailure({required super.message, this.field, super.cause});
  final String? field;
}

// ── Unknown ───────────────────────────────────────────────────────────────────

final class UnknownFailure extends Failure {
  const UnknownFailure({super.message = 'An unexpected error occurred', super.cause});
}
