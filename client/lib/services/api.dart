import 'package:http/http.dart' as http;
import 'dart:convert';

class Api {
  static const String baseUrl = 'http://localhost:5000/api/issue';

  static addComplaint(Map<String, dynamic> complaintData) async {
    var url = Uri.parse('$baseUrl/createIssue');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(complaintData),
      );
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
    var url = Uri.parse('$baseUrl/getIssues');
    try {
      final response = await http.get(url);
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
