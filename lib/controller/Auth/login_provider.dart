// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/screens/home_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';

// Create a class to hold the token
class TokenModel with ChangeNotifier {
  String? _token;

  String? get token => _token;

  void setToken(String token) {
    _token = token;
    notifyListeners();
  }
}

class LoginModel with ChangeNotifier {
  int? _id; // Use nullable type for _id
  int? get id => _id; // Define a nullable getter for id

  void setId(int id) {
    _id = id;
    notifyListeners();
  }

  Future<String> loginUser(
      BuildContext context, String email, String password) async {
    String apiUrl = 'https://bdev.elmanhag.shop/api/user/auth/login';
    http.Response? response;

    try {
      response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData.containsKey('_token')) {
          String token = responseData['_token'];
          Provider.of<TokenModel>(context, listen: false).setToken(token);

          if (responseData.containsKey('detailes') &&
              responseData['detailes'] is Map<String, dynamic>) {
            Map<String, dynamic> details = responseData['detailes'];
            if (details.containsKey('id')) {
              int id = details['id'];
              Provider.of<LoginModel>(context, listen: false).setId(id);
            }

            if (details.containsKey('type')) {
              String type = details['type'];
              log("Type: $type");
            }
          }

          log("status code: ${response.statusCode}");
          log("Token: $token");
          log("$responseData");

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );

          return "successful login";
        } else {
          return "Token not found in response";
        }
      } else {
        return "Authentication failed";
      }
    } catch (error) {
      log('Error occurred: $error');

      if (response == null) {
        log('Error: No HTTP response');
      } else {
        log('Response status code: ${response.statusCode}');
        log('Response body: ${response.body}');
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Your email or password is incorrect'),
        ),
      );
      return 'Error occurred while authenticating';
    }
  }
}
