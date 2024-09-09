import 'package:flutter/material.dart';
import 'package:flutter_application_1/affiliate/views/notifications.dart';
import 'package:flutter_application_1/affiliate/views/profile_screen.dart';
import 'package:flutter_application_1/affiliate/views/rewards_screen.dart';
import 'package:flutter_application_1/affiliate/views/transactions.dart';
import 'package:flutter_application_1/affiliate/views/withdrawal_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/affiliate/models/affiliate_model.dart';
import 'package:flutter_application_1/views/screens/Exams/exam_mcq_screen.dart';
import '../controller/affiliate_provider.dart';

class AffiliateHomeScreen extends StatelessWidget {
  const AffiliateHomeScreen({super.key});

  Future<AffiliateData?> _fetchProfile(BuildContext context) {
    final apiService = ApiService();
    return apiService
        .fetchUserProfile(context); // Ensure this method exists in ApiService
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
                      // Header with user image and name
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
                              Text(
                                'اهلا بك ${userProfile.user.name}',
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: redcolor,
                                ),
                              ),
                            ],
                          ),
                          // Notification and Profile buttons
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
                                            const ProfileScreen()),
                                  );
                                },
                              ),
                              Stack(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.notifications_none,
                                        size: 30, color: redcolor),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const NotificationsScreen()),
                                      );
                                    },
                                  ),
                                  Positioned(
                                    top: 10,
                                    right: 10,
                                    child: Container(
                                      width: 8,
                                      height: 8,
                                      decoration: const BoxDecoration(
                                        color: redcolor,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Show the available wallet balance using the dynamic data
                          _buildInfoCard(
                              '${userProfile.user.income.wallet} ج.م',
                              'الرصيد المتاح',
                              Icons.account_balance_wallet_outlined),
                          const SizedBox(width: 10),
                          _buildInfoCard('10', 'عدد التسجيلات',
                              Icons.person_add_alt_1_outlined),
                          const SizedBox(width: 10),
                          // Show the total income using the dynamic data
                          _buildInfoCard(
                              '${userProfile.user.income.income} ج.م',
                              'الإيرادات الكلية',
                              Icons.attach_money_outlined),
                        ],
                      ),

                      const SizedBox(height: 30),
                      _buildProgressSection(context),
                    ],
                  );
                }
              },
            ),
            const SizedBox(height: 30),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                physics: const NeverScrollableScrollPhysics(),
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
                  _buildGridOption('فيديوهات مساعده', Icons.play_circle_outline,
                      () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ExamScreen()),
                    );
                  }),
                  _buildGridOption('هدف اخر', Icons.flag_outlined, () {
                    // Define action here
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressSection(BuildContext context) {
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
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RewardsScreen()),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'اكمل الهدف واحصل على ',
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                  const TextSpan(
                    text: '2000 جنيه',
                    style: TextStyle(
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
            const SizedBox(height: 20),
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: LinearProgressIndicator(
                    value: 0.55,
                    backgroundColor: Colors.grey[300],
                    color: redcolor,
                    minHeight: 20,
                  ),
                ),
                const Positioned.fill(
                  child: Center(
                    child: Text(
                      '55%',
                      style: TextStyle(
                        color: Colors.white,
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

  Widget _buildInfoCard(String amount, String description, IconData icon) {
    return Expanded(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Icon(icon, color: Colors.white, size: 30)),
            const SizedBox(height: 8),
            Center(
              child: Text(
                amount,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Center(
              child: Text(
                description,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
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
