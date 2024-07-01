import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/screens/login/login_screen.dart';
import 'package:flutter_application_1/views/screens/onboarding_screens/first_onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingCheck extends StatefulWidget {
  const OnBoardingCheck({super.key});

  @override
  State<OnBoardingCheck> createState() => _OnBoardingCheckState();
}

class _OnBoardingCheckState extends State<OnBoardingCheck> {
  bool _isNewUser = false;

  @override
  void initState() {
    super.initState();
    checkIfNewUser();
  }

  Future<void> checkIfNewUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isNewUser = prefs.getBool('isNewUser') ?? true;
    setState(() {
      _isNewUser = isNewUser;
    });
  }

  void _setLoggedIn(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', value);
  }

  @override
  Widget build(BuildContext context) {
    if (_isNewUser) {
      return const OnboardingScreen();
    } else {
      _setLoggedIn(true); // Update login state
      return const LoginScreen();
    }
  }
}
