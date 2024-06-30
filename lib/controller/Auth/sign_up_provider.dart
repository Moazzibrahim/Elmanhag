import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/screens/login/login_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required String confpassword,
    required String parentName,
    required String parentPhone,
    required String phone, // Added phone parameter
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
        'conf_password': confpassword,
        'parent_name': parentName,
        'parent_phone': parentPhone,
        'phone': phone,
        'countryId': selectedCountryId,
        'city_id': selectedCityId,
        'category_id': selectedCategoryId,
        'type': selectedType,
      }),
    );

    if (response.statusCode == 200) {
      // Successfully sent data to the API
      _showSuccessDialog(context);
    } else {
      // Error sending data to the API
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
