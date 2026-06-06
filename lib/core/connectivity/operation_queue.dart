import 'dart:collection';

import 'package:defifundr_mobile/core/connectivity/connectivity_service.dart';
import 'package:defifundr_mobile/core/connectivity/queued_operation.dart';
import 'package:defifundr_mobile/core/event_bus/event_bus.dart';
import 'package:logger/logger.dart';

final _log = Logger();
int _opCounter = 0;
String _nextId() => 'op_${++_opCounter}_${DateTime.now().millisecondsSinceEpoch}';

class OperationQueue {
  OperationQueue._();

  static final instance = OperationQueue._();

  final _queue = Queue<QueuedOperation>();
  bool _draining = false;

  /// Enqueue an operation.
  ///
  /// If online: executes immediately.
  /// If offline: stores in queue and replays on reconnect.
  Future<void> enqueue(
    OperationCallback execute, {
    String? id,
    String? label,
    int retryLimit = 3,
  }) async {
    final operation = QueuedOperation(
      id: id ?? _nextId(),
      execute: execute,
      label: label,
      retryLimit: retryLimit,
    );

    if (ConnectivityService.instance.isOnline) {
      await _run(operation);
    } else {
      _queue.addLast(operation);
      _log.i('[Queue] Offline — queued "${operation.label ?? operation.id}" '
          '(${_queue.length} pending)');
    }
  }

  /// Called by [ConnectivityService] via EventBus when connectivity restores.
  Future<void> drain() async {
    if (_draining || _queue.isEmpty) return;
    _draining = true;

    _log.i('[Queue] Online — draining ${_queue.length} operation(s)');

    while (_queue.isNotEmpty) {
      final operation = _queue.first;
      final success = await _run(operation);

      if (success) {
        _queue.removeFirst();
      } else if (!operation.canRetry) {
        _log.w('[Queue] Dropping "${operation.label ?? operation.id}" '
            'after ${operation.attempts} attempts');
        _queue.removeFirst();
        EventBus.instance
            .emit(QueuedOperationFailed(operationId: operation.id));
      } else {
        break;
      }
    }

    _draining = false;
  }

  Future<bool> _run(QueuedOperation operation) async {
    operation.recordAttempt();
    try {
      await operation.execute();
      EventBus.instance
          .emit(QueuedOperationSucceeded(operationId: operation.id));
      return true;
    } catch (e) {
      _log.e('[Queue] "${operation.label ?? operation.id}" failed: $e');
      return false;
    }
  }

  int get pendingCount => _queue.length;
  bool get isEmpty => _queue.isEmpty;
}
