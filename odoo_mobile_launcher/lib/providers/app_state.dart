import 'package:flutter/foundation.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';

class AppState extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  final StorageService _storageService = StorageService();

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  Future<bool> hasStoredCredentials() async {
    String? serverUrl = await _storageService.getServerUrl();
    String? selectedDb = await _storageService.getSelectedDatabase();
    return serverUrl != null && selectedDb != null;
  }

  Future<bool> autoLogin() async {
    try {
      String? serverUrl = await _storageService.getServerUrl();
      String? selectedDb = await _storageService.getSelectedDatabase();
      String? username = await _storageService.getUsername();
      String? password = await _storageService.getPassword();

      if (serverUrl != null && selectedDb != null && username != null && password != null) {
        bool loginSuccess = await _apiService.authenticate(serverUrl, selectedDb, username, password);

        if (loginSuccess) {
          _isLoggedIn = true;
          notifyListeners();
          return true;
        }
      }
    } catch (e) {
      // Auto-login failed
    }

    return false;
  }

  Future<bool> validateServerUrl(String url) async {
    return await _apiService.testConnection(url);
  }

  Future<void> saveServerUrl(String url) async {
    await _storageService.setServerUrl(url);
  }

  Future<String> getServerUrl() async {
    String? url = await _storageService.getServerUrl();
    if (url == null) {
      throw Exception('No server URL found');
    }
    return url;
  }

  Future<List<String>> getDatabaseList() async {
    String? serverUrl = await _storageService.getServerUrl();
    if (serverUrl == null) {
      throw Exception('No server URL found');
    }

    List<String> databases = await _apiService.getDatabaseList(serverUrl);
    return databases;
  }

  Future<void> saveSelectedDatabase(String database) async {
    await _storageService.setSelectedDatabase(database);
  }

  Future<String?> getSessionCookies() async {
    return await _storageService.getSessionCookies();
  }

  Future<bool> login(String username, String password) async {
    String? serverUrl = await _storageService.getServerUrl();
    String? selectedDb = await _storageService.getSelectedDatabase();

    if (serverUrl == null || selectedDb == null) {
      throw Exception('Server URL or database not set');
    }

    bool loginSuccess = await _apiService.authenticate(serverUrl, selectedDb, username, password);

    if (loginSuccess) {
      await _storageService.setUsername(username);
      await _storageService.setPassword(password);

      // Store session cookies if available
      String? cookies = _apiService.getSessionCookies();
      if (cookies != null) {
        await _storageService.setSessionCookies(cookies);
      }

      _isLoggedIn = true;
      notifyListeners();
      return true;
    }

    return false;
  }

  Future<void> logout() async {
    await _storageService.clearSessionData();
    _isLoggedIn = false;
    notifyListeners();
  }
}