// ignore_for_file: use_build_context_synchronously


import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/Auth/login_provider.dart';
import 'package:flutter_application_1/views/screens/login/login_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';
import 'package:provider/provider.dart'; // Import Provider

class LogoutModel with ChangeNotifier {
  Future<void> logout(BuildContext context) async {
    try {
      final tokenProvider = Provider.of<TokenModel>(context, listen: false);
      final token = tokenProvider.token;
      final response = await http.post(
        Uri.parse('https://elmanhag.shop/backend/public/api/admin/auth/logout'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        log('Logout successful');
        log(response.body);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Check connection please')));
        log('Logout failed');
        log('Status code: ${response.statusCode}');
        log('Response body: ${response.body}');
      }
    } catch (error) {
      log('Error: $error');
    }
  }
}
