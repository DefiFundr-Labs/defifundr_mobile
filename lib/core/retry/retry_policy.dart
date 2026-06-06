import 'dart:async';
import 'dart:math';

abstract class RetryPolicy {
  const RetryPolicy();

  /// Return true to retry, false to give up.
  /// Implementations are responsible for applying their own delay before returning.
  FutureOr<bool> shouldRetry(int attempts);

  // ── Factories ──────────────────────────────────────────────────────────────

  /// No retries — fails immediately on the first error.
  factory RetryPolicy.noRetry() = _NoRetry;

  /// Fixed delay between every retry.
  factory RetryPolicy.fixedInterval({
    Duration delay,
    int maxAttempts,
  }) = _FixedInterval;

  /// Delay doubles after each attempt: base * 2^attempt, capped at maxDelay.
  factory RetryPolicy.exponentialBackoff({
    Duration baseDelay,
    int maxAttempts,
    int multiplier,
    Duration maxDelay,
  }) = _ExponentialBackoff;

  /// Delay grows linearly: base * multiplier * attempt, capped at maxDelay.
  factory RetryPolicy.linearBackoff({
    Duration baseDelay,
    int maxAttempts,
    int multiplier,
    Duration maxDelay,
  }) = _LinearBackoff;

  /// Random delay between baseDelay and maxDelay — avoids thundering herd.
  factory RetryPolicy.randomisedBackoff({
    Duration baseDelay,
    Duration maxDelay,
    int maxAttempts,
  }) = _RandomisedBackoff;

  /// Exponential backoff with random jitter — best for distributed/API calls.
  factory RetryPolicy.decorrelatedJitter({
    Duration baseDelay,
    int maxAttempts,
    int multiplier,
    Duration maxDelay,
    double jitterFactor,
  }) = _DecorrelatedJitter;

  /// Circuit breaker — stops retrying after [failureThreshold] failures,
  /// waits [resetTimeout], then allows a limited probe before reopening.
  factory RetryPolicy.circuitBreaker({
    int failureThreshold,
    int maxAttempts,
    Duration resetTimeout,
    int halfOpenThreshold,
    ({Duration start, Duration end}) coolDownTime,
  }) = _CircuitBreaker;
}

// ── No retry ──────────────────────────────────────────────────────────────────

final class _NoRetry implements RetryPolicy {
  const _NoRetry();

  @override
  FutureOr<bool> shouldRetry(int attempts) => false;
}

// ── Fixed interval ────────────────────────────────────────────────────────────

final class _FixedInterval implements RetryPolicy {
  const _FixedInterval({
    this.delay = const Duration(seconds: 2),
    this.maxAttempts = 3,
  });

  final Duration delay;
  final int maxAttempts;

  @override
  FutureOr<bool> shouldRetry(int attempts) async {
    if (attempts >= maxAttempts) return false;
    await Future.delayed(delay);
    return true;
  }
}

// ── Exponential backoff ───────────────────────────────────────────────────────

final class _ExponentialBackoff implements RetryPolicy {
  const _ExponentialBackoff({
    this.baseDelay = const Duration(seconds: 2),
    this.maxAttempts = 5,
    this.multiplier = 2,
    this.maxDelay = const Duration(seconds: 30),
  });

  final Duration baseDelay;
  final int maxAttempts;
  final int multiplier;
  final Duration maxDelay;

  @override
  FutureOr<bool> shouldRetry(int attempts) async {
    if (attempts >= maxAttempts) return false;
    final ms = (baseDelay.inMilliseconds * pow(multiplier, attempts)).toInt();
    await Future.delayed(Duration(milliseconds: ms.clamp(0, maxDelay.inMilliseconds)));
    return true;
  }
}

// ── Linear backoff ────────────────────────────────────────────────────────────

final class _LinearBackoff implements RetryPolicy {
  const _LinearBackoff({
    this.baseDelay = const Duration(seconds: 2),
    this.maxAttempts = 5,
    this.multiplier = 1,
    this.maxDelay = const Duration(seconds: 30),
  });

  final Duration baseDelay;
  final int maxAttempts;
  final int multiplier;
  final Duration maxDelay;

