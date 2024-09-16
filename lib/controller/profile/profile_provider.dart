// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/profile_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/controller/Auth/login_provider.dart';

class UserProfileProvider with ChangeNotifier {
  User? _user;
  bool _isLoading = false;

  User? get user => _user;
  bool get isLoading => _isLoading;

  Future<void> fetchUserProfile(BuildContext context) async {
    final url = Uri.parse('https://bdev.elmanhag.shop/student/profile/view');
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;

    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        final userResponse = UserResponse.fromJson(data);

        // Set the user data
        _user = userResponse.user;
      } else {
        // Handle non-200 responses
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load user profile: ${response.statusCode}')),
        );
      }
    } catch (error) {
      print('Error fetching user profile: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching user profile: $error')),
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
