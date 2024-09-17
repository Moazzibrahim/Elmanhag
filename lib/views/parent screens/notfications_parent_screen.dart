import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/Auth/login_provider.dart';
import 'package:flutter_application_1/controller/notification_helper.dart';
import 'package:flutter_application_1/views/widgets/leading_icon.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class NotificationsParentScreen extends StatelessWidget {
  final int? childId;
  const NotificationsParentScreen({super.key, this.childId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Notifications', style: TextStyle(color: redcolor)),
        leading: const LeadingIcon(),
      ),
      body: FutureBuilder(
        future: fetchSubjectsNotifications(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final data = snapshot.data;

            if (data is Map<String, dynamic>) {
              List<dynamic> oldHomework = data['old_homework'] ?? [];
              List<dynamic> dueHomework = data['due_homework'] ?? [];

              if (oldHomework.isEmpty && dueHomework.isEmpty) {
                return const Center(child: Text('No notifications'));
              } else {
                // Trigger local notifications
                if (dueHomework.isNotEmpty) {
                  for (var homework in dueHomework) {
                    NotificationHelper.showNotification(
                      homework['id'], // Unique ID for the notification
                      'Upcoming Homework',
                      '${homework['title']} is due on ${homework['due_date']}',
                    );
                  }
                }

                if (oldHomework.isNotEmpty) {
                  for (var homework in oldHomework) {
                    NotificationHelper.showNotification(
                      homework['id'],
                      'Missed Homework',
                      '${homework['title']} was missed on ${homework['due_date']}',
                    );
                  }
                }

                return ListView.builder(
                  itemCount: oldHomework.length + dueHomework.length,
                  itemBuilder: (context, index) {
                    if (index < oldHomework.length) {
                      final homework = oldHomework[index];
                      return ListTile(
                        title: Text('Missed Homework: ${homework['title']}'),
                        subtitle: Text(
                          'Due date: ${homework['due_date']} (Missed)',
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    } else {
                      final homework = dueHomework[index - oldHomework.length];
                      return ListTile(
                        title: Text('Upcoming Homework: ${homework['title']}'),
                        subtitle: Text(
                          'Due date: ${homework['due_date']} (Upcoming)',
                          style: const TextStyle(color: Colors.green),
                        ),
                      );
                    }
                  },
                );
              }
            } else {
              return const Center(child: Text('Unexpected data format'));
            }
          } else {
            return const Center(child: Text('No Data Available'));
          }
        },
      ),
    );
  }

  Future<dynamic> fetchSubjectsNotifications(BuildContext context) async {
    final String url = 'https://bdev.elmanhag.shop/parent/notification?student_id=$childId';
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final String? token = tokenProvider.token;

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load subjects. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching subjects: $e');
    }
  }
}
