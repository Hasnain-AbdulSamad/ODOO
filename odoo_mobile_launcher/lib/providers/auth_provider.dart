import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import '../services/odoo_service.dart';

class AuthProvider with ChangeNotifier {
  final StorageService _storageService = StorageService();
  final OdooService _odooService = OdooService();

  String? _serverUrl;
  String? _database;
  String? _sessionId;
  bool _isLoading = false;
  String? _error;

  String? get serverUrl => _serverUrl;
  String? get database => _database;
  String? get sessionId => _sessionId;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<bool> checkSession() async {
    _serverUrl = await _storageService.getServerUrl();
    _database = await _storageService.getDatabase();
    _sessionId = await _storageService.getSession();
    
    notifyListeners();
    return _sessionId != null && _serverUrl != null && _database != null;
  }

  Future<void> setServerUrl(String url) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    // Regex validation for URL
    if (!Uri.parse(url).isAbsolute) {
       _error = 'Invalid URL format';
       _isLoading = false;
       notifyListeners();
       return;
    }

    try {
        // Attempt to list databases to validate URL
        await _odooService.getDatabases(url);
        
        _serverUrl = url;
        await _storageService.saveServerUrl(url);
    } catch (e) {
        _error = 'Could not connect to Odoo server. Check URL.';
        // Verify if it's just a database listing issue but URL is valid
    } finally {
        _isLoading = false;
        notifyListeners();
    }
  }

  Future<List<String>> fetchDatabases() async {
    if (_serverUrl == null) return [];
    _isLoading = true;
    notifyListeners();
    
    try {
      final dbs = await _odooService.getDatabases(_serverUrl!);
      _isLoading = false;
      notifyListeners();
      return dbs;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return [];
    }
  }

  Future<void> selectDatabase(String db) async {
    _database = db;
    await _storageService.saveDatabase(db);
    notifyListeners();
  }

  Future<bool> login(String login, String password) async {
    if (_serverUrl == null || _database == null) {
        _error = "Server or Database not selected";
        notifyListeners();
        return false;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    final result = await _odooService.authenticate(_serverUrl!, _database!, login, password);

    if (result['success']) {
        // If session_id is returned in the result context (some versions of Odoo)
        String? newSessionId = result['session_id'];
        // Fallback or override logic if needed
        Map<String, dynamic> data = result['data'];
        if (data.containsKey('session_id')) {
           newSessionId = data['session_id'];
        }

        if (newSessionId != null) {
            _sessionId = newSessionId;
            await _storageService.saveSession(newSessionId);
            _isLoading = false;
            notifyListeners();
            return true;
        } else {
             _error = "Session ID not found in response";
        }
    } else {
        _error = result['message'] ?? 'Login failed';
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  Future<void> logout() async {
    await _storageService.clearSession();
    _sessionId = null;
    notifyListeners();
  }
  
  void clearError() {
      _error = null;
      notifyListeners();
  }
}
