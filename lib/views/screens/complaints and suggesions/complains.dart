import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/localization/app_localizations.dart';
import 'package:flutter_application_1/views/screens/home_screen.dart';

class ComplaintSuggestionScreen extends StatelessWidget {
  const ComplaintSuggestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: redcolor),
          onPressed: () {
            // Add your back button logic here
          },
        ),
        title: Text(
          localizations.translate('complaints_suggestions'),
          style: const TextStyle(color: redcolor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(
              localizations.translate('complaints_suggestions_description'),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 40),
            TextField(
              maxLines: 5,
              decoration: InputDecoration(
                hintText: localizations.translate('write_complaint_suggestion'),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: redcolor),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: redcolor),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Add submit logic here
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content:
                        Text(localizations.translate('submit_success_message')),
                    backgroundColor: redcolor,
                  ),
                );
                Future.delayed(
                  const Duration(seconds: 2),
                  () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const HomeScreen()));
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: redcolor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                localizations.translate('send'),
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
