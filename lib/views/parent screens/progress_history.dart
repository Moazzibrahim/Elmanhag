import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';

class StudyProgressScreen extends StatelessWidget {
  const StudyProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          child: const Icon(Icons.arrow_back, color: redcolor),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'التقدم الدراسى',
          style: TextStyle(color: redcolor, fontSize: 22),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            SectionTitle(title: 'المهام المكتمله'),
            TaskProgress(
              task: 'واجب الرياضيات',
              progress: 0.55,
              progressColor: redcolor,
            ),
            TaskProgress(
              task: 'واجب العلوم',
              progress: 0.60,
              progressColor: redcolor,
            ),
            SizedBox(height: 20),
            SectionTitle(title: 'المهام المتبقيه'),
            RemainingTask(
              task: 'واجب الرياضيات',
              deadline: 'تسليم بتاريخ 20 مايو',
            ),
            RemainingTask(
              task: 'امتحان العلوم',
              deadline: '25 مايو',
            ),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, color: redcolor),
      ),
    );
  }
}

class TaskProgress extends StatelessWidget {
  final String task;
  final double progress;
  final Color progressColor;

  const TaskProgress({
    super.key,
    required this.task,
    required this.progress,
    required this.progressColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[300],
              color: progressColor,
              minHeight: 10,
            ),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '${(progress * 100).toInt()}%',
                style: const TextStyle(color: redcolor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RemainingTask extends StatelessWidget {
  final String task;
  final String deadline;

  const RemainingTask({super.key, required this.task, required this.deadline});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              task,
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              deadline,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
