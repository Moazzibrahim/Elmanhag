import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/Auth/login_provider.dart';
import 'package:flutter_application_1/views/screens/curriculum/sections_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

Future<void> postSubjectData(String subjectId, BuildContext context) async {
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

      // Check if the response contains chapters
      if (responseData['chapter'] != null && responseData['chapter'].isNotEmpty) {
        // Navigate to SectionsScreen with the chapter data
        Navigator.push(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
            builder: (context) => SectionsScreen(chapters: responseData['chapter']),
          ),
        );
      } else {
        log('No chapters found in response.');
      }
    } else {
      log('Request failed with status: ${response.statusCode}.');
      log(response.body);
    }
  } catch (e) {
    log('Error occurred: $e');
  }
}
