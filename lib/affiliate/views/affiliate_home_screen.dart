// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for clipboard functionality
import 'package:flutter_application_1/affiliate/views/affiliate_profile_screen.dart';
import 'package:flutter_application_1/affiliate/views/rewards_screen.dart';
import 'package:flutter_application_1/affiliate/views/transactions.dart';
import 'package:flutter_application_1/affiliate/views/withdrawal_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/affiliate/models/affiliate_model.dart';
import '../../controller/Auth/logout_provider.dart';
import '../controller/affiliate_provider.dart';
import '../controller/bouns_provider.dart';
import '../models/bouns_model.dart';
import 'help_video_screen.dart';

class AffiliateHomeScreen extends StatelessWidget {
  const AffiliateHomeScreen({super.key});

  Future<AffiliateData?> _fetchProfile(BuildContext context) {
    final apiService = ApiService();
    return apiService.fetchUserProfile(context);
  }

  Future<BonusResponse?> _fetchBonusData(BuildContext context) {
    final bonusService = BonusService();
    return bonusService.fetchBonusData(context); // Fetch bonus data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25),
              FutureBuilder<AffiliateData?>(
                future: _fetchProfile(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return const Text('No profile data found.');
                  } else {
                    AffiliateData userProfile = snapshot.data!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // User Profile Information
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(userProfile.user.imageLink),
                                  radius: 20,
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'اهلا بك ${userProfile.user.name}',
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: redcolor,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'كود التسويق: ${userProfile.user.affilateCode ?? ''}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.copy,
                                              size: 20, color: redcolor),
                                          onPressed: () {
                                            final affiliateCode =
                                                userProfile.user.affilateCode;
                                            if (affiliateCode != null) {
                                              Clipboard.setData(
                                                ClipboardData(
                                                    text: affiliateCode),
                                              ).then((_) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                        'كود التسويق تم نسخه إلى الحافظة'),
                                                  ),
                                                );
                                              });
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      'كود التسويق غير متوفر'),
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.person_outline,
                                      size: 30, color: redcolor),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AffiliateProfileScreen()),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.logout,
                                      size: 30, color: redcolor),
                                  onPressed: () {
                                    LogoutModel().logout(context);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 150,
                              child: _buildInfoCard(
                                '${userProfile.user.income.wallet} ',
                                'الرصيد المتاح',
                                Icons.account_balance_wallet_outlined,
                              ),
                            ),
                            SizedBox(
                              height: 150,
                              child: _buildInfoCard(
                                '${userProfile.user.studentSignups}',
                                'عدد التسجيلات',
                                Icons.person_add_alt_1_outlined,
                              ),
                            ),
                            SizedBox(
                              height: 150,
                              child: _buildInfoCard(
                                '${userProfile.user.income.income}',
                                'الإيرادات الكلية',
                                Icons.attach_money_outlined,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        FutureBuilder<BonusResponse?>(
                          future: _fetchBonusData(context),
                          builder: (context, bonusSnapshot) {
                            if (bonusSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (bonusSnapshot.hasError) {
                              return Text('Error: ${bonusSnapshot.error}');
                            } else if (!bonusSnapshot.hasData ||
                                bonusSnapshot.data == null) {
                              return const Text('No bonus data found.');
                            } else {
                              BonusResponse bonusResponse = bonusSnapshot.data!;
                              AffiliateBonus bonusData =
                                  bonusResponse.affiliateBonus;
                              double progress =
                                  bonusData.bundlePaid / bonusData.target;
                              return _buildProgressSection(
                                  context, bonusData, progress);
                            }
                          },
                        ),
                      ],
                    );
                  }
                },
              ),
              Column(
                children: [
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1,
                    children: [
                      _buildGridOption('المعاملات', Icons.history_outlined, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TransactionsScreen()),
                        );
                      }),
                      _buildGridOption('السحب', Icons.money_off_outlined, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WithdrawalScreen()),
                        );
                      }),
                      _buildGridOption(
                          'فيديوهات مساعده', Icons.play_circle_outline, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HelpVideosScreen()),
                        );
                      }),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressSection(
      BuildContext context, AffiliateBonus bonusData, double progress) {
    if (bonusData.totalBonus.isNotEmpty) {
      int firstBonusTarget = bonusData.totalBonus[0].target;
      int secondBonusTarget = bonusData.totalBonus[1].target;

      int combinedTarget = firstBonusTarget + secondBonusTarget;
      int remainingBundlePaid = bonusData.bundlePaid - firstBonusTarget;
      if (remainingBundlePaid < 0) {
        remainingBundlePaid = 0;
      }

      double progressForSecondBonus = remainingBundlePaid / secondBonusTarget;
      if (progressForSecondBonus > 1.0) {
        progressForSecondBonus = 1.0;
      }

      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              bonusData.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: redcolor,
              ),
            ),
            const SizedBox(height: 10),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'اكمل الهدف ( $combinedTarget ) واحصل على ',
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                  TextSpan(
                    text: '${bonusData.bonus} جنيه',
                    style: const TextStyle(
                      fontSize: 16,
                      color: redcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: ' هديه',
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[300],
                  ),
                  child: Center(
                    child: Text(
                      '${bonusData.bundlePaid}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: redcolor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: LinearProgressIndicator(
                          value: progressForSecondBonus,
                          backgroundColor: Colors.grey[400],
                          color: redcolor,
                          minHeight: 20,
                        ),
                      ),
                      Positioned.fill(
                        child: Center(
                          child: Text(
                            '${(progressForSecondBonus * 100).toStringAsFixed(1)}%',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[300],
                  ),
                  child: Center(
                    child: Text(
                      '$combinedTarget',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: redcolor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => const RewardsScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: redcolor,
                        foregroundColor: Colors.white),
                    child: const Text(
                      'تابع تقدمك',
                      style: TextStyle(fontSize: 18),
                    ))
              ],
            )
          ],
        ),
      );
    } else {
      return const Text('No bonus data available.');
    }
  }

  Widget _buildInfoCard(String amount, String description, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
          Icon(icon, color: Colors.white, size: 36),
          const SizedBox(height: 8),
          Text(
            amount,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build the grid options
  Widget _buildGridOption(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: redcolor, size: 40),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
