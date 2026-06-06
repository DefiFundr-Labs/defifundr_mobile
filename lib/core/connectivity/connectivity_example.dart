// ignore_for_file: unused_element
// This file is for documentation purposes only — not imported anywhere.

import 'package:defifundr_mobile/core/cache/app_cache.dart';
import 'package:defifundr_mobile/core/connectivity/connectivity_service.dart';
import 'package:defifundr_mobile/core/connectivity/operation_queue.dart';
import 'package:defifundr_mobile/core/event_bus/event_bus.dart';
import 'package:defifundr_mobile/core/event_bus/event_bus_scope.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ─────────────────────────────────────────────────────────────────────────────
// 1. Check connectivity — instant, no async needed
// ─────────────────────────────────────────────────────────────────────────────

void _checkExample() {
  if (ConnectivityService.instance.isOnline) {
    // safe to make API calls
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 2. Enqueue a payment — uses retryableTE internally
//
//    Online  → executes immediately via RetryPolicy
//    Offline → stored, replayed automatically when internet returns
//    Failure → retried per policy, then QueuedOperationFailed emitted
// ─────────────────────────────────────────────────────────────────────────────

Future<void> _submitPayment(String paymentId, double amount) =>
    OperationQueue.instance.enqueue(
      () async {
        // await paymentRepository.submit(paymentId, amount);
      },
      label: 'submit_payment_$paymentId',
      retryPolicy: RetryPolicy.decorrelatedJitter(maxAttempts: 3),
    );

// ─────────────────────────────────────────────────────────────────────────────
// 3. BLoC reacting to connectivity and queue events
// ─────────────────────────────────────────────────────────────────────────────

sealed class _PaymentEvent {}
class _Refresh extends _PaymentEvent {}
class _SetOffline extends _PaymentEvent {}
class _SetOnline extends _PaymentEvent {}
class _OperationFailed extends _PaymentEvent {
  _OperationFailed(this.operationId);
  final String operationId;
}

sealed class _PaymentState {}
class _Idle extends _PaymentState {}
class _Offline extends _PaymentState {}
class _Failed extends _PaymentState {
  _Failed(this.operationId);
  final String operationId;
}

class _PaymentBloc extends Bloc<_PaymentEvent, _PaymentState>
    with EventBusScope {
  _PaymentBloc() : super(_Idle()) {
    on<_Refresh>((_, emit) {/* reload payments */});
    on<_SetOffline>((_, emit) => emit(_Offline()));
    on<_SetOnline>((_, emit) { emit(_Idle()); add(_Refresh()); });
    on<_OperationFailed>((event, emit) => emit(_Failed(event.operationId)));

    listenTo<ConnectivityChanged>((e) {
      add(e.isOnline ? _SetOnline() : _SetOffline());
    });

    listenTo<QueuedOperationSucceeded>((e) => add(_Refresh()));

    listenTo<QueuedOperationFailed>((e) => add(_OperationFailed(e.operationId)));
  }

  @override
  Future<void> close() {
    clearSubscriptions();
    return super.close();
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 4. Invoice submission — critical operation, more retries + circuit breaker
// ─────────────────────────────────────────────────────────────────────────────

Future<void> _submitInvoice(String invoiceId) =>
    OperationQueue.instance.enqueue(
      () async {
        // await invoiceRepository.submit(invoiceId);
      },
      label: 'submit_invoice_$invoiceId',
      retryPolicy: RetryPolicy.circuitBreaker(
        failureThreshold: 3,
        maxAttempts: 10,
        resetTimeout: const Duration(seconds: 30),
      ),
    );

// ─────────────────────────────────────────────────────────────────────────────
// 5. retryableTE standalone — for one-off calls outside a repository
// ─────────────────────────────────────────────────────────────────────────────

Future<void> _standaloneExample(String userId) async {
  final result = await retryableTE(
    () async {
      // await apiClient.syncWallet(userId);
    },
    policy: RetryPolicy.exponentialBackoff(maxAttempts: 4),
    toFailure: (e) => NetworkFailure(cause: e),
  ).run();

  result.fold(
    (failure) { /* log or surface failure.message */ },
    (_) { /* sync succeeded */ },
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// 6. Offline guard middleware — drop bus events when offline
// ─────────────────────────────────────────────────────────────────────────────

void _offlineGuardMiddleware() {
  EventBus.instance.addMiddleware((event) async {
    if (event is ConnectivityChanged) return event; // always let through
    if (!ConnectivityService.instance.isOnline) return null; // drop
    return event;
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// 7. Combining connectivity + cache + fpdart
//    Guard the fetch: only hit network if online, fall back to cache if not.
// ─────────────────────────────────────────────────────────────────────────────

TaskEither<Failure, Map<String, dynamic>> _guardedFetch(String key) {
  if (!ConnectivityService.instance.isOnline) {
    return AppCache.prefs.fetch(
      key,
      () => Future.error(NetworkFailure()),
      policy: CachePolicy.useCache,
    );
  }

  return AppCache.prefs.fetch(
    key,
    () async {
      // await apiClient.get(key);
      return <String, dynamic>{};
    },
    policy: CachePolicy.cacheFirst,
    retryPolicy: RetryPolicy.exponentialBackoff(),
  );
}