  @override
  FutureOr<bool> shouldRetry(int attempts) async {
    if (attempts >= maxAttempts) return false;
    final ms = baseDelay.inMilliseconds * multiplier * attempts;
    await Future.delayed(Duration(milliseconds: ms.clamp(0, maxDelay.inMilliseconds)));
    return true;
  }
}

// ── Randomised backoff ────────────────────────────────────────────────────────

final class _RandomisedBackoff implements RetryPolicy {
  _RandomisedBackoff({
    this.baseDelay = const Duration(seconds: 1),
    this.maxDelay = const Duration(seconds: 30),
    this.maxAttempts = 5,
  }) : assert(baseDelay <= maxDelay);

  final Duration baseDelay;
  final Duration maxDelay;
  final int maxAttempts;

  @override
  FutureOr<bool> shouldRetry(int attempts) async {
    if (attempts >= maxAttempts) return false;
    final range = maxDelay.inMilliseconds - baseDelay.inMilliseconds;
    final ms = Random().nextInt(range) + baseDelay.inMilliseconds;
    await Future.delayed(Duration(milliseconds: ms));
    return true;
  }
}

// ── Decorrelated jitter ───────────────────────────────────────────────────────

final class _DecorrelatedJitter implements RetryPolicy {
  const _DecorrelatedJitter({
    this.baseDelay = const Duration(seconds: 1),
    this.maxAttempts = 5,
    this.multiplier = 2,
    this.maxDelay = const Duration(seconds: 30),
    this.jitterFactor = 0.5,
  });

  final Duration baseDelay;
  final int maxAttempts;
  final int multiplier;
  final Duration maxDelay;
  final double jitterFactor;

  @override
  FutureOr<bool> shouldRetry(int attempts) async {
    if (attempts >= maxAttempts) return false;
    final base = (baseDelay.inMilliseconds * pow(multiplier, attempts)).toInt();
    final jitter = (Random().nextDouble() * base * jitterFactor).toInt();
    final ms = (base + jitter).clamp(0, maxDelay.inMilliseconds);
    await Future.delayed(Duration(milliseconds: ms));
    return true;
  }
}

// ── Circuit breaker ───────────────────────────────────────────────────────────

enum _CircuitState { closed, open, halfOpen }

final class _CircuitBreaker implements RetryPolicy {
  _CircuitBreaker({
    this.failureThreshold = 4,
    this.maxAttempts = 10,
    this.resetTimeout = const Duration(seconds: 10),
    this.halfOpenThreshold = 2,
    this.coolDownTime = (
      start: const Duration(seconds: 1),
      end: const Duration(seconds: 2),
    ),
  });

  final int failureThreshold;
  final int maxAttempts;
  final Duration resetTimeout;
  final int halfOpenThreshold;
  final ({Duration start, Duration end}) coolDownTime;

  _CircuitState _state = _CircuitState.closed;
  int _halfOpenAttempts = 0;

  @override
  FutureOr<bool> shouldRetry(int attempts) async {
    if (attempts >= maxAttempts) {
      _state = _CircuitState.closed;
      _halfOpenAttempts = 0;
      return false;
    }
    return _transition(attempts);
  }

  Future<bool> _transition(int attempts) async {
    switch (_state) {
      case _CircuitState.closed:
        if (attempts >= failureThreshold) {
          _state = _CircuitState.open;
          return _transition(attempts);
        }
        return true;

      case _CircuitState.open:
        await Future.delayed(resetTimeout);
        _state = _CircuitState.halfOpen;
        _halfOpenAttempts = 0;
        return _transition(attempts);

      case _CircuitState.halfOpen:
        if (attempts == 0) {
          _state = _CircuitState.closed;
        } else if (_halfOpenAttempts < halfOpenThreshold) {
          _halfOpenAttempts++;
          if (_halfOpenAttempts == halfOpenThreshold) {
            final range = coolDownTime.end.inMilliseconds - coolDownTime.start.inMilliseconds;
            final coolDown = Random().nextInt(range) + coolDownTime.start.inMilliseconds;
            await Future.delayed(Duration(milliseconds: coolDown));
            _state = _CircuitState.open;
          }
        }
        return true;
    }
  }
}
