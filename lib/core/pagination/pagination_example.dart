// ignore_for_file: unused_element
// This file is for documentation purposes only — not imported anywhere.

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:defifundr_mobile/core/cache/app_cache.dart';
import 'package:defifundr_mobile/core/pagination/paginator.dart';
import 'package:flutter/material.dart';
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
// 1. Repository — returns PaginatedResponse per page
// ─────────────────────────────────────────────────────────────────────────────

class _InvoiceRepository {
  TaskEither<Failure, PaginatedResponse<_Invoice>> getInvoicesPage({
    required int page,
    required int pageSize,
  }) =>
      AppCache.prefs.fetch(
        'invoices_page_$page',
        () => _remote(page, pageSize),
        ttl: const Duration(minutes: 3),
        policy: CachePolicy.cacheFirst,
        fromJson: (json) => PaginatedResponse.fromJson(
          json,
          fromJson: _Invoice.fromJson,
        ),
        onError: (e) => ServerFailure(message: e.toString()),
      );

  Future<PaginatedResponse<_Invoice>> _remote(int page, int pageSize) async =>
      PaginatedResponse(
        items: List.generate(pageSize, (i) => _Invoice(id: '$i', amount: 100)),
        hasMore: page < 5,
        total: 100,
      );
}

// ─────────────────────────────────────────────────────────────────────────────
// 2. BLoC — Paginator lives here, BLoC drives it
// ─────────────────────────────────────────────────────────────────────────────

sealed class _InvoiceEvent {}
class _Load extends _InvoiceEvent {}
class _LoadMore extends _InvoiceEvent {}
class _Refresh extends _InvoiceEvent {}

sealed class _InvoiceState {}
class _Initial extends _InvoiceState {}
class _Loading extends _InvoiceState {}
class _Loaded extends _InvoiceState {
  _Loaded(this.snapshot);
  final PaginatorSnapshot<_Invoice> snapshot;
}
class _LoadingMore extends _InvoiceState {
  _LoadingMore(this.snapshot);
  final PaginatorSnapshot<_Invoice> snapshot;
}
class _Error extends _InvoiceState {
  _Error(this.failure, {this.snapshot});
  final Failure failure;
  final PaginatorSnapshot<_Invoice>? snapshot;
}

class _InvoiceBloc extends Bloc<_InvoiceEvent, _InvoiceState> {
  _InvoiceBloc(this._repo) : super(_Initial()) {
    on<_Load>(_onLoad, transformer: droppable());
    on<_LoadMore>(_onLoadMore, transformer: droppable());
    on<_Refresh>(_onRefresh, transformer: restartable());
  }

  final _InvoiceRepository _repo;
  late final _paginator = Paginator(fetch: _repo.getInvoicesPage);

  Future<void> _onLoad(_Load event, Emitter<_InvoiceState> emit) async {
    emit(_Loading());
    final result = await _paginator.loadNext().run();
    result.fold(
      (failure) => emit(_Error(failure)),
      (snapshot) => emit(_Loaded(snapshot)),
    );
  }

  Future<void> _onLoadMore(_LoadMore event, Emitter<_InvoiceState> emit) async {
    final current = state;
    if (current is! _Loaded || !current.snapshot.hasMore) return;

    emit(_LoadingMore(current.snapshot));
    final result = await _paginator.loadNext().run();
    result.fold(
      (failure) => emit(_Error(failure, snapshot: current.snapshot)),
      (snapshot) => emit(_Loaded(snapshot)),
    );
  }

  Future<void> _onRefresh(_Refresh event, Emitter<_InvoiceState> emit) async {
    emit(_Loading());
    final result = await _paginator.refresh().run();
    result.fold(
      (failure) => emit(_Error(failure)),
      (snapshot) => emit(_Loaded(snapshot)),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 3. Screen — infinite scroll with NotificationListener
// ─────────────────────────────────────────────────────────────────────────────

class _InvoiceListScreen extends StatelessWidget {
  const _InvoiceListScreen();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _InvoiceBloc(_InvoiceRepository())..add(_Load()),
      child: Scaffold(
        body: BlocBuilder<_InvoiceBloc, _InvoiceState>(
          builder: (context, state) {
            if (state is _Initial || state is _Loading) {
              return const Center(child: CircularProgressIndicator());
            }

            final snapshot = switch (state) {
              _Loaded(:final snapshot) => snapshot,
              _LoadingMore(:final snapshot) => snapshot,
              _Error(:final snapshot) => snapshot,
              _ => null,
            };

            if (snapshot == null) return const SizedBox.shrink();

            return _InvoiceList(
              snapshot: snapshot,
              isLoadingMore: state is _LoadingMore,
              error: state is _Error ? (state as _Error).failure.message : null,
              onLoadMore: () => context.read<_InvoiceBloc>().add(_LoadMore()),
              onRefresh: () => context.read<_InvoiceBloc>().add(_Refresh()),
            );
          },
        ),
      ),
    );
  }
}

class _InvoiceList extends StatelessWidget {
  const _InvoiceList({
    required this.snapshot,
    required this.onLoadMore,
    required this.onRefresh,
    this.isLoadingMore = false,
    this.error,
  });

  final PaginatorSnapshot<_Invoice> snapshot;
  final bool isLoadingMore;
  final String? error;
  final VoidCallback onLoadMore;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollUpdateNotification) {
          final metrics = notification.metrics;
          if (metrics.pixels >= metrics.maxScrollExtent * 0.8) onLoadMore();
        }
        return false;
      },
      child: RefreshIndicator(
        onRefresh: () async => onRefresh(),
        child: ListView.builder(
          itemCount: snapshot.items.length + (isLoadingMore ? 1 : 0),
          itemBuilder: (context, i) {
            if (i == snapshot.items.length) {
              return const Center(child: CircularProgressIndicator());
            }
            final invoice = snapshot.items[i];
            return ListTile(
              title: Text(invoice.id),
              trailing: Text('\$${invoice.amount}'),
            );
          },
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 4. Cursor-based pagination — for feeds, timelines, etc.
// ─────────────────────────────────────────────────────────────────────────────

class _FeedRepository {
  TaskEither<Failure, PaginatedResponse<_Invoice>> getFeedPage({
    required String? cursor,
    required int pageSize,
  }) =>
      AppCache.memory.fetch(
        'feed_${cursor ?? 'start'}',
        () => _remoteFeed(cursor, pageSize),
        ttl: const Duration(minutes: 1),
        fromJson: (json) => PaginatedResponse.fromJson(
          json,
          fromJson: _Invoice.fromJson,
          cursorFromJson: (map) =>
              (map as Map<String, dynamic>)['next'] as String?,
        ),
        onError: (e) => ServerFailure(message: e.toString()),
      );

  Future<PaginatedResponse<_Invoice>> _remoteFeed(
    String? cursor,
    int pageSize,
  ) async =>
      PaginatedResponse(
        items: List.generate(pageSize, (i) => _Invoice(id: '$i', amount: 50)),
        hasMore: cursor == null,
        nextCursor: cursor == null ? 'cursor_page_2' : null,
      );
}

// Cursor paginator — identical API to offset, just a different constructor.
final _feedPaginator = Paginator.cursor(fetch: _FeedRepository().getFeedPage);
