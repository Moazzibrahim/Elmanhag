// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/Auth/login_provider.dart';
import 'package:flutter_application_1/models/purchased_items.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class PurshasedLiveController with ChangeNotifier {
  DataModelss? dataModelss;
  
  Future<void> getLiveDatapurshased(BuildContext context) async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;
    const url = "https://bdev.elmanhag.shop/student/subscription";
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        dataModelss = DataModelss.fromJson(responseData);
        notifyListeners();
      } else {
        print("failed to log data");
      }
    } catch (e) {
      print("error: $e");
    }
  }
}
