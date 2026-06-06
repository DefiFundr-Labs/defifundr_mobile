// ignore_for_file: unused_element
// This file is for documentation purposes only — not imported anywhere.

import 'package:defifundr_mobile/core/cache/app_cache.dart';
import 'package:defifundr_mobile/core/event_bus/event_bus.dart';
import 'package:defifundr_mobile/core/event_bus/event_bus_scope.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Domain entity
// ─────────────────────────────────────────────────────────────────────────────

class _Invoice {
  const _Invoice({required this.id, required this.amount});
  final String id;
  final double amount;

  factory _Invoice.fromJson(dynamic json) => _Invoice(
        id: (json as Map<String, dynamic>)['id'] as String,
        amount: json['amount'] as double,
      );
}

// ─────────────────────────────────────────────────────────────────────────────
// 1. Three caches — pick the right one for the data sensitivity
//
//    AppCache.memory  — fast, cleared on restart.     UI state, paginated lists
//    AppCache.prefs   — persistent, plain text.       API responses, flags
//    AppCache.secure  — persistent, encrypted.        Tokens, wallet keys
// ─────────────────────────────────────────────────────────────────────────────

Future<void> _basicExample() async {
  await AppCache.prefs.set('exchange_rates', {'ETH': 3200.0},
      ttl: const Duration(minutes: 1));
  await AppCache.secure.set('auth_token', 'eyJhbGci...',
      ttl: const Duration(hours: 1));
  await AppCache.memory.set('invoice_page_1', ['inv-1', 'inv-2']);

  await AppCache.prefs.invalidate('exchange_rates');
  await AppCache.prefs.invalidateWhere((key) => key.startsWith('invoice_'));
}

// ─────────────────────────────────────────────────────────────────────────────
// 2. Repository — Future-based (simple) vs TaskEither-based (composable)
// ─────────────────────────────────────────────────────────────────────────────

class _InvoiceRepository {
  // Future-based — throws on failure, simpler to read.
  Future<List<_Invoice>> getInvoices(String workspaceId) =>
      AppCache.prefs.fetch(
        'invoices_$workspaceId',
        () => _remote(workspaceId),
        ttl: const Duration(minutes: 3),
        policy: CachePolicy.cacheFirst,
        retryPolicy: RetryPolicy.exponentialBackoff(maxAttempts: 3),
        fromJson: (json) => (json as List).map(_Invoice.fromJson).toList(),
      );

  // TaskEither-based — never throws, composes with flatMap/map.
  TaskEither<Failure, List<_Invoice>> getInvoicesTE(String workspaceId) =>
      AppCache.prefs.fetchTE(
        'invoices_$workspaceId',
        () => _remote(workspaceId),
        ttl: const Duration(minutes: 3),
        policy: CachePolicy.cacheFirst,
        retryPolicy: RetryPolicy.exponentialBackoff(maxAttempts: 3),
        fromJson: (json) => (json as List).map(_Invoice.fromJson).toList(),
        toFailure: (e) => ServerFailure(message: e.toString()),
      );

  Future<List<_Invoice>> _remote(String workspaceId) async => [];
}

// ─────────────────────────────────────────────────────────────────────────────
// 3. BLoC — consuming TaskEither with fold
// ─────────────────────────────────────────────────────────────────────────────

sealed class _InvoiceEvent {}
class _Load extends _InvoiceEvent { _Load(this.workspaceId); final String workspaceId; }
class _FreshData extends _InvoiceEvent { _FreshData(this.invoices); final List<_Invoice> invoices; }

sealed class _InvoiceState {}
class _Loading extends _InvoiceState {}
class _Loaded extends _InvoiceState { _Loaded(this.invoices); final List<_Invoice> invoices; }
class _Error extends _InvoiceState { _Error(this.failure); final Failure failure; }

class _InvoiceBloc extends Bloc<_InvoiceEvent, _InvoiceState>
    with EventBusScope {
  _InvoiceBloc(this._repo, this._workspaceId) : super(_Loading()) {
    on<_Load>((event, emit) async {
      emit(_Loading());
      final result = await _repo.getInvoicesTE(_workspaceId).run();
      result.fold(
        (failure) => emit(_Error(failure)),
        (invoices) => emit(_Loaded(invoices)),
      );
    });

    on<_FreshData>((event, emit) => emit(_Loaded(event.invoices)));

    // Background revalidation finished — update UI silently.
    // CacheUpdated is generic at runtime, so filter by key.
    listenTo<CacheUpdated>((e) {
      if (e.key == 'invoices_$_workspaceId') {
        add(_FreshData((e.data as List).cast<_Invoice>()));
      }
    });
  }

  final _InvoiceRepository _repo;
  final String _workspaceId;

  @override
  Future<void> close() {
    clearSubscriptions();
    return super.close();
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 4. Composing TaskEithers in a UseCase
// ─────────────────────────────────────────────────────────────────────────────

class _CreateInvoiceUseCase {
  const _CreateInvoiceUseCase(this._repo);
  final _InvoiceRepository _repo;

  // Validate → fetch existing → return count. Short-circuits on any failure.
  TaskEither<Failure, int> countForWorkspace(String workspaceId) =>
      _validateId(workspaceId)
          .flatMap((_) => _repo.getInvoicesTE(workspaceId))
          .map((invoices) => invoices.length);

  TaskEither<Failure, Unit> _validateId(String id) =>
      TaskEither.fromEither(
        id.isNotEmpty
            ? right(unit)
            : left(const ValidationFailure(message: 'Workspace ID is empty')),
      );
}

// ─────────────────────────────────────────────────────────────────────────────
// 5. Auth token lifecycle — secure cache
// ─────────────────────────────────────────────────────────────────────────────

Future<void> _onLogin(String token) =>
    AppCache.secure.set('auth_token', token, ttl: const Duration(hours: 24));

Future<void> _onLogout() async {
  await AppCache.secure.clear();
  await AppCache.prefs.clear();
  await AppCache.memory.clear();
}
