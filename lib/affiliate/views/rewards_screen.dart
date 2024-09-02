import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: redcolor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'المكافأت',
          style: TextStyle(
            color: redcolor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            RewardLevel(
              level: 'المستوي الاول',
              reward: '2000 جنيه',
              progress: 1.0,
            ),
            SizedBox(height: 20),
            RewardLevel(
              level: 'المستوي الثاني',
              reward: '5000 جنيه',
              progress: 0.55,
            ),
            SizedBox(height: 20),
            RewardLevel(
              level: 'المستوي الثالث',
              reward: '6000 جنيه',
              progress: 0.0,
            ),
          ],
        ),
      ),
    );
  }
}

class RewardLevel extends StatelessWidget {
  final String level;
  final String reward;
  final double progress;

  const RewardLevel({
    super.key,
    required this.level,
    required this.reward,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '$level مكافأة $reward',
          style: TextStyle(
            color: Colors.grey[800],
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[300],
                color: redcolor,
                minHeight: 20,
              ),
            ),
            Positioned.fill(
              child: Center(
                child: Text(
                  '${(progress * 100).toInt()}%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
