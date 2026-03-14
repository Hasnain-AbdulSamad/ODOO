import 'dart:convert';
import 'package:http/http.dart' as http;

class OdooService {
  Future<List<String>> getDatabases(String serverUrl) async {
    final url = Uri.parse('$serverUrl/web/database/list');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'params': {}}),
      );

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

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['result'] != null) {
          // Extract session_id from cookie if needed, but Odoo usually returns it in headers or result context
          // For simplicity in this launcher, we might need to look at Set-Cookie header
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
