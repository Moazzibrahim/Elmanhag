import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import '../controller/bouns_provider.dart';
import '../models/bouns_model.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  _RewardsScreenState createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  late Future<BonusResponse?> bonusResponseFuture;

  @override
  void initState() {
    super.initState();
    bonusResponseFuture = BonusService().fetchBonusData(context);
  }

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
      body: FutureBuilder<BonusResponse?>(
        future: bonusResponseFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching data'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No data available'));
          }

          final bonusData = snapshot.data!;
          final bundlePaid = bonusData.bundlePaid;
          final bonuses = bonusData.bonus;

          return Column(
            children: [
              _buildAchievementCard(bundlePaid),
              const SizedBox(height: 5),
              const Center(
                child: Text(
                  'حققت',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: redcolor,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: bonuses.length,
                  itemBuilder: (context, index) {
                    final totalBonus = bonuses[index];
                    final target = totalBonus.target;

                    // Calculate progress
                    double progress = bundlePaid / target;
                    if (progress > 1.0) progress = 1.0;

                    // Reset progress to 0 if previous levels are not achieved
                    if (index > 0) {
                      final previousTarget = bonuses[index - 1].target;
                      double previousProgress = bundlePaid / previousTarget;

                      if (previousProgress < 1.0) {
                        progress = 0;
                      }
                    }

                    return RewardLevel(
                      level: totalBonus.title,
                      reward: totalBonus.bonus,
                      progress: progress,
                      target: target,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAchievementCard(int remainingBundle) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: redcolor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: redcolor.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.done_outline_sharp,
                  color: Colors.white, size: 36),
              const SizedBox(height: 8),
              Text(
                '$remainingBundle',
                style: const TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }
}

class RewardLevel extends StatelessWidget {
  final String level;
  final String reward;
  final double progress;
  final int target;

  const RewardLevel({
    super.key,
    required this.level,
    required this.reward,
    required this.progress,
    required this.target,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              level,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Center(
              child: Text(
                'حقق $target واحصل علي مكافاة $reward جنية',
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
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
                    valueColor: AlwaysStoppedAnimation<Color>(
                      progress == 1.0 ? Colors.green : redcolor,
                    ),
                    minHeight: 20,
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: Text(
                      '${(progress * 100).toInt()}%',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
