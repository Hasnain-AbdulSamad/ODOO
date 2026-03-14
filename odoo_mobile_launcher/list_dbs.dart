import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  final url = Uri.parse('https://vmi3035083.contaboserver.net/web/database/list');
  print('Fetching databases from: $url');
  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'params': {}}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['result'] != null) {
        print('AVAILABLE DATABASES:');
        final dbs = List<String>.from(data['result']);
        for (var db in dbs) {
            print('- $db');
        }
      } else {
          print('Error in result: ${response.body}');
      }
    } else {
      print('HTTP Error: ${response.statusCode}');
    }
  } catch (e) {
    print('Exception: $e');
  }
}
