import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationHelper {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("@mipmap/amin2");

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _notificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> showNotification(
      int id, String title, String body) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> seenNotifications =
        prefs.getStringList('seen_notifications') ?? [];

    // Check if the notification has already been shown
    if (!seenNotifications.contains(id.toString())) {
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails('channel_id', 'channel_name',
              enableVibration: true,
              importance: Importance.max,
              priority: Priority.high,
              icon: "@mipmap/amin2");
      const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);

      // Show notification
      await _notificationsPlugin.show(
          id, title, body, platformChannelSpecifics);

      // Mark the notification as seen
      seenNotifications.add(id.toString());
      await prefs.setStringList('seen_notifications', seenNotifications);
    }
  }
}
