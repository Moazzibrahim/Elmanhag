// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/Auth/login_provider.dart';
import 'package:flutter_application_1/models/hw_questions_model.dart';
import 'package:flutter_application_1/views/screens/homework/hw_mcq_screen.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomeWorkWidget extends StatefulWidget {
  final List<dynamic> homework;

  const HomeWorkWidget({super.key, required this.homework});

  @override
  HomeWorkWidgetState createState() => HomeWorkWidgetState();
}

class HomeWorkWidgetState extends State<HomeWorkWidget> {
  late List<int> taskStars;
  int unlockedTasks = 1;

  @override
  void initState() {
    super.initState();
    taskStars = List.generate(widget.homework.length,
        (index) => 0); // Ensure taskStars length matches homework length

    // Log homework IDs if they exist
    if (widget.homework.isNotEmpty) {
      for (var item in widget.homework) {
        if (item is Map<String, dynamic> && item.containsKey('id')) {
          print('Homework ID: ${item['id']}');
        }
      }
    } else {
      // Show a dialog if no homework items exist
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('No Homework Items'),
              content: const Text('There are no homework items available.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      });
    }
  }

  Future<void> sendHomeworkId(int homeworkId) async {
    final url = Uri.parse(
        'https://bdev.elmanhag.shop/student/chapter/lesson/MyHmework');
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({'homework_id': homeworkId}),
      );

      if (response.statusCode == 200) {
        print('Homework ID sent successfully');
        log("response: ${response.body}");
        final responseData = json.decode(response.body);

        // Parse the response using the HomeworkResponse model
        final homeworkResponse = HomeworkResponse.fromJson(responseData);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeworkMcqScreen(
                homeworkResponse: homeworkResponse,
                hwid: widget.homework.first['id']),
          ),
        );
        log("hwid: ${widget.homework.first['id']}");
      } else {
        print('Failed to send Homework ID: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    bool isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      decoration: isDarkMode
          ? const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Ellipse 198.png'),
                fit: BoxFit.cover,
              ),
            )
          : null,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: widget.homework.length,
                itemBuilder: (context, index) {
                  if (index < unlockedTasks) {
                    return TaskCard(
                      index: index + 1,
                      stars: taskStars[index],
                      onTap: () {
                        if (index < widget.homework.length) {
                          sendHomeworkId(widget.homework[index]['id']);
                        } else {
                          print('Index out of range');
                        }
                      },
                    );
                  } else {
                    return const LockedCard();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final int index;
  final int stars;
  final VoidCallback onTap;

  const TaskCard({
    required this.index,
    required this.stars,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    bool isDarkMode = theme.brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border:
              Border.all(color: isDarkMode ? Colors.black : redcolor, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Homework $index',
              style: const TextStyle(
                fontSize: 16,
                color: redcolor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (starIndex) => Icon(
                  starIndex < stars ? Icons.star : Icons.star_border,
                  color: redcolor,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LockedCard extends StatelessWidget {
  const LockedCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    bool isDarkMode = theme.brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.black : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Center(
        child: Icon(
          Icons.lock,
          color: Colors.grey,
          size: 48,
        ),
      ),
    );
  }
}
