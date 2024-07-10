import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/views/screens/profile/edit_profile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomProfileScreen extends StatelessWidget {
  const CustomProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: DefaultTabController(
        animationDuration: const Duration(seconds: 1),
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: redcolor),
              onPressed: () {
                Navigator.of(context).pop();

                // Handle back button action
              },
            ),
            title: Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage(
                      'assets/images/tefl.png'), // Replace with actual image asset or network image
                  radius: 20,
                ),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'اهلا بك محمد',
                      style: TextStyle(
                          color: redcolor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'الصف الرابع لغات',
                      style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.edit, color: redcolor),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => const EditProfileScreen()));
                  },
                ),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60.0),
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 0.5), // Add desired padding here
                child: TabBar(
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: redcolor,
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: Colors.white,
                  unselectedLabelColor: redcolor,
                  labelStyle: TextStyle(
                      fontSize: 18.sp), // Increase font size for selected tab
                  unselectedLabelStyle: TextStyle(
                      fontSize: 14.sp), // Increase font size for unselected tab
                  tabs: const [
                    Tab(
                      text: 'الطالب',
                    ),
                    Tab(text: 'ولي الامر'),
                  ],
                ),
              ),
            ),
          ),
          body: const TabBarView(
            children: [
              StudentTabContent(),
              ParentTabContent(),
            ],
          ),
        ),
      ),
    );
  }
}

class StudentTabContent extends StatelessWidget {
  const StudentTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          InfoCard(
            text: 'احمد ابراهيم',
            icon: Icons.person,
          ),
          InfoCard(
            text: 'الصف الرابع',
            icon: Icons.grade,
          ),
          InfoCard(
            text: 'لغات',
            icon: Icons.language,
          ),
          InfoCard(
            text: 'مصر',
            icon: Icons.flag,
          ),
          InfoCard(
            text: 'الاسكندريه',
            icon: Icons.location_city,
          ),
          InfoCard(
            text: '01558744425',
            icon: Icons.phone,
          ),
        ],
      ),
    );
  }
}

class ParentTabContent extends StatelessWidget {
  const ParentTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(12.0),
      child: Center(
        child: Column(
          children: [
            InfoCard(text: 'ابراهيم محمد', icon: Icons.person),
            InfoCard(text: '0121111125', icon: Icons.phone)
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String text;
  final IconData icon;

  const InfoCard({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      margin: EdgeInsets.symmetric(vertical: 8.h),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: redcolor,
              size: 24.sp,
            ),
            SizedBox(width: 10.w),
            Text(
              text,
              style: TextStyle(fontSize: 16.sp, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
