// ignore_for_file: unused_element
// This file is for documentation purposes only — not imported anywhere.

import 'package:defifundr_mobile/core/event_bus/event_bus.dart';
import 'package:defifundr_mobile/core/event_bus/event_bus_scope.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ─────────────────────────────────────────────────────────────────────────────
// 1. Emitting an event from anywhere (screen, BLoC, service)
// ─────────────────────────────────────────────────────────────────────────────

void _emitExample() {
  EventBus.instance.emit(const UserLoggedIn(userId: 'u-123'));
  EventBus.instance.emit(const PaymentCompleted(paymentId: 'p-456', amount: 250.0));
}

// ─────────────────────────────────────────────────────────────────────────────
// 2. BLoC with EventBusScope mixin
//    - Use listenTo<T>() to subscribe to AppEvents from the bus
//    - Use Bloc.on<E>() as normal for internal BLoC events
//    - Call clearSubscriptions() in close()
// ─────────────────────────────────────────────────────────────────────────────

abstract class _DashboardEvent {}

class _RefreshDashboard extends _DashboardEvent {}

abstract class _DashboardState {}

class _InitialState extends _DashboardState {}

class _DashboardBloc extends Bloc<_DashboardEvent, _DashboardState>
    with EventBusScope {
  _DashboardBloc() : super(_InitialState()) {
    on<_RefreshDashboard>((_, emit) {/* rebuild dashboard */});

    listenTo<PaymentCompleted>((e) => add(_RefreshDashboard()));
    listenTo<WorkspaceSwitched>((e) => add(_RefreshDashboard()));
  }

  @override
  Future<void> close() {
    clearSubscriptions();
    return super.close();
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 3. Subscribing manually outside a BLoC (service, manager, etc.)
//    Store the subscription and cancel it in dispose().
// ─────────────────────────────────────────────────────────────────────────────

class _NotificationService {
  _NotificationService() {
    _paymentSub = EventBus.instance.subscribe<PaymentCompleted>((e) {
      // show push notification for e.paymentId
    });
  }

  late final EventSubscription _paymentSub;

  void dispose() => _paymentSub.cancel();
}

// ─────────────────────────────────────────────────────────────────────────────
// 4. Subscribe once — auto-cancels after the first matching event
// ─────────────────────────────────────────────────────────────────────────────

void _subscribeOnceExample() {
  EventBus.instance.subscribeOnce<UserLoggedIn>((e) {
    // runs exactly once, then subscription is cancelled automatically
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// 5. Middleware — log every event, or drop specific ones
// ─────────────────────────────────────────────────────────────────────────────

void _middlewareExample() {
  // Logging middleware — pass every event through unchanged.
  EventBus.instance.addMiddleware((event) async {
    // Logger().d('[EventBus] ${event.name} @ ${event.timestamp}');
    return event;
  });

  EventBus.instance.addMiddleware((event) async {
    if (event is WalletConnected && _isOffline()) return null;
    return event;
  });
}

bool _isOffline() => false;
