import 'package:flutter/material.dart';
import 'package:flutter_application_1/affiliate/views/withdrawal_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/views/screens/Exams/exam_mcq_screen.dart';
// Import your other screens here

class AffiliateHomeScreen extends StatelessWidget {
  const AffiliateHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(
                          'assets/avatar.png'), // Replace with the actual image asset
                      radius: 20,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'اهلا بك احمد',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: redcolor,
                      ),
                    ),
                    // Optional spacing between text and avatar
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon:
                          Icon(Icons.person_outline, size: 30, color: redcolor),
                      onPressed: () {
                        // Handle avatar action
                      },
                    ),
                    Stack(
                      children: [
                        IconButton(
                          icon: Icon(Icons.notifications_none,
                              size: 30, color: redcolor),
                          onPressed: () {},
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
            // Earnings and registrations cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoCard('1000 ج.م', 'الرصيد المتاح',
                    Icons.account_balance_wallet_outlined),
                SizedBox(
                  width: 10,
                ),
                _buildInfoCard(
                    '10', 'عدد التسجيلات', Icons.person_add_alt_1_outlined),
                SizedBox(
                  width: 10,
                ),
                _buildInfoCard('1000 ج.م', 'الإيرادات الكلية',
                    Icons.attach_money_outlined),
              ],
            ),
            const SizedBox(height: 30),
            // Custom Progress Bar
            Container(
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
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'اكمل الهدف واحصل على ',
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[700]),
                        ),
                        TextSpan(
                          text: '2000 جنيه',
                          style: TextStyle(
                            fontSize: 16,
                            color: redcolor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: ' هديه',
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[700]),
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
                      Positioned.fill(
                        child: Center(
                          child: Text(
                            '55%',
                            style: const TextStyle(
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
            const SizedBox(height: 5),
            // Bottom grid options
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1,
              children: [
                _buildGridOption('التاريخ', Icons.history_outlined, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ExamScreen()),
                  );
                }),
                _buildGridOption('السحب', Icons.money_off_outlined, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WithdrawalScreen()),
                  );
                }),
                _buildGridOption('فيديوهات مساعده', Icons.play_circle_outline,
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ExamScreen()),
                  );
                }),
                _buildGridOption('العمولات', Icons.bar_chart_outlined, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ExamScreen()),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build the info cards
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
              style: const TextStyle(
                color: redcolor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
