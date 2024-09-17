// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/views/parent%20screens/all_subjects_progress_screen.dart';
import 'package:flutter_application_1/views/parent%20screens/exams_and_hw.dart';
import 'package:flutter_application_1/views/parent%20screens/marketing.dart';
import 'package:flutter_application_1/views/parent%20screens/scheduele_screen.dart'; // Import the screen

class HomeParentGrid extends StatelessWidget {
  int? selchid;
  HomeParentGrid({super.key, this.selchid});

  @override
  Widget build(BuildContext context) {
    List<String> texts = [
      'تقدم الطالب',
      'الامتحانات و الواجبات',
      'التسويق بالعمولة',
      'الحصص و المراجعات',
    ];
    List<String> images = [
      'assets/images/p1.png',
      'assets/images/p3.png',
      'assets/images/layer1.png',
      'assets/images/p4.png',
    ];

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 0.8,
      ),
      itemCount: texts.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            if (texts[index] == 'تقدم الطالب') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StudentAllSubjectsProgressScreen(
                    stid: selchid,
                  ),
                ),
              );
            }
            if (texts[index] == 'الحصص و المراجعات') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScheduleScreen(),
                ),
              );
            }
            if (texts[index] == 'الامتحانات و الواجبات') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ExamResultsAndHwScreen(),
                ),
              );
            }
            if (texts[index] == 'التسويق بالعمولة') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MarketingScreen(),
                ),
              );
            }
          },
          child: Card(
            color: Colors.white,
            elevation: 3,
            shadowColor: redcolor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  texts[index],
                  style: const TextStyle(color: redcolor, fontSize: 20),
                ),
                const SizedBox(
                  height: 7,
                ),
                Image.asset(images[index]),
              ],
            ),
          ),
        );
      },
    );
  }
}
