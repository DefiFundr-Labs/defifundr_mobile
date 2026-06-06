import 'package:defifundr_mobile/core/retry/retryable.dart';

typedef OperationCallback = Future<void> Function();

class QueuedOperation {
  QueuedOperation({
    required this.id,
    required this.execute,
    this.label,
    RetryPolicy? retryPolicy,
  }) : retryPolicy = retryPolicy ?? RetryPolicy.exponentialBackoff(),
       _attempts = 0;

  final String id;
  final OperationCallback execute;
  final String? label;
  final RetryPolicy retryPolicy;

  int _attempts;
  int get attempts => _attempts;

  void recordAttempt() => _attempts++;
}
