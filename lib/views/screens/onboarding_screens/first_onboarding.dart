// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/views/screens/onboarding_screens/second_onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              _buildTitle(),
              const SizedBox(height: 20),
              _buildSubtitle(),
              const SizedBox(height: 10),
              _buildDescription(),
              const SizedBox(height: 20),
              _buildImageStack(context),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return const Text(
      'المنهج',
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w500,
        color: redcolor,
      ),
    );
  }

  Widget _buildSubtitle() {
    return const Text(
      "! مع تطبيقنا المميز ",
      style: TextStyle(
        fontSize: 25,
        color: redcolor,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _buildDescription() {
    return const Text(
      'هيا بنا نتعلم ونلعب مع تطبيقنا المرح! رحلة تعليمية ممتعة من أولى ابتدائي لحد ثالثة إعدادي!',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 20,
      ),
    );
  }

  Widget _buildImageStack(BuildContext context) {
    return Expanded(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/Group 6.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Image.asset(
              'assets/images/new1.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 20,
            child: _buildNextButton(context),
          ),
        ],
      ),
    );
  }

  Widget _buildNextButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isNewUser', false);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const SecondOnboardingScreen(),
        ));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: redcolor,
        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: const Text(
        'التالي',
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    );
  }
}
