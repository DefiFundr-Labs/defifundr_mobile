import 'package:defifundr_mobile/core/cache/storage/cache_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Persistent cache backed by SharedPreferences.
/// Use for non-sensitive data: API responses, user preferences, feature flags.
class SharedPrefsCacheStorage implements CacheStorage {
  SharedPrefsCacheStorage({this.prefix = '_cache_'});

  final String prefix;

  String _k(String key) => '$prefix$key';

  @override
  Future<String?> read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_k(key));
  }

  @override
  Future<void> write(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_k(key), value);
  }

  @override
  Future<void> delete(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_k(key));
  }

  @override
  Future<Set<String>> keys() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs
        .getKeys()
        .where((k) => k.startsWith(prefix))
        .map((k) => k.substring(prefix.length))
        .toSet();
  }

  @override
  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    final cacheKeys = prefs.getKeys().where((k) => k.startsWith(prefix));
    for (final key in cacheKeys) {
      await prefs.remove(key);
    }
  }
}
