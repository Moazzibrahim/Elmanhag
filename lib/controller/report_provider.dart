import 'dart:convert';
import 'package:flutter/material.dart'; // If using context
import 'package:flutter_application_1/controller/Auth/login_provider.dart';
import 'package:flutter_application_1/models/report_model.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart'; // For Provider

Future<IssuesData?> fetchIssuesData(BuildContext context) async {
  final tokenProvider = Provider.of<TokenModel>(context, listen: false);
  final String? token = tokenProvider.token;

  try {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final response = await http.get(
        Uri.parse('https://bdev.elmanhag.shop/student/issues'),
        headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);

      IssuesData issuesData = IssuesData.fromJson(jsonData);

      return issuesData;
    } else {
      throw Exception('Failed to load issues data');
    }
  } catch (e) {
    print('Error fetching data: $e');
    return null;
  }
}
