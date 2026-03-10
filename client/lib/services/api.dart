import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:client/util/token_storage.dart';
import 'package:flutter/material.dart';

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
      debugPrint('$response');
      debugPrint('response body: ${response.body}');
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        debugPrint(response.body);
        throw Exception('Server error: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error in addComplaint: $e');
    }
  }

  Future<List<dynamic>> getComplaints({
  String? type,
  String? priority,
  String? status,
}) async {
  final token = await TokenStorage.get();

  // Build query parameters
  Map<String, String> queryParams = {};

  if (type != null) queryParams["type"] = type;
  if (priority != null) queryParams["priority"] = priority;
  if (status != null) queryParams["status"] = status;

  // Create URL with query
  var url = Uri.parse('$baseUrl/getIssues').replace(queryParameters: queryParams);

  try {
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    debugPrint(
      const JsonEncoder.withIndent('  ').convert(jsonDecode(response.body)),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to fetch complaints');
    }
  } catch (e) {
    print(e);
    return [];
  }
}

  Future<Map<String, dynamic>> deleteComplaint(String id) async {
    final token = await TokenStorage.get();
    var url = Uri.parse('$baseUrl/$id/issue');
    try {
      final response = await http.delete(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );
      debugPrint(
        const JsonEncoder.withIndent('  ').convert(jsonDecode(response.body)),
      );
      debugPrint(response.statusCode.toString());
      debugPrint(response.body);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        return data;
      } else {
        throw Exception('Failed to delete complaints');
      }
    } catch (e) {
      print(e);
      return {};
    }
  }

  Future<Map<String, dynamic>> editRemarks(String remarks, String id) async {
    final token = await TokenStorage.get();
    var url = Uri.parse('$baseUrl/$id/remarks');
    try {
      final response = await http.patch(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"adminRemarks": remarks}),
      );
      debugPrint(
        const JsonEncoder.withIndent('  ').convert(jsonDecode(response.body)),
      );
      debugPrint(response.statusCode.toString());
      debugPrint(response.body);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception('Failed to update remarks');
      }
    } catch (e) {
      print(e);
      return {};
    }
  }

  Future<Map<String, dynamic>> editStatus(String status, String id) async {
    final token = await TokenStorage.get();
    var url = Uri.parse('$baseUrl/$id/status');
    try {
      final response = await http.patch(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"status": status}),
      );
      debugPrint(
        const JsonEncoder.withIndent('  ').convert(jsonDecode(response.body)),
      );
      debugPrint(response.statusCode.toString());
      debugPrint(response.body);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception('Failed to update status');
      }
    } catch (e) {
      print(e);
      return {};
    }
  }
}
