import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeData get _lightTheme => ThemeData(
        brightness: Brightness.light,
        primaryColor: redcolor,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(color: redcolor),
          iconTheme: IconThemeData(color: redcolor),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black), // Default body text
          bodySmall:
              TextStyle(color: Colors.black), // User index or specific text
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      );

  ThemeData get _darkTheme => ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          titleTextStyle: TextStyle(color: Colors.white),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        cardColor: Colors.black54,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: redcolor),
          bodyMedium: TextStyle(color: redcolor),
          bodySmall: TextStyle(color: redcolor),
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
