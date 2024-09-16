// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/Auth/login_provider.dart';
import 'package:flutter_application_1/views/screens/curriculum/mycurriculum/sections_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';

import '../views/screens/login/login_screen.dart';

Future<void> postSubjectData(
    String subjectId, String coverPhotoUrl, BuildContext context) async {
  final tokenProvider = Provider.of<TokenModel>(context, listen: false);
  final token = tokenProvider.token;

  final url =
      Uri.parse('https://bdev.elmanhag.shop/student/mySubject/chapter/view');

  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };

  Map<String, String> body = {
    'subject_id': subjectId,
  };

  // Show loading dialog with rotating image indicator
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const Center(
        child:
            RotatingImageIndicator(clockwise: true), // Use your custom widget
      );
    },
  );

  // Log the data being posted
  log('Posting data to API:');
  log('URL: $url');
  log('Headers: $headers');
  log('Body: $body');

  try {
    final response = await http.post(
      url,
      headers: headers,
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      log('Response data: $responseData');

      if (responseData['chapter'] != null &&
          responseData['chapter'].isNotEmpty) {
        // Close the loading dialog
        Navigator.of(context).pop();

        // Navigate to the SectionsScreen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SectionsScreen(
              chapters: responseData['chapter'],
              subjectId: subjectId,
              coverPhotoUrl: coverPhotoUrl,
            ),
          ),
        );
      } else {
        log('No chapters found in response.');
        Navigator.of(context).pop(); // Close the loading dialog
      }
    } else {
      log('Request failed with status: ${response.statusCode}.');
      log(response.body);
      Navigator.of(context).pop(); // Close the loading dialog
    }
  } catch (e) {
    log('Error occurred: $e');
    Navigator.of(context).pop(); // Close the loading dialog
  }
}
