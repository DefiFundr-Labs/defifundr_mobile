/// Abstract interface for all cache backends.
/// All implementations serialize data as JSON strings internally.
abstract class CacheStorage {
  /// Read a raw JSON string by key. Returns null if not found.
  Future<String?> read(String key);

  /// Write a raw JSON string.
  Future<void> write(String key, String value);

  /// Delete a single key.
  Future<void> delete(String key);

  /// Return all stored keys.
  Future<Set<String>> keys();

  /// Wipe everything in this storage.
  Future<void> clear();
}
