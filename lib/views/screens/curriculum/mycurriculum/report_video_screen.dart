import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/Auth/login_provider.dart';
import 'package:flutter_application_1/controller/report_provider.dart';
import 'package:flutter_application_1/models/report_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';

class ReportVideoScreen extends StatelessWidget {
  final int lessonId;

  const ReportVideoScreen({super.key, required this.lessonId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'الإبلاغ عن مشكلة بالفيديو',
          style: TextStyle(
            color: redcolor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: redcolor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<IssuesData?>(
        future: fetchIssuesData(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('فشل في تحميل المشاكل'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('لا توجد مشاكل متاحة'));
          }

          final issuesData = snapshot.data!;
          final videoIssues = issuesData.videoIssues;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.separated(
              itemCount: videoIssues.length,
              separatorBuilder: (context, index) => const Divider(height: 20),
              itemBuilder: (context, index) {
                final issue = videoIssues[index];
                return _buildProblemOption(context, issue.title, issue.id);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildProblemOption(BuildContext context, String text, int issueId) {
    return InkWell(
      onTap: () {
        _reportIssue(context, issueId);
      },
      splashColor: redcolor,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 249, 235, 234),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(
              Icons.error_outline,
              color: redcolor,
              size: 28,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _reportIssue(BuildContext context, int issueId) async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final String? token = tokenProvider.token; // Retrieve the token

    final url = Uri.parse('https://bdev.elmanhag.shop/student/issues');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Use the retrieved token
        },
        body: json.encode({
          'issue_id': issueId,
          'type': 'video',
          'id': lessonId,
        }),
      );

      if (response.statusCode == 200) {
        log(response.body);
        _showSuccessDialog(context);
      } else {
        _showErrorSnackbar(context, response.body);
      }
    } catch (e) {
      // Handle any exceptions
      _showErrorSnackbar(context, 'Error: $e');
    }
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('نجاح'),
          content: const Text('تم إرسال شكواك بنجاح. سيتم حلها في أقرب وقت.'),
          actions: [
            TextButton(
              child: const Text('موافق'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  void _showErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: redcolor,
      ),
    );
  }
}
