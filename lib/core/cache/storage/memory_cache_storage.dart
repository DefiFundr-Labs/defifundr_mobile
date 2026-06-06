import 'package:defifundr_mobile/core/cache/storage/cache_storage.dart';

class MemoryCacheStorage implements CacheStorage {
  final _store = <String, String>{};

  @override
  Future<String?> read(String key) async => _store[key];

  @override
  Future<void> write(String key, String value) async => _store[key] = value;

  @override
  Future<void> delete(String key) async => _store.remove(key);

  @override
  Future<Set<String>> keys() async => _store.keys.toSet();

  @override
  Future<void> clear() async => _store.clear();
}
