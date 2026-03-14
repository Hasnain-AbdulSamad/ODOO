import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  final _storage = const FlutterSecureStorage();

  static const String _keyServerUrl = 'server_url';
  static const String _keyDatabase = 'database_name';
  static const String _keySession = 'session_id';

  Future<void> saveServerUrl(String url) async {
    await _storage.write(key: _keyServerUrl, value: url);
  }

  Future<String?> getServerUrl() async {
    return await _storage.read(key: _keyServerUrl);
  }

  Future<void> saveDatabase(String dbName) async {
    await _storage.write(key: _keyDatabase, value: dbName);
  }

  Future<String?> getDatabase() async {
    return await _storage.read(key: _keyDatabase);
  }

  Future<void> saveSession(String sessionId) async {
    await _storage.write(key: _keySession, value: sessionId);
  }

  Future<String?> getSession() async {
    return await _storage.read(key: _keySession);
  }

  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
  
  Future<void> clearSession() async {
    await _storage.delete(key: _keySession);
  }
}