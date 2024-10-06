import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/Auth/login_provider.dart';
import 'package:flutter_application_1/models/sessions_model.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class SessionsController with ChangeNotifier {
  List<Session> sessionsData = [];
  Future<void> fetchSessionsData(BuildContext context) async {
    try {
      final tokenProvider = Provider.of<TokenModel>(context, listen: false);
      final token = tokenProvider.token;
      final response = await http.get(
        Uri.parse('https://bdev.elmanhag.shop/teacher/live/view'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if(response.statusCode == 200){
        final Map<String,dynamic> responseData = jsonDecode(response.body);
        Sessions sessions = Sessions.fromJson(responseData);
        List<Session> sessionsList = sessions.sessions.map((e) => Session.fromJson(e),).toList();
        sessionsData = sessionsList;
        notifyListeners();
      }else{
        log('error in fetch sessions: ${response.statusCode}');
      }
    } catch (e) {
      log('error in fetch sessions: $e');
    }
  }
}
