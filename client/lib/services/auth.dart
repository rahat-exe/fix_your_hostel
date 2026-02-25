import 'dart:convert';
import 'package:client/util/token_storage.dart';
import 'package:http/http.dart' as http;

class Auth {
  static const String baseUrl = 'http://localhost:5000/api/auth';
  static Future<Map<String, dynamic>> register(
    Map<String, dynamic> userData,
  ) async {
    final token = await TokenStorage.get();
    print('Registering user with data: $userData');
    var url = Uri.parse('$baseUrl/register');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(userData),
      );
      print('response code: ${response.statusCode}');
      print('response body: ${response.body}');
      if (response.statusCode == 201) {
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

  static Future<Map<String, dynamic>> login(
    Map<String, dynamic> credentials,
  ) async {
    final token = await TokenStorage.get();
    var url = Uri.parse('$baseUrl/login');
    print('Logging in with credentials: $credentials');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(credentials),
      );
      print('response code: ${response.statusCode}');
      print('response body: ${response.body}');
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
