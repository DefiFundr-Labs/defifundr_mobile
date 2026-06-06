import 'package:defifundr_mobile/core/error/failure.dart';
import 'package:defifundr_mobile/core/pagination/paginated_response.dart';
import 'package:fpdart/fpdart.dart';

export 'paginated_response.dart';

/// Function that fetches a single page by offset. Implement in your repository.
typedef PageFetcher<T> = TaskEither<Failure, PaginatedResponse<T>> Function({
  required int page,
  required int pageSize,
});

/// Cursor-based variant — pass [cursor] instead of a page number.
typedef CursorFetcher<T> = TaskEither<Failure, PaginatedResponse<T>> Function({
  required String? cursor,
  required int pageSize,
});

/// Stateful helper that accumulates pages and tracks pagination state.
///
/// Owns no Flutter state — lives inside a BLoC or service.
///
/// ```dart
/// final _paginator = Paginator(fetch: invoiceRepo.getInvoicesPage);
///
/// // In BLoC handler:
/// final result = await _paginator.loadNext().run();
/// result.fold(
///   (failure) => emit(InvoiceError(failure)),
///   (snapshot) => emit(InvoiceLoaded(snapshot)),
/// );
/// ```
class Paginator<T> {
  Paginator({
    required PageFetcher<T> fetch,
    this.pageSize = 20,
  })  : _fetch = fetch,
        _fetchCursor = null;

  Paginator.cursor({
    required CursorFetcher<T> fetch,
    this.pageSize = 20,
  })  : _fetchCursor = fetch,
        _fetch = null;

  final int pageSize;
  final PageFetcher<T>? _fetch;
  final CursorFetcher<T>? _fetchCursor;

  int _page = 0;
  String? _cursor;
  final List<T> _items = [];
  bool _hasMore = true;

  List<T> get items => List.unmodifiable(_items);
  bool get hasMore => _hasMore;
  bool get isFirstPage => _page == 0;
  int get loadedCount => _items.length;

  /// Fetch the next page and append results. No-op if [hasMore] is false.
  TaskEither<Failure, PaginatorSnapshot<T>> loadNext() {
    if (!_hasMore) return TaskEither.right(_snapshot());

    return TaskEither(() async {
      final result = await _callFetcher().run();
      return result.map((response) {
        _items.addAll(response.items);
        _hasMore = response.hasMore;
        _page++;
        _cursor = response.nextCursor;
        return _snapshot();
      });
    });
  }

  /// Reset to page 0, clear items, then load the first page.
  TaskEither<Failure, PaginatorSnapshot<T>> refresh() {
    reset();
    return loadNext();
  }

  /// Reset to initial state without fetching.
  void reset() {
    _page = 0;
    _cursor = null;
    _items.clear();
    _hasMore = true;
  }

  // ── Internal ───────────────────────────────────────────────────────────────

  TaskEither<Failure, PaginatedResponse<T>> _callFetcher() {
    final offsetFetch = _fetch;
    final cursorFetch = _fetchCursor;
    if (offsetFetch != null) {
      return offsetFetch(page: _page + 1, pageSize: pageSize);
    }
    return cursorFetch!(cursor: _cursor, pageSize: pageSize);
  }

  PaginatorSnapshot<T> _snapshot() => PaginatorSnapshot(
        items: List.unmodifiable(_items),
        hasMore: _hasMore,
        page: _page,
      );
}
