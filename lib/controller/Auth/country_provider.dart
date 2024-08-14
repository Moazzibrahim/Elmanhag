import 'dart:convert';
import 'dart:developer';
import 'package:flutter_application_1/controller/Auth/login_provider.dart';
import 'package:flutter_application_1/models/sign_up_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DataProvider with ChangeNotifier {
  DataModel? dataModel;

  Future<void> fetchData(BuildContext context) async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;

    try {
      final response = await http.get(
        Uri.parse('https://bdev.elmanhag.shop/student/setting/view'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        dataModel = DataModel.fromJson(responseData);
        notifyListeners();
      } else {
        log('Failed to fetch data');
      }
    } catch (e) {
      log('Error: $e');
    }
  }
}
