import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for clipboard functionality
import 'package:flutter_application_1/affiliate/views/affiliate_profile_screen.dart';
import 'package:flutter_application_1/affiliate/views/rewards_screen.dart';
import 'package:flutter_application_1/affiliate/views/transactions.dart';
import 'package:flutter_application_1/affiliate/views/withdrawal_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/affiliate/models/affiliate_model.dart';
import 'package:flutter_application_1/views/screens/curriculum/allcurriculum/filter_curriclums_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  Future<BonusResponse> _fetchBonusData(BuildContext context) {
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
                                              Clipboard.setData(ClipboardData(
                                                      text: affiliateCode))
                                                  .then((_) {
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
                              height: 135.h,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const WithdrawalScreen()),
                                  );
                                },
                                child: _buildInfoCard(
                                  '${userProfile.user.income.wallet} ',
                                  'الرصيد المتاح',
                                  Icons.account_balance_wallet_outlined,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 135.h,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const TransactionsScreen()),
                                  );
                                },
                                child: _buildInfoCard(
                                  '${userProfile.user.studentSignups}',
                                  'عدد التسجيلات',
                                  Icons.person_add_alt_1_outlined,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 135.h,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const TransactionsScreen()),
                                  );
                                },
                                child: _buildInfoCard(
                                  '${userProfile.user.income.income}',
                                  'الإيرادات الكلية',
                                  Icons.attach_money_outlined,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        FutureBuilder<BonusResponse>(
                          future: _fetchBonusData(context), // Fetch bonus data
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (snapshot.hasData) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RewardsScreen()),
                                  );
                                },
                                child: _buildProgressSection(snapshot.data!),
                              ); // Use snapshot.data directly
                            } else {
                              return const SizedBox.shrink();
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
                      _buildGridOption('المناهج', Icons.book, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const FilterCurriculumsScreen()),
                        );
                      }),
                    ],
                  ),
                  const SizedBox(height: 20,)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressSection(BonusResponse bonusData) {
    double progress = bonusData.bundlePaid / bonusData.affiliateBonus.target;

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
          const Align(
            alignment: Alignment.topRight,
            child: Text(
              'Bonus Two',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: redcolor,
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Arabic Text Section
          Text.rich(
            TextSpan(
              text: 'اكمل الهدف (',
              style: const TextStyle(fontSize: 14, color: Colors.black),
              children: [
                TextSpan(
                  text: '${bonusData.affiliateBonus.target}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text: ') واحصل على ',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
                const TextSpan(
                  text: 'iphone',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: redcolor,
                  ),
                ),
                const TextSpan(
                  text: ' جنيه هديه',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCircularIndicator(
                bonusData.bundlePaid.toString(),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: LinearProgressIndicator(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    value: progress,
                    backgroundColor: Colors.grey[300],
                    color: redcolor,
                    minHeight: 20,
                  ),
                ),
              ),
              _buildCircularIndicator(
                bonusData.affiliateBonus.target.toString(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCircularIndicator(String number) {
    return Container(
      width: 50, // Circle width
      height: 50, // Circle height
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[300], // Background color for the circle
      ),
      alignment: Alignment.center,
      child: Text(
        number,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: redcolor, // Text color
        ),
      ),
    );
  }

  Widget _buildInfoCard(String amount, String description, IconData icon) {
    return Container(
      padding:  EdgeInsets.symmetric(horizontal: 8.w),
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

  Widget _buildGridOption(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: redcolor),
              const SizedBox(height: 8),
              Text(title, style: const TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
