import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  // Light theme configuration
  ThemeData get _lightTheme => ThemeData(
        brightness: Brightness.light,
        primaryColor: redcolor,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: redcolor,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      );

  // Dark theme configuration
  ThemeData get _darkTheme => ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
        ),
        cardColor: Colors.black54, // Adding a dark card color
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: redcolor),
          titleLarge: TextStyle(color: redcolor), // Adjust headline color
        ),
        iconTheme: const IconThemeData(color: redcolor),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.black),
            foregroundColor: WidgetStateProperty.all(redcolor),
          ),
        ),
      );

  ThemeData get currentTheme => _isDarkMode ? _darkTheme : _lightTheme;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
