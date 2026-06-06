import 'dart:async';
import 'dart:collection';

import 'package:defifundr_mobile/core/event_bus/app_event.dart';
import 'package:defifundr_mobile/core/event_bus/event_middleware.dart';
import 'package:defifundr_mobile/core/event_bus/event_subscription.dart';

export 'app_event.dart';
export 'event_middleware.dart';
export 'event_subscription.dart';

const _bufferCapacity = 64;

class EventBus {
  EventBus._();

  static final instance = EventBus._();

  final _middlewares = <EventMiddleware>[];
  final _buffer = Queue<AppEvent>();
  final _controller = StreamController<AppEvent>.broadcast();

  void addMiddleware(EventMiddleware middleware) =>
      _middlewares.add(middleware);

  Future<void> emit(AppEvent event) async {
    AppEvent? current = event;

    for (final middleware in _middlewares) {
      current = await middleware(current!);
      if (current == null) return;
    }

    if (_buffer.length >= _bufferCapacity) _buffer.removeFirst();
    _buffer.addLast(current!);

    _controller.add(current);
  }

  EventSubscription subscribe<T extends AppEvent>(void Function(T) onEvent) {
    final sub = _controller.stream
        .where((e) => e is T)
        .cast<T>()
        .listen(onEvent);
    return EventSubscription(sub);
  }

  EventSubscription subscribeOnce<T extends AppEvent>(
    void Function(T) onEvent,
  ) {
    late final EventSubscription subscription;
    final sub = _controller.stream
        .where((e) => e is T)
        .cast<T>()
        .listen((event) {
      onEvent(event);
      subscription.cancel();
    });
    subscription = EventSubscription(sub);
    return subscription;
  }

  void reset() => _middlewares.clear();

  void dispose() => _controller.close();
}
