// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/Auth/login_provider.dart';
import 'package:flutter_application_1/models/bundle_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class GetBundleData with ChangeNotifier {
  MainModel? _mainModel;
  MainModel? get mainModel => _mainModel;

  Future<MainModel?> fetchMainModel(BuildContext context) async {
    const url = 'https://bdev.elmanhag.shop/student/bundles';
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // Decode the JSON response
        final data = json.decode(response.body);
        _mainModel = MainModel.fromJson(data);

        // Notify listeners
        notifyListeners();

        return _mainModel;
      } else {
        // Handle the error if status code is not 200
        print('Failed to load data. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // Handle any other errors
      print('Error fetching data: $e');
      return null;
    }
  }

  // Access Bundles
  List<Bundle>? getBundles() {
    return _mainModel?.bundles;
  }

  // Access Subjects
  List<Subject>? getSubjects() {
    return _mainModel?.subjects;
  }

  // Access Live Data
  List<dynamic>? getLiveData() {
    return _mainModel?.live;
  }
}
