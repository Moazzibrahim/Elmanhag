// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/screens/login/login_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static Future<void> signUp({
    required String Name,
    required String email,
    required String password,
    required String confpassword,
    required String phone,
    required String? selectedCountryId,
    required String? selectedCityId,
    required String? selectedCategoryId,
    required String language, // Updated parameter
    required BuildContext context,
  }) async {
    const url = 'https://bdev.elmanhag.shop/student/auth/signup/create';
    final requestBody = json.encode({
      'name': Name,
      'email': email,
      'password': password,
      'conf_password': confpassword,
      'phone': phone,
      'city_id': selectedCityId,
      'country_id': selectedCountryId,
      'category_id': selectedCategoryId,
      'language': language, // Updated key
    });

    // Log the data being sent to the API
    print('Sending data to API: $requestBody');

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: requestBody,
    );

    if (response.statusCode == 200) {
      _showSuccessDialog(context);
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');
    } else {
      print('Response Status: ${response.statusCode}');
      print('Error: ${response.reasonPhrase}');
      print('Response Body: ${response.body}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${response.reasonPhrase}')),
      );
    }
  }

  static void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('تم التسجيل بنجاح'),
          actions: <Widget>[
            TextButton(
              child: const Text('تم'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
