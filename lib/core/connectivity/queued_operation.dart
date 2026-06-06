typedef OperationCallback = Future<void> Function();

class QueuedOperation {
  QueuedOperation({
    required this.id,
    required this.execute,
    this.label,
    this.retryLimit = 3,
  }) : _attempts = 0;

  final String id;
  final OperationCallback execute;
  final String? label;
  final int retryLimit;

  int _attempts;
  int get attempts => _attempts;
  bool get canRetry => _attempts < retryLimit;

  void recordAttempt() => _attempts++;
}
