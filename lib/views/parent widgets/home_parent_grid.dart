import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/views/parent%20screens/progress_screen.dart'; // Import the screen

class HomeParentGrid extends StatelessWidget {
  const HomeParentGrid({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> texts = [
      'تقدم الطالب',
      'التقدم الدراسي',
      'الامتحانات و الواجبات',
      'الحصص و المراجعات',
    ];
    List<String> images = [
      'assets/images/p1.png',
      'assets/images/p2.png',
      'assets/images/p3.png',
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
              // Navigate to the StudentProgressScreen when 'تقدم الطالب' is tapped
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const StudentProgressScreen(),
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
