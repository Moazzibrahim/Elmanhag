import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'الاشعارات',
          style: TextStyle(color: redcolor, fontSize: 20),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: redcolor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            _buildNotificationItem(
              'تم لإشتراك الطالب محمد في باقه كل المواد',
              '12:00 ص',
              'assets/images/avatar1.png',
            ),
            const Divider(),
            _buildNotificationItem(
              'لقد سحبت 1000 جنيه من أرباحك',
              '12:00 ص',
              'assets/images/avatar2.png',
            ),
            const Divider(),
            _buildNotificationItem(
              'عمل رائع هذا الشهر.',
              '12:00 ص',
              'assets/images/avatar3.png',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationItem(
      String message, String time, String avatarPath) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(avatarPath),
            radius: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      time,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
