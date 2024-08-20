import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/Auth/login_provider.dart';
import 'package:flutter_application_1/models/curriculums_model.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class SubjectProvider with ChangeNotifier {
  List<Subject> allSubjects = [];

  Future<void> getSubjects(BuildContext context) async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;

    try {
      final response = await http.get(
        Uri.parse('https://bdev.elmanhag.shop/student/setting/subject/student'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);

        SubjectResponse subjectResponse =
            SubjectResponse.fromJson(responseData);

        allSubjects = subjectResponse.subjects;

        notifyListeners();
      } else {
        log('Error: Status code ${response.statusCode}');
      }
    } catch (e) {
      log('Error in getSubjects: $e');
    }
  }
}
