import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/subjects_model.dart';
import 'package:http/http.dart' as http;

class SubjectProvider with ChangeNotifier{
  List<Subject> allSubjects = [];
  Future<void> getSubjects() async{
    try{
      final response =await http.get(Uri.parse('https://my.elmanhag.shop/api/subjects'));
      if(response.statusCode == 200){
        Map<String,dynamic> responseData = jsonDecode(response.body);
        log('$responseData');
        Subjects subjects = Subjects.fromJson(responseData);
        List<Subject> subjectList = subjects.subjectsList.map((e) => Subject.fromJson(e),).toList();
        allSubjects = subjectList;
        notifyListeners();
      }else{
        log('error statuscode: ${response.statusCode}');
      }
    }catch(e){
      log('error in get subject: $e');
    }
  }
}