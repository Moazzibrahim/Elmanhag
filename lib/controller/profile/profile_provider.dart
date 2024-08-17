// ignore_for_file: avoid_print, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/controller/Auth/login_provider.dart';
class UserProfileProvider with ChangeNotifier {
  String? _name;
  String? _email;
  String? _phone;
  String? _image;
  String? _role;
  String? _countryName;
  String? _cityName;
  String? _education;
  bool _isLoading = false;
  String? _parentName;
  String? _parentPhone;
  String? _parentEmail;
  String? _category;

  String? get name => _name;
  String? get email => _email;
  String? get phone => _phone;
  String? get image => _image;
  String? get role => _role;
  String? get countryName => _countryName;
  String? get cityName => _cityName;
  String? get education => _education;
  String? get category => _category;
  bool get isLoading => _isLoading;
  String? get parentName => _parentName;
  String? get parentPhone => _parentPhone;
  String? get parentEmail => _parentEmail;

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
        final user = data['user'];

        // User details
        _name = user['name'];
        _email = user['email'];
        _phone = user['phone'];
        _image = user['image']['url'];
        _role = user['role'];
        _countryName = user['country_name'];
        _cityName = user['city_name'];
        _education = user['education'];
        _category = user['category']['name'];

        // Parent details
        if (user['parents'] is List && user['parents'].isNotEmpty) {
          final parent = user['parents'][0];
          _parentName = parent['name'];
          _parentPhone = parent['phone'];
          _parentEmail = parent['email'];
        } else {
          // Handle case where there are no parents
          _parentName = 'N/A';
          _parentPhone = 'N/A';
          _parentEmail = 'N/A';
        }
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
