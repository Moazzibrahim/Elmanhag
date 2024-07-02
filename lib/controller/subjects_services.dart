import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/Auth/login_provider.dart';
import 'package:flutter_application_1/models/subjects_model.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class SubjectProvider with ChangeNotifier {
  List<Subject> allSubjects = [];
  Future<void> getSubjects(BuildContext context) async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;
    try {
      final response = await http
          .get(Uri.parse('https://my.elmanhag.shop/api/subjects'), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        
        Map<String, dynamic> responseData = jsonDecode(response.body);

        Subjects subjects = Subjects.fromJson(responseData);
        List<Subject> subjectList = subjects.subjectsList.map((e) => Subject.fromJson(e),).toList();
        SubjectsBundleList subjectsBundleList =
            SubjectsBundleList.fromJson(responseData);
        List<Subject> sbl = subjectsBundleList.subjectsList
            .map(
              (e) => Subject.fromJson(e),
            )
            .toList();
        allSubjects = [...subjectList, ...sbl];
        notifyListeners();
      } else {
        log('error statuscode: ${response.statusCode}');
      }
    } catch (e) {
      log('error in get subject: $e');
    }
  }
}
