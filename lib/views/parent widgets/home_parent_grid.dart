// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/affiliate/views/affiliate_home_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/Auth/login_provider.dart';
import 'package:flutter_application_1/views/parent%20screens/all_subjects_progress_screen.dart';
import 'package:flutter_application_1/views/parent%20screens/exams_and_hw.dart';
import 'package:flutter_application_1/views/parent%20screens/scheduele_screen.dart'; // Import the screen
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomeParentGrid extends StatelessWidget {
  int? selchid;
  HomeParentGrid({super.key, this.selchid});

  Future<void> becomeAffiliate(BuildContext context) async {
    final url = Uri.parse("https://bdev.elmanhag.shop/api/createAffilate");
    final token = Provider.of<TokenModel>(context, listen: false).token;
    final userId = Provider.of<LoginModel>(context, listen: false).id;

    // Log the user ID for debugging purposes
    log("User ID: $userId");

    // Check if the userId is null before proceeding
    if (userId == null) {
      _showSnackbar(context, 'User ID is not available. Please log in again.');
      return; // Exit the method if the user ID is null
    }

    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "user_id": userId,
        }),
      );

      // Dismiss loading indicator
      Navigator.of(context).pop();

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final affiliateCode = data['affilate_code'];
        log('Affiliate Code: $affiliateCode');
        // Navigate to AffiliateHomeScreen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const AffiliateHomeScreen(),
          ),
        );
      } else {
        _showSnackbar(context,
            'failed due to internet connection: ${response.statusCode}');
      }
    } catch (e) {
      // Dismiss loading indicator on error
      Navigator.of(context).pop();
      log('Error occurred: $e'); // Log error for debugging
      _showSnackbar(context, 'Error: $e');
    }
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> texts = [
      'تقدم الطالب',
      'الامتحانات و الواجبات',
      ' اربح مع المنهج',
      'الحصص و المراجعات',
    ];
    List<String> images = [
      'assets/images/p1.png',
      'assets/images/p3.png',
      'assets/images/layer1.png',
      'assets/images/p4.png',
    ];

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 0.8,
      ),
      itemCount: texts.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            if (texts[index] == 'تقدم الطالب') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StudentAllSubjectsProgressScreen(
                    stid: selchid,
                  ),
                ),
              );
            }
            if (texts[index] == 'الحصص و المراجعات') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScheduleScreen(),
                ),
              );
            }
            if (texts[index] == 'الامتحانات و الواجبات') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ExamResultsAndHwScreen(),
                ),
              );
            }
            if (texts[index] == ' اربح مع المنهج') {
              becomeAffiliate(context);
            }
          },
          child: Card(
            color: Colors.white,
            elevation: 3,
            shadowColor: redcolor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  texts[index],
                  style: const TextStyle(color: redcolor, fontSize: 20),
                ),
                const SizedBox(
                  height: 7,
                ),
                Image.asset(images[index]),
              ],
            ),
          ),
        );
      },
    );
  }
}
