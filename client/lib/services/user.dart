import 'dart:convert';
import 'package:client/util/token_storage.dart';
import 'package:http/http.dart' as http;

class UserApi {
  static const String baseUrl = "http://localhost:5000/api/users";
  Future<Map<String, dynamic>>getAllUsers() async {
    final token = await TokenStorage.get();
    var url = Uri.parse('$baseUrl/users');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
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
