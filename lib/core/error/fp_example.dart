// ignore_for_file: unused_element
// This file is for documentation purposes only — not imported anywhere.
//
// Full stack example: DataSource → Repository → UseCase → BLoC
// Every layer returns TaskEither<Failure, T> — no try/catch, no throwing.

import 'package:defifundr_mobile/core/cache/app_cache.dart';
import 'package:defifundr_mobile/core/event_bus/event_bus_scope.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Domain entity
// ─────────────────────────────────────────────────────────────────────────────

class Invoice {
  const Invoice({required this.id, required this.amount, required this.status});
  final String id;
  final double amount;
  final String status;

  factory Invoice.fromJson(dynamic json) => Invoice(
        id: (json as Map<String, dynamic>)['id'] as String,
        amount: json['amount'] as double,
        status: json['status'] as String,
      );
}

// ─────────────────────────────────────────────────────────────────────────────
// Repository interface (domain layer — pure Dart, no Flutter)
// ─────────────────────────────────────────────────────────────────────────────

abstract interface class InvoiceRepository {
  TaskEither<Failure, List<Invoice>> getInvoices(String workspaceId);
  TaskEither<Failure, Invoice> getInvoice(String invoiceId);
  TaskEither<Failure, Unit> submitInvoice(Invoice invoice);
}

// ─────────────────────────────────────────────────────────────────────────────
// Repository implementation (data layer)
// ─────────────────────────────────────────────────────────────────────────────

class InvoiceRepositoryImpl implements InvoiceRepository {
  @override
  TaskEither<Failure, List<Invoice>> getInvoices(String workspaceId) =>
      AppCache.prefs.fetch(
        'invoices_$workspaceId',
        () => _remoteGetInvoices(workspaceId),
        ttl: const Duration(minutes: 3),
        policy: CachePolicy.cacheFirst,
        retryPolicy: RetryPolicy.exponentialBackoff(maxAttempts: 3),
        fromJson: (json) => (json as List).map(Invoice.fromJson).toList(),
        onError: (e) => ServerFailure(message: e.toString()),
      );

  @override
  TaskEither<Failure, Invoice> getInvoice(String invoiceId) =>
      retryableTE(
        () => _remoteGetInvoice(invoiceId),
        toFailure: (e) => ServerFailure(message: e.toString()),
        policy: RetryPolicy.exponentialBackoff(),
      );

  @override
  TaskEither<Failure, Unit> submitInvoice(Invoice invoice) =>
      retryableTE(
        () => _remoteSubmitInvoice(invoice),
        toFailure: (e) => ServerFailure(message: e.toString()),
        policy: RetryPolicy.decorrelatedJitter(maxAttempts: 5),
      );

  // Simulated remote calls
  Future<List<Invoice>> _remoteGetInvoices(String workspaceId) async => [];
  Future<Invoice> _remoteGetInvoice(String id) async =>
      Invoice(id: id, amount: 0, status: 'draft');
  Future<Unit> _remoteSubmitInvoice(Invoice invoice) async => unit;
}

// ─────────────────────────────────────────────────────────────────────────────
// UseCase (domain layer)
// ─────────────────────────────────────────────────────────────────────────────

class GetInvoicesUseCase {
  const GetInvoicesUseCase(this._repo);
  final InvoiceRepository _repo;

  TaskEither<Failure, List<Invoice>> call(String workspaceId) =>
      _repo.getInvoices(workspaceId);
}

class SubmitInvoiceUseCase {
  const SubmitInvoiceUseCase(this._repo);
  final InvoiceRepository _repo;

  /// Validate first, then submit. Both steps compose cleanly.
  TaskEither<Failure, Unit> call(Invoice invoice) =>
      _validate(invoice).flatMap((_) => _repo.submitInvoice(invoice));

  TaskEither<Failure, Unit> _validate(Invoice invoice) =>
      TaskEither.fromEither(
        invoice.amount > 0
            ? right(unit)
            : left(const ValidationFailure(
                message: 'Invoice amount must be greater than zero',
                field: 'amount',
              )),
      );
}

// ─────────────────────────────────────────────────────────────────────────────
// BLoC (presentation layer)
// ─────────────────────────────────────────────────────────────────────────────

sealed class InvoiceEvent {}
class LoadInvoices extends InvoiceEvent { LoadInvoices(this.workspaceId); final String workspaceId; }
class SubmitInvoice extends InvoiceEvent { SubmitInvoice(this.invoice); final Invoice invoice; }

sealed class InvoiceState {}
class InvoiceInitial extends InvoiceState {}
class InvoiceLoading extends InvoiceState {}
class InvoiceLoaded extends InvoiceState { InvoiceLoaded(this.invoices); final List<Invoice> invoices; }
class InvoiceSubmitted extends InvoiceState {}
class InvoiceError extends InvoiceState { InvoiceError(this.failure); final Failure failure; }

class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> with EventBusScope {
  InvoiceBloc(this._getInvoices, this._submitInvoice) : super(InvoiceInitial()) {
    on<LoadInvoices>(_onLoad);
    on<SubmitInvoice>(_onSubmit);
  }

  final GetInvoicesUseCase _getInvoices;
  final SubmitInvoiceUseCase _submitInvoice;

  Future<void> _onLoad(LoadInvoices event, Emitter<InvoiceState> emit) async {
    emit(InvoiceLoading());

    // .run() executes the TaskEither and returns Either<Failure, T>
    final result = await _getInvoices(event.workspaceId).run();

    // fold: left = failure, right = success — exhaustive, no if/else
    result.fold(
      (failure) => emit(InvoiceError(failure)),
      (invoices) => emit(InvoiceLoaded(invoices)),
    );
  }

  Future<void> _onSubmit(SubmitInvoice event, Emitter<InvoiceState> emit) async {
    emit(InvoiceLoading());

    final result = await _submitInvoice(event.invoice).run();

    result.fold(
      (failure) => emit(InvoiceError(failure)),
      (_) => emit(InvoiceSubmitted()),
    );
  }

  @override
  Future<void> close() {
    clearSubscriptions();
    return super.close();
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Composing TaskEithers
// ─────────────────────────────────────────────────────────────────────────────

// flatMap — chain operations, short-circuits on first Left
TaskEither<Failure, String> _pipeline(String userId) =>
    retryableTE<String>(() async => 'token')           // get token
    .flatMap((token) => retryableTE(() async => userId)); // use token

// map — transform the Right value
TaskEither<Failure, int> _countInvoices(String workspaceId) =>
    InvoiceRepositoryImpl()
      .getInvoices(workspaceId)
      .map((invoices) => invoices.length);

// orElse — recover from a specific failure
TaskEither<Failure, List<Invoice>> _withFallback(String workspaceId) =>
    InvoiceRepositoryImpl()
      .getInvoices(workspaceId)
      .orElse((_) => TaskEither.right(const [])); // empty list on any failure

// getOrElse — collapse to a plain Future with a fallback value
Future<List<Invoice>> _withDefault(String workspaceId) =>
    InvoiceRepositoryImpl()
      .getInvoices(workspaceId)
      .getOrElse((_) => const [])
      .run();
