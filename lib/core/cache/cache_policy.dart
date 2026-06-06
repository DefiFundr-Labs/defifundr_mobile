enum CachePolicy {
  /// Always hit the network. Cache is never read, but result is still stored.
  noCache,

  /// Return cache if available and fresh. If stale or missing, fetch and wait.
  useCache,

  /// Return stale cache immediately, refresh in background (stale-while-revalidate).
  cacheFirst,

  /// Always fetch first, cache the result. Falls back to cache if network fails.
  networkFirst,
}
