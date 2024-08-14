// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/parent%20screens/home_parent_screen.dart';
import 'package:flutter_application_1/views/screens/home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class TokenModel with ChangeNotifier {
  String? _token;
  String? get token => _token;

  void setToken(String token) {
    _token = token;
    notifyListeners();
  }
}

class LoginModel with ChangeNotifier {
  String? _role;
  String? get role => _role;

  void setRole(String role) {
    _role = role;
    notifyListeners();
  }

  static const String apiUrl = 'https://bdev.elmanhag.shop/student/auth/login';
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<String> loginUser(
      BuildContext context, String email, String password) async {
    // Validate empty fields
    if (email.isEmpty || password.isEmpty) {
      String message = 'Invalid: ';
      if (email.isEmpty) message += 'Email is empty. ';
      if (password.isEmpty) message += 'Password is empty.';
      _showSnackbar(context, message);
      return message;
    }

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: json.encode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData.containsKey('faield')) {
          final errorMessage = responseData['faield'];
          log("Login Failed: $errorMessage");
          _showSnackbar(context, errorMessage);
          return 'Login failed: $errorMessage';
        }

        if (responseData.containsKey('_token')) {
          final String token = responseData['_token'];
          Provider.of<TokenModel>(context, listen: false).setToken(token);

          final userDetails = responseData['user'] as Map<String, dynamic>;
          _handleUserDetails(context, userDetails);

          log("Response Data: $responseData");
          log("Status Code: ${response.statusCode}");
          log("Token: $token");
          log("Role: $_role");

          return "";
        } else {
          return "Token not found in response";
        }
      } else {
        log("Authentication failed with status code: ${response.statusCode}");
        return 'خطأ في التسجيل';
      }
    } catch (error) {
      log('Error occurred during authentication: $error');
      return 'خطأ في التسجيل';
    }
  }

  void _handleUserDetails(
      BuildContext context, Map<String, dynamic> userDetails) {
    if (userDetails.containsKey('role')) {
      final String role = userDetails['role'];
      setRole(role);
      _navigateBasedOnRole(context, role);
    } else {
      _showSnackbar(context, 'Role not found in response');
    }
  }

  void _navigateBasedOnRole(BuildContext context, String role) {
    if (role == 'student') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else if (role == 'parent') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeParentScreen()),
      );
    } else {
      log('Unknown user role: $role');
      _showSnackbar(context, 'Unknown user role');
    }
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
