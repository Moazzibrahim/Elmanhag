// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/views/screens/onboarding_screens/onboarding_check.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateTosplash();
  }

  _navigateTosplash() async {
    await Future.delayed(
        const Duration(seconds: 2), () {}); // Duration of the splash screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const OnBoardingCheck()),
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
