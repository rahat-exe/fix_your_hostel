import 'package:client/util/token_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';

class Votes {
  Votes({required this.complaintId});
  final String complaintId;
  String get baseUrl => 'http://localhost:5000/api/issue/$complaintId';
  Future<Map<String, dynamic>> getVotesCount() async {
    final token = await TokenStorage.get();
    var url = Uri.parse('$baseUrl/upvotes');
    try {
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );
      debugPrint(
        const JsonEncoder.withIndent('  ').convert(jsonDecode(response.body)),
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        return data;
      } else {
        throw Exception('Failed to fetch Votes Count');
      }
    } catch (e) {
      print(e);
      return {};
    }
  }
}
