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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<BonusResponse?>(
          future: bonusResponseFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData && snapshot.data != null) {
              final affiliateBonus = snapshot.data!.affiliateBonus;
              int remainingBundle = affiliateBonus.bundlePaid;
              int cumulativeTarget = 0;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAchievementCard(remainingBundle),
                  const SizedBox(
                    height: 5,
                  ),
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
                  const SizedBox(height: 16.0),
                  Expanded(
                    child: ListView.builder(
                      itemCount: affiliateBonus.totalBonus.length,
                      itemBuilder: (context, index) {
                        final bonus = affiliateBonus.totalBonus[index];
                        double progress;

                        cumulativeTarget += bonus.target;
                        if (remainingBundle >= bonus.target) {
                          progress = 1.0;
                          remainingBundle -= bonus.target;
                        } else {
                          progress =
                              (remainingBundle / bonus.target).clamp(0.0, 1.0);
                          remainingBundle = 0;
                        }

                        return Column(
                          children: [
                            RewardLevel(
                              level: bonus.title,
                              reward: bonus.bonus,
                              progress: progress,
                              target: cumulativeTarget,
                            ),
                            const SizedBox(height: 20),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return const Center(child: Text('No data available'));
            }
          },
        ),
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
            Text(
              'حقق $target واحصل علي مكافاة  $reward',
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
                    valueColor: AlwaysStoppedAnimation<Color>(
                      progress == 1.0 ? Colors.green : redcolor,
                    ),
                    minHeight: 20,
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: progress == 1.0
                        ? const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.check, color: Colors.white, size: 16),
                              SizedBox(width: 5),
                              Text(
                                'تم الحصول عليها',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        : Text(
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
        ),
      ),
    );
  }
}
