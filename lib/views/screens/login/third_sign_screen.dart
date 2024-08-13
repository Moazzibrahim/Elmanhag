import 'package:flutter/material.dart';

class ThirdSignUp extends StatelessWidget {
  final String name;
  final String email;
  final String password;
  final String confpassword;
  final String phone;
  final String countryId;
  final String cityId;
  final String categoryId;
  final String language;

  const ThirdSignUp({
    super.key,
    required this.name,
    required this.email,
    required this.password,
    required this.confpassword,
    required this.phone,
    required this.countryId,
    required this.cityId,
    required this.categoryId,
    required this.language,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
