import 'package:defifundr_mobile/core/event_bus/event_bus.dart';

/// Mixin for BLoCs or services that need to subscribe to [EventBus] events.
/// Call [clearSubscriptions] in your `close()` / `dispose()` method.
///
/// ```dart
/// class DashboardBloc extends Bloc<DashboardEvent, DashboardState>
///     with EventBusScope {
///   DashboardBloc() : super(const DashboardState.initial()) {
///     listenTo<PaymentCompleted>((e) => add(const DashboardEvent.refresh()));
///   }
///
///   @override
///   Future<void> close() {
///     clearSubscriptions();
///     return super.close();
///   }
/// }
/// ```
mixin EventBusScope {
  final List<EventSubscription> _subscriptions = [];

  /// Subscribe to [T] events for the lifetime of this scope.
  void listenTo<T extends AppEvent>(void Function(T) onEvent) {
    _subscriptions.add(EventBus.instance.subscribe<T>(onEvent));
  }

  /// Subscribe to [T] events once, then auto-cancel.
  void listenOnce<T extends AppEvent>(void Function(T) onEvent) {
    _subscriptions.add(EventBus.instance.subscribeOnce<T>(onEvent));
  }

  /// Cancel all active subscriptions. Call in `close()` / `dispose()`.
  void clearSubscriptions() {
    for (final s in _subscriptions) {
      s.cancel();
    }
    _subscriptions.clear();
  }
}
