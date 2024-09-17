// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/Auth/login_provider.dart';
import 'package:flutter_application_1/models/parent%20models/child_subjects_models.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class GetChildrenSubjects with ChangeNotifier {
  SubjectResponsechild? subjectResponseChild;

  Future<void> fetchChildrenSubjects(
      int studentId, BuildContext context) async {
    final url = Uri.parse('https://bdev.elmanhag.shop/parent/subjects');
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final String? token = tokenProvider.token;

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'student_id': studentId,
        }),
      );
      log("stid:$studentId");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Parse the response into SubjectResponsechild object
        subjectResponseChild = SubjectResponsechild.fromJson(data);

        // Notify listeners to update the UI if necessary
        notifyListeners();

        // Handle the data (e.g., print subjects and progress for debugging)
        print('Subjects: ${subjectResponseChild!.subjects}');
        print('Progress: ${subjectResponseChild!.progress}');
      } else {
        // Handle error response
        print('Failed to load subjects. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions (e.g., network errors)
      print('Error occurred: $e');
    }
  }
}
