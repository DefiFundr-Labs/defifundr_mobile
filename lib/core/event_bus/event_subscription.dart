import 'dart:async';

class EventSubscription {
  EventSubscription(this._subscription) : _cancelled = false;

  final StreamSubscription<dynamic> _subscription;
  bool _cancelled;

  bool get isActive => !_cancelled;

  Future<void> cancel() async {
    if (_cancelled) return;
    _cancelled = true;
    await _subscription.cancel();
  }
}
