import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:client/util/token_storage.dart';

class Api {
  static const String baseUrl = 'http://localhost:5000/api/issue';

  static addComplaint(Map<String, dynamic> complaintData) async {
    var url = Uri.parse('$baseUrl/createIssue');
    try {
      final token = await TokenStorage.get();
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(complaintData),
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
    }
  }

  Future<List<dynamic>> getComplaints() async {
    final token = await TokenStorage.get();
    var url = Uri.parse('$baseUrl/getIssues');
    try {
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );
      print('response code: ${response.statusCode}');
      print('response body: ${response.body}');
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        return data;
      } else {
        throw Exception('Failed to fetch complaints');
      }
    } catch (e) {
      print(e);
      return [];
    }
  }
}
