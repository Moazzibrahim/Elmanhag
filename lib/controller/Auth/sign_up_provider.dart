import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/Auth/login_provider.dart';
import 'package:flutter_application_1/views/screens/login/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../views/screens/home_screen.dart'; // Import your TokenModel

class ApiService with ChangeNotifier {
  static Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required String confpassword,
    required String phone,
    required String? selectedCountryId,
    required String? selectedCityId,
    required String? selectedCategoryId,
    required String? selectedEducationId,
    required String parentname,
    required String parentemail,
    required String parentpassword,
    required String parentphone,
    required String? selectedparentrealtionId,
    required String gender,
    required String jobId,
    required String affilateCode,
    required BuildContext context,
  }) async {
    const url = 'https://bdev.elmanhag.shop/student/auth/signup/create';
    final requestBody = json.encode({
      'name': name,
      'email': email,
      'password': password,
      'conf_password': confpassword,
      'phone': phone,
      'city_id': selectedCityId,
      'country_id': selectedCountryId,
      'category_id': selectedCategoryId,
      'education_id': selectedEducationId,
      'parent_name': parentname,
      'parent_phone': parentphone,
      'parent_email': parentemail,
      'parent_password': parentpassword,
      'parent_relation_id': selectedparentrealtionId,
      'gender': gender,
      'student_job_id': jobId,
      'affilate_code': affilateCode
    });

    print('Sending data to API: $requestBody');

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: requestBody,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      // Check if response contains a token
      if (responseData.containsKey('_token')) {
        final String token = responseData['_token'];

        // Save token using TokenModel
        await Provider.of<TokenModel>(context, listen: false).setToken(token);

        // Navigate to HomeScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );

        log('Signup successful. Token: $token');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: Token not found in response')),
        );
      }
    } else {
      log('Response Status: ${response.statusCode}');
      log('Response Body: ${response.body}');
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

  String? previousCountry;
  String? previousCity;
  String? previousCategory;
  String? previousEdu;
  String? previousGender;
  String? previousjob;
  void saveFormData(String? prevCountry, String? prevCity, String? prevCategory,
      String? prevEdu, String? prevGender, String? prevjob) {
    previousCountry = prevCountry;
    previousCity = prevCity;
    previousCategory = prevCategory;
    previousEdu = prevEdu;
    previousGender = prevGender;
    previousjob = prevjob;
    print('previous country: $prevCountry');
  }
}
