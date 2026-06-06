class CacheEntry<T> {
  CacheEntry({
    required this.data,
    required this.ttl,
  }) : cachedAt = DateTime.now();

  CacheEntry.fromStorage({
    required this.data,
    required this.cachedAt,
    required this.ttl,
  });

  final T data;
  final DateTime cachedAt;
  final Duration ttl;

  bool get isStale => DateTime.now().isAfter(cachedAt.add(ttl));
  bool get isFresh => !isStale;

  Duration get age => DateTime.now().difference(cachedAt);
}
