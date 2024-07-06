import 'dart:convert';
import 'dart:developer';
import 'package:flutter_application_1/models/sections_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/Auth/login_provider.dart';
import 'package:provider/provider.dart';

class SectionsProvider with ChangeNotifier {
  List<Section> allSections = [];
  List<Lesson> allLessons = [];
Future<void> getSections(BuildContext context,int id)async{
  allLessons = [];
  allSections =[];
  notifyListeners();
  final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;
    try{
      final response = await http
          .get(Uri.parse('https://my.elmanhag.shop/api/lessons/$id'), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if(response.statusCode == 200){
        Map<String,dynamic> responseData = jsonDecode(response.body);
        Sections sections = Sections.fromjson(responseData);
        List<Section> sectionsList = sections.sectionsList.map((e) => Section.fromJson(e),).toList();
        Lessons lessons = Lessons.fromJson(responseData);
        List<Lesson> lessonsList = lessons.lessonsList.map((e) => Lesson.fromJson(e),).toList();
        allLessons = lessonsList;
        allSections = sectionsList;
        notifyListeners();
      }else{
        log('error statusCode: ${response.statusCode}');
      }
  }catch(e){
    log('error in get Sections: $e');
  }
}

}


