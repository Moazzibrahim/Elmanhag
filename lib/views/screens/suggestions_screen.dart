import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class ComplaintsSuggestionsScreen extends StatelessWidget {
  const ComplaintsSuggestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'الاقتراحات والشكاوى',
          style: TextStyle(
            color: redcolor,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: redcolor),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'نحن نقدر ملاحظاتك واسمحوا لنا أن نعرف شكواك أو اقتراحات',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                height: 1.5, // Increases line spacing
              ),
            ),
            const SizedBox(height: 40),
            TextField(
              decoration: InputDecoration(
                hintText: 'اكتب اقتراحك او شكوكك هنا',
                hintStyle: TextStyle(color: Colors.grey[400]),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.red[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: redcolor, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Handle button press
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: redcolor, // Background color
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'ارسال',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
