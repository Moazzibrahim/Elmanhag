import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/theme/theme_provider.dart';
import 'package:flutter_application_1/views/screens/curriculum/filter_curriclums_screen.dart';
import 'package:flutter_application_1/views/screens/curriculum/my_curriculum_screen.dart';
import 'package:provider/provider.dart'; // Import Provider package

class CurriculumsScreen extends StatelessWidget {
  const CurriculumsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the ThemeProvider instance
    final themeProvider = Provider.of<ThemeProvider>(context);

    // Determine the background image based on the current theme
    final backgroundImage = themeProvider.isDarkMode
        ? 'assets/images/backgrounddark.png' // Dark mode image
        : 'assets/images/background.png'; // Light mode image

    // Get text color based on the current theme
    final textColor = themeProvider.isDarkMode ? Colors.black : Colors.white;

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              backgroundImage, // Use the determined image
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(
                16.0), // Increased padding for better spacing
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      color: redcolor,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                  ],
                ),
                const SizedBox(height: 280),
                Row(
                  children: [
                    Expanded(
                      child: WidgtButton(
                        context,
                        'موادي',
                        const MyCurriculumScreen(), // Replace with your screen
                        textColor: textColor, // Pass text color
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: WidgtButton(
                        context,
                        'كل المواد',
                        FilterCurriculumsScreen(), // Replace with your screen
                        textColor: textColor, // Pass text color
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WidgtButton extends StatelessWidget {
  final BuildContext context;
  final String text;
  final Widget screen;
  final Color textColor; // Add textColor parameter

  const WidgtButton(this.context, this.text, this.screen,
      {super.key, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: const EdgeInsets.symmetric(vertical: 8), // Margin between buttons
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            // color: Colors.grey,
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: textColor, // Set text color
          backgroundColor: redcolor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 20), // Adjusted padding
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor, // Set text color
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
