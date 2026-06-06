// ignore_for_file: unused_element
// This file is for documentation purposes only — not imported anywhere.

import 'package:defifundr_mobile/core/connectivity/connectivity_service.dart';
import 'package:defifundr_mobile/core/connectivity/operation_queue.dart';
import 'package:defifundr_mobile/core/event_bus/event_bus.dart';
import 'package:defifundr_mobile/core/event_bus/event_bus_scope.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ─────────────────────────────────────────────────────────────────────────────
// 1. Check connectivity anywhere — instant, no async needed
// ─────────────────────────────────────────────────────────────────────────────

void _checkExample() {
  if (ConnectivityService.instance.isOnline) {
    // safe to make API calls
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 2. Enqueue a payment submission
//
//    Online  → executes immediately
//    Offline → stored, replayed automatically when internet returns
//    Failure → retried up to 3x, then dropped with QueuedOperationFailed event
// ─────────────────────────────────────────────────────────────────────────────

Future<void> _submitPayment(String paymentId, double amount) async {
  await OperationQueue.instance.enqueue(
    () async {
      // await paymentRepository.submit(paymentId, amount);
    },
    label: 'submit_payment_$paymentId',
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// 3. BLoC reacting to connectivity and queue events
// ─────────────────────────────────────────────────────────────────────────────

abstract class _PaymentEvent {}

class _Refresh extends _PaymentEvent {}

class _SetOffline extends _PaymentEvent {}

class _SetOnline extends _PaymentEvent {}

class _OperationFailed extends _PaymentEvent {
  _OperationFailed(this.operationId);
  final String operationId;
}

abstract class _PaymentState {}

class _IdleState extends _PaymentState {}

class _PaymentBloc extends Bloc<_PaymentEvent, _PaymentState>
    with EventBusScope {
  _PaymentBloc() : super(_IdleState()) {
    on<_Refresh>((_, emit) {/* reload payments */});
    on<_SetOffline>((_, emit) {/* show offline banner */});
    on<_SetOnline>((_, emit) {/* hide banner, maybe refresh */});
    on<_OperationFailed>((event, emit) {/* show retry prompt */});

    listenTo<ConnectivityChanged>((e) {
      add(e.isOnline ? _SetOnline() : _SetOffline());
    });

    listenTo<QueuedOperationSucceeded>((e) {
      add(_Refresh());
    });

    listenTo<QueuedOperationFailed>((e) {
      add(_OperationFailed(e.operationId));
    });
  }

  @override
  Future<void> close() {
    clearSubscriptions();
    return super.close();
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 4. Invoice submission — queued with custom retry limit
// ─────────────────────────────────────────────────────────────────────────────

Future<void> _submitInvoice(String invoiceId) async {
  await OperationQueue.instance.enqueue(
    () async {
      // await invoiceRepository.submit(invoiceId);
    },
    label: 'submit_invoice_$invoiceId',
    retryLimit: 5, // invoices are critical — retry more aggressively
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// 5. Middleware — block all emissions when offline (optional hardening)
// ─────────────────────────────────────────────────────────────────────────────

void _offlineGuardMiddleware() {
  EventBus.instance.addMiddleware((event) async {
    // Always allow connectivity events through — they are the signal itself.
    if (event is ConnectivityChanged) return event;

    if (!ConnectivityService.instance.isOnline) return null; // drop
    return event;
  });
}
