// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/views/screens/Exams/exam_mcq_screen.dart';

class LevelsScreen extends StatefulWidget {
  const LevelsScreen({super.key});

  @override
  State<LevelsScreen> createState() => _LevelsScreenState();
}

class _LevelsScreenState extends State<LevelsScreen> {
  // Adjust taskStars to generate 30 items
  List<int> taskStars = List.generate(30, (index) => index < 4 ? 3 - index : 0);

  int unlockedTasks = 4;
  // Initialize based on how many tasks you want to initially unlock
  void _incrementStars(int index) {
    setState(() {
      if (taskStars[index] < 3) {
        taskStars[index]++;
        if (taskStars[index] == 3 && index + 1 < taskStars.length) {
          unlockedTasks = index + 2;
        }
        // Check if the previous task card has at least 2 stars to unlock the next one
        if (index > 0 && taskStars[index - 1] >= 2) {
          unlockedTasks = index + 1;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection
            .rtl, // Set text direction to RTL for the entire screen
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: taskStars.length,
            itemBuilder: (context, index) {
              if (index < unlockedTasks) {
                return TaskCard(
                  index: index + 1,
                  stars: taskStars[index],
                  onTap: () => _incrementStars(index),
                );
              } else {
                if (index > 0 && taskStars[index - 1] >= 2) {
                  return TaskCard(
                      index: index + 1,
                      stars: taskStars[index],
                      onTap: () {
                        _incrementStars(index);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ExamScreen()));
                      });
                } else {
                  return const LockedCard();
                }
              }
            },
          ),
        ),
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final int index;
  final int stars;
  final VoidCallback onTap;

  const TaskCard({
    required this.index,
    required this.stars,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: redcolor, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'امتحان $index', // Displaying the task number
              style: const TextStyle(
                fontSize: 24,
                color: redcolor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (starIndex) => Icon(
                  starIndex < stars ? Icons.star : Icons.star_border,
                  color: redcolor,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LockedCard extends StatelessWidget {
  const LockedCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Center(
        child: Icon(
          Icons.lock,
          color: Colors.grey,
          size: 48,
        ),
      ),
    );
  }
}
