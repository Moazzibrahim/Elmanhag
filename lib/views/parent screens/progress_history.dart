// ignore_for_file: avoid_print
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/Auth/login_provider.dart';
import 'package:flutter_application_1/models/parent%20models/progress_history_model.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StudyProgressScreen extends StatelessWidget {
  final int? sttidd;
  const StudyProgressScreen({super.key, this.sttidd});

  @override
  Widget build(BuildContext context) {
    Future<List<ProgressHistoryModel>> postStudentProgress(
        BuildContext context) async {
      final url =
          Uri.parse('https://bdev.elmanhag.shop/parent/subjects/progress');
      final tokenProvider = Provider.of<TokenModel>(context, listen: false);
      final String? token = tokenProvider.token;

      final body = jsonEncode({
        'student_id': sttidd,
      });

      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      try {
        final response = await http.post(
          url,
          headers: headers,
          body: body,
        );

        // Log the raw response from the backend
        print('Backend response: ${response.body}');

        if (response.statusCode == 200) {
          final List<dynamic> jsonData = jsonDecode(response.body);
          // Convert the list of dynamic data to a list of ProgressHistoryModel objects
          List<ProgressHistoryModel> progressHistoryList = jsonData
              .map((json) =>
                  ProgressHistoryModel.fromJson(json as Map<String, dynamic>))
              .toList();

          // Log the progress values
          for (var progressHistory in progressHistoryList) {
            print(
                'Subject: ${progressHistory.subject?.name}, Progress: ${progressHistory.progress}%');
          }
          log("sttt:$sttidd");

          return progressHistoryList;
        } else {
          throw Exception('Failed to load progress history');
        }
      } catch (e) {
        throw Exception('Error: $e');
      }
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: InkWell(
            child: const Icon(Icons.arrow_back, color: redcolor),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'التقدم الدراسى',
            style: TextStyle(color: redcolor, fontSize: 22),
          ),
        ),
        body: FutureBuilder<List<ProgressHistoryModel>>(
          future: postStudentProgress(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              final progressHistoryList = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                  itemCount: progressHistoryList.length,
                  itemBuilder: (context, index) {
                    final progressHistory = progressHistoryList[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionTitle(
                            title: 'المادة: ${progressHistory.subject?.name}'),
                        TaskProgress(
                          task: 'التقدم الدراسي',
                          progress: progressHistory
                              .progress!, // Assuming progress is out of 100
                          progressColor: redcolor,
                          progresstext: '${progressHistory.progress!} %',
                        ),
                      ],
                    );
                  },
                ),
              );
            } else {
              return const Text('No data found');
            }
          },
        ));
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, color: redcolor),
      ),
    );
  }
}

class TaskProgress extends StatelessWidget {
  final String task;
  final int progress; 
  final Color progressColor;
  final String progresstext;

  const TaskProgress({
    super.key,
    required this.task,
    required this.progress,
    required this.progressColor,
    required this.progresstext,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress / 100, // Normalize progress value to 0.0 - 1.0
              backgroundColor: Colors.grey[300],
              color: progressColor,
              minHeight: 10,
            ),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                progresstext, // Display percentage as text
                style: const TextStyle(color: redcolor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
