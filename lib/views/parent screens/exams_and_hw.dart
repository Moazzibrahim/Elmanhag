import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';

class ExamResultsAndHwScreen extends StatelessWidget {
  const ExamResultsAndHwScreen({super.key});

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
          'الامتحانات والواجبات',
          style: TextStyle(color: redcolor, fontSize: 22),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            SectionHeader(title: 'نتائج الامتحانات'),
            ResultItem(subject: 'امتحان الرياضيات', score: '80%'),
            ResultItem(subject: 'امتحان العلوم', score: '70%'),
            SizedBox(height: 20),
            SectionHeader(title: 'نتائج الواجبات'),
            ResultItem(subject: 'واجب الرياضيات', score: '60%'),
            ResultItem(subject: 'واجب العلوم', score: '90%'),
          ],
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          color: redcolor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class ResultItem extends StatelessWidget {
  final String subject;
  final String score;

  const ResultItem({super.key, required this.subject, required this.score});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(subject),
        trailing: Text(
          score,
          style: const TextStyle(color: redcolor, fontSize: 18),
        ),
      ),
    );
  }
}
