import 'dart:convert';
import 'package:http/http.dart' as http;
class Auth {
  static const String baseUrl = 'http://localhost:5000/api/auth';
  static Future<Map<String,dynamic>> register(Map<String, dynamic> userData) async {
    var url = Uri.parse('$baseUrl/register');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userData),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print(response.body);
        throw Exception('Server error: ${response.body}');
      }
    } catch (e) {
      print(e);
      return {};
    }
  }
}