// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/screens/login/login_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required String parentName,
    required String parentPhone,
    required String? selectedCountryId,
    required String? selectedCityId,
    required String? selectedCategoryId,
    required String? selectedType,
    required BuildContext context,
  }) async {
    const url = 'https://my.elmanhag.shop/api/api_sign_up_add';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': name,
        'email': email,
        'password': password,
        'parentName': parentName,
        'parentPhone': parentPhone,
        'countryId': selectedCountryId,
        'cityId': selectedCityId,
        'categoryId': selectedCategoryId,
        'type': selectedType,
      }),
    );

    if (response.statusCode == 200) {
      // Successfully sent data to the API
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );

      // Print the data sent to the API
      print('Sent data:');
      print({
        'name': name,
        'email': email,
        'password': password,
        'parentName': parentName,
        'parentPhone': parentPhone,
        'countryId': selectedCountryId,
        'cityId': selectedCityId,
        'categoryId': selectedCategoryId,
        'type': selectedType,
      });
    } else {
      // Error sending data to the API
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${response.reasonPhrase}')),
      );
    }
  }
}
