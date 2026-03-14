import 'dart:convert';
import 'package:http/http.dart' as http;

// Copy of OdooService logic for standalone testing
class TestOdooService {
  Future<List<String>> getDatabases(String serverUrl) async {
    final url = Uri.parse('$serverUrl/web/database/list');
    print('Testing connection to: $url');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'params': {}}),
      );

      print('Database List Status Code: ${response.statusCode}');
      print('Database List Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['result'] != null) {
          return List<String>.from(data['result']);
        } else if (data['error'] != null) {
            throw Exception('Odoo Error: ${data['error']['message']}');
        }
      }
      throw Exception('Failed to load databases: ${response.statusCode}');
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<Map<String, dynamic>> authenticate(
      String serverUrl, String db, String login, String password) async {
    final url = Uri.parse('$serverUrl/web/session/authenticate');
    print('Authenticating at: $url with db: $db, login: $login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'jsonrpc': '2.0',
          'method': 'call',
          'params': {
            'db': db,
            'login': login,
            'password': password,
          }
        }),
      );

      print('Auth Status Code: ${response.statusCode}');
      // Don't print full body if it's huge, but usually it's fine for auth
      print('Auth Body: ${response.body}');
      print('Auth Headers: ${response.headers}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['result'] != null) {
          String? sessionId;
           if (response.headers['set-cookie'] != null) {
             final cookies = response.headers['set-cookie']!;
             final sessionMatch = RegExp(r'session_id=([^;]+)').firstMatch(cookies);
             if (sessionMatch != null) {
               sessionId = sessionMatch.group(1);
             }
           }
           
          return {
            'success': true,
            'data': data['result'],
            'session_id': sessionId
          };
        } else if (data['error'] != null) {
          return {
            'success': false,
            'message': data['error']['data']['message'] ?? data['error']['message']
          };
        }
      }
      return {'success': false, 'message': 'HTTP Error ${response.statusCode}'};
    } catch (e) {
      return {'success': false, 'message': 'Connection error: $e'};
    }
  }
}

void main() async {
  final service = TestOdooService();
  final url = 'https://vmi3035083.contaboserver.net';
  final dbName = 'Test';
  final user = 'test';
  final pass = 'test';

  print('--- 1. Testing Database Listing ---');
  try {
    final dbs = await service.getDatabases(url);
    print('Available Databases: $dbs');
    
    if (dbs.contains(dbName)) {
      print('SUCCESS: Database "$dbName" found.');
    } else {
      print('WARNING: Database "$dbName" not found in list.');
    }
  } catch (e) {
    print('ERROR: $e');
    return;
  }

  print('\n--- 2. Testing Authentication ---');
  try {
    final result = await service.authenticate(url, dbName, user, pass);
    if (result['success']) {
      print('SUCCESS: Login successful.');
      print('Session ID: ${result['session_id']}');
      print('User Context: ${result['data']['user_context']}');
      
      if (result['session_id'] == null) {
        print('WARNING: Session ID (cookie) was null, webview might not persist session.');
      }
    } else {
      print('FAILURE: Login failed.');
      print('Message: ${result['message']}');
    }
  } catch (e) {
    print('ERROR: $e');
  }
}
