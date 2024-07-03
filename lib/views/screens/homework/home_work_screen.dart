import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/views/widgets/leading_icon.dart';
import 'task_screen.dart';

class HomeWorkScreen extends StatefulWidget {
  const HomeWorkScreen({super.key});

  @override
  HomeWorkScreenState createState() => HomeWorkScreenState();
}

class HomeWorkScreenState extends State<HomeWorkScreen> {
  List<int> taskStars = List.generate(30, (index) => 0);
  int unlockedTasks = 1; // Only one task initially unlocked

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const LeadingIcon(),
      ),
      body: Padding(
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TaskScreen(taskIndex: index + 1),
                    ),
                  );
                },
              );
            } else {
              return const LockedCard();
            }
          },
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
              'Task $index', // Displaying the task number
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
