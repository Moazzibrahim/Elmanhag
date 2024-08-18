// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/views/screens/onboarding_screens/onboarding_check.dart';
import 'package:flutter_application_1/views/screens/home_screen.dart';
import 'package:flutter_application_1/views/parent screens/home_parent_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/controller/Auth/login_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateBasedOnToken();
  }

  Future<void> _navigateBasedOnToken() async {
    // Delay for splash screen duration
    await Future.delayed(const Duration(seconds: 2));

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token != null) {
      // Token found, update TokenModel and navigate to home screen
      Provider.of<TokenModel>(context, listen: false).setToken(token);

      // Fetch user role or other necessary data from backend
      final loginModel = Provider.of<LoginModel>(context, listen: false);
      final userRole = await _fetchUserRole(token); // Implement this function based on your API

      loginModel.setRole(userRole);
      _navigateToHome();
    } else {
      // No token found, navigate to onboarding
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnBoardingCheck()),
      );
    }
  }

  Future<String> _fetchUserRole(String token) async {
    // Implement API call to fetch user role based on token
    // Return the user role or an empty string if not found
    return 'student'; // Replace this with actual role fetching logic
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          final role = Provider.of<LoginModel>(context, listen: false).role;
          return role == 'parent'
              ? const HomeParentScreen()
              : const HomeScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Background Circles
          const Positioned(
            left: -30,
            top: 100,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: redcolor,
            ),
          ),
          const Positioned(
            left: 50,
            top: 200,
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.blue,
            ),
          ),
          const Positioned(
            right: 50,
            top: 150,
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.yellow,
            ),
          ),
          // Main Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/amin2.png",
                  width: 200,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          // Status Bar Placeholder
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 30,
              color: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
