import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/widgets/leading_icon.dart';

class TaskScreen extends StatelessWidget {
  final int taskIndex;

  const TaskScreen({super.key, required this.taskIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task $taskIndex'),
        centerTitle: true,
        leading: const LeadingIcon(),
      ),
      body: Center(
        child: Text(
          'Details for Task $taskIndex',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
