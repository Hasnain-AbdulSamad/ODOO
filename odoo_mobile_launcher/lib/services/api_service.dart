import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  Map<String, String>? _sessionCookies;

  Future<bool> testConnection(String serverUrl) async {
    try {
      final response = await http.post(
        Uri.parse('$serverUrl/web/database/list'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      // A successful response (even if unauthorized) indicates the server is reachable
      return response.statusCode == 200 || response.statusCode == 401;
    } catch (e) {
      return false;
    }
  }

  Future<List<String>> getDatabaseList(String serverUrl) async {
    try {
      final response = await http.post(
        Uri.parse('$serverUrl/web/database/list'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Extract session cookies if present
        _extractSessionCookies(response.headers);

        if (data is Map && data.containsKey('result')) {
          final databases = data['result'] as List;
          return databases.cast<String>();
        }
      }

      return [];
    } catch (e) {
      throw Exception('Failed to fetch database list: $e');
    }
  }

  Future<bool> authenticate(String serverUrl, String database, String username, String password) async {
    try {
      final payload = {
        'jsonrpc': '2.0',
        'method': 'call',
        'params': {
          'service': 'common',
          'method': 'authenticate',
          'args': [database, username, password, {}]
        },
        'id': 1
      };

      final response = await http.post(
        Uri.parse('$serverUrl/web/session/authenticate'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(payload),
      );

      _extractSessionCookies(response.headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Check if authentication was successful
        if (data is Map && data.containsKey('result')) {
          final result = data['result'];
          if (result != null && result is Map && result.containsKey('uid')) {
            final uid = result['uid'];
            return uid != null && uid != false;
          }
        }
      }

      return false;
    } catch (e) {
      throw Exception('Authentication failed: $e');
    }
  }

  void _extractSessionCookies(Map<String, String> headers) {
    // Extract session cookies from response headers
    final cookies = <String, String>{};

    if (headers.containsKey('set-cookie')) {
      final cookieHeader = headers['set-cookie'];
      if (cookieHeader != null) {
        // Parse cookie header - this is a simplified parsing
        final cookiePairs = cookieHeader.split(',');
        for (String cookiePair in cookiePairs) {
          final parts = cookiePair.split(';')[0].split('=');
          if (parts.length >= 2) {
            cookies[parts[0].trim()] = parts.sublist(1).join('=').trim();
          }
        }
      }
    }

    if (cookies.isNotEmpty) {
      final cookieStrings = cookies.entries.map((entry) => '${entry.key}=${entry.value}').toList();
      _sessionCookies = {'Cookie': cookieStrings.join('; ')};
    }
  }

  String? getSessionCookies() {
    if (_sessionCookies != null && _sessionCookies!.isNotEmpty) {
      return _sessionCookies!['Cookie'];
    }
    return null;
  }
}