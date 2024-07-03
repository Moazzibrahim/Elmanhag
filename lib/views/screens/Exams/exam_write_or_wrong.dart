// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';

class ExamScreenWriteOrWrong extends StatefulWidget {
  const ExamScreenWriteOrWrong({super.key});

  @override
  State<ExamScreenWriteOrWrong> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreenWriteOrWrong> {
  bool? _isCorrect;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: redcolor,
          ),
          onPressed: () {
            // Handle back button press
            Navigator.pop(context);
          },
        ),
        title: const Center(
          child: Text(
            'الامتحان',
            style: TextStyle(
              color: redcolor,
              fontSize: 28,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              'ضع علامه صح ام خطأ',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            const Text(
              'هل القاسم المشترك الأكبر للعددين 12 و 18 هو 10؟',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w600, color: greycolor),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isCorrect = false;
                      });
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: redcolor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isCorrect = true;
                      });
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    // Handle previous button press
                  },
                  child: const Text(
                    'السابق',
                    style: TextStyle(
                      fontSize: 16,
                      color: redcolor,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    backgroundColor: redcolor,
                  ),
                  onPressed: () {
                    // Handle next button press
                  },
                  child: const Text(
                    'التالي',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
