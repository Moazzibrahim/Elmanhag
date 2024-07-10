// ignore_for_file: use_build_context_synchronously, avoid_print
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
// class Idmodel with ChangeNotifier {
//   late String _id = ''; // Initialize _id with an empty string
//   String get id => _id;

//   void setid(String id) {
//     _id = id;
//     notifyListeners();
//   }
// }
class LoginModel with ChangeNotifier {
  late int _id; // Define the _id variable
  int get id => _id; // Define a getter for id


  void setId(int id) {
    _id = id;
    notifyListeners();
  }

  Future<String> loginUser(
      BuildContext context, String email, String password) async {
    // API endpoint to authenticate user
    String apiUrl = 'https://my.elmanhag.shop/api/login';
    http.Response? response; 

    try {
      response = await http.post(
        // Assign response inside try block
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
        // If authentication is successful, extract token from response
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        String token = responseData['token'];
        int id = responseData['user']['id'];

        // Use provider to set the token
        Provider.of<TokenModel>(context, listen: false).setToken(token);
        Provider.of<LoginModel>(context, listen: false).setId(id);
        log("status code: ${response.statusCode}");
        log("Token: $token");
        log("id: $id");
        log("$responseData");

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );

        return "successful login";
      } else {
        return "Authentication failed";
      }
    } catch (error) {
      log('Error occurred: $error');

      if (response == null) {
        log('Error: No HTTP response');
      } else {
        log('Response status code: ${response.statusCode}'); // Access response variable safely
        log('Response body: ${response.body}'); // Access response variable safely
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
