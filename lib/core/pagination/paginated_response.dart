/// The raw response from a paginated API endpoint.
class PaginatedResponse<T> {
  const PaginatedResponse({
    required this.items,
    required this.hasMore,
    this.total,
    this.nextCursor,
  });

  /// Items for this page only.
  final List<T> items;

  /// Whether another page exists after this one.
  final bool hasMore;

  /// Total item count across all pages (optional — not all APIs provide this).
  final int? total;

  /// Cursor for the next page (optional — for cursor-based pagination).
  final String? nextCursor;

  factory PaginatedResponse.fromJson(
    dynamic json, {
    required T Function(dynamic) fromJson,
    bool Function(dynamic)? hasMoreFromJson,
    int? Function(dynamic)? totalFromJson,
    String? Function(dynamic)? cursorFromJson,
  }) {
    final map = json as Map<String, dynamic>;
    return PaginatedResponse(
      items: (map['items'] as List).map(fromJson).toList(),
      hasMore: hasMoreFromJson != null
          ? hasMoreFromJson(map)
          : map['hasMore'] as bool? ?? false,
      total: totalFromJson != null ? totalFromJson(map) : map['total'] as int?,
      nextCursor: cursorFromJson != null
          ? cursorFromJson(map)
          : map['nextCursor'] as String?,
    );
  }
}

/// Snapshot of a [Paginator] after a load — passed to BLoC states.
class PaginatorSnapshot<T> {
  const PaginatorSnapshot({
    required this.items,
    required this.hasMore,
    required this.page,
  });

  /// All accumulated items across every loaded page.
  final List<T> items;

  /// Whether more pages can be fetched.
  final bool hasMore;

  /// Last page number that was loaded.
  final int page;

  bool get isEmpty => items.isEmpty;
  bool get isFirstPage => page == 1;
}
