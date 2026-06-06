import 'package:defifundr_mobile/core/cache/storage/cache_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Encrypted persistent cache backed by flutter_secure_storage.
/// Use for sensitive data: auth tokens, wallet keys, private user data.
class SecureCacheStorage implements CacheStorage {
  SecureCacheStorage({this.prefix = '_scache_'})
      : _storage = const FlutterSecureStorage(
          aOptions: AndroidOptions(encryptedSharedPreferences: true),
          iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
        );

  final String prefix;
  final FlutterSecureStorage _storage;

  String _k(String key) => '$prefix$key';

  @override
  Future<String?> read(String key) => _storage.read(key: _k(key));

  @override
  Future<void> write(String key, String value) =>
      _storage.write(key: _k(key), value: value);

  @override
  Future<void> delete(String key) => _storage.delete(key: _k(key));

  @override
  Future<Set<String>> keys() async {
    final all = await _storage.readAll();
    return all.keys
        .where((k) => k.startsWith(prefix))
        .map((k) => k.substring(prefix.length))
        .toSet();
  }

  @override
  Future<void> clear() async {
    final all = await _storage.readAll();
    for (final key in all.keys.where((k) => k.startsWith(prefix))) {
      await _storage.delete(key: key);
    }
  }
}
