import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:client/util/token_storage.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Api {
  static const String baseUrl = 'http://localhost:5000/api/issue';

  static Future addComplaint(Map<String, dynamic> complaintData) async {
    try {
      final token = await TokenStorage.get();

      Dio dio = Dio();

      FormData formData = FormData.fromMap({
        "title": complaintData["title"],
        "description": complaintData["description"],
        "type": complaintData["type"],
        "category": complaintData["category"],
        if (complaintData["image"] != null)
          "image": await MultipartFile.fromFile(
            complaintData["image"].path,
            filename: "issue.jpg",
          ),
      });
      print(formData);
      final response = await dio.post(
        "$baseUrl/createIssue",
        data: formData,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      debugPrint('sending dio');
      print(response);
      debugPrint('${response.statusCode}');

      return response.data;
    } catch (e) {
      print("Error in addComplaint: $e");
      return null;
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
    var url = Uri.parse(
      '$baseUrl/getIssues',
    ).replace(queryParameters: queryParams);

    try {
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );

      // debugPrint(
      //   const JsonEncoder.withIndent('  ').convert(jsonDecode(response.body)),
      // );

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

  Future<Map<String, dynamic>> deleteUserComplaint(String id) async {
    final token = await TokenStorage.get();
    var url = Uri.parse('$baseUrl/deleteIssue/$id');
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
