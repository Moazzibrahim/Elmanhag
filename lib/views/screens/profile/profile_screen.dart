import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/views/screens/login/login_screen.dart';
import 'package:flutter_application_1/views/screens/profile/edit_profile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/localization/app_localizations.dart';

class CustomProfileScreen extends StatelessWidget {
  const CustomProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return DefaultTabController(
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
            },
          ),
          title: Row(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage('assets/images/tefl.png'),
                radius: 20,
              ),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localizations.translate('welcome Yousef'),
                    style: TextStyle(
                        color: redcolor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    localizations.translate('class'),
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
              IconButton(
                icon: const Icon(Icons.logout, color: redcolor),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (ctx) => const LoginScreen()));
                },
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60.0),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 0.5),
              child: TabBar(
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: redcolor,
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.white,
                unselectedLabelColor: redcolor,
                labelStyle: TextStyle(fontSize: 18.sp),
                unselectedLabelStyle: TextStyle(fontSize: 14.sp),
                tabs: [
                  Tab(
                    text: localizations.translate('student'),
                  ),
                  Tab(
                    text: localizations.translate('parent'),
                  ),
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
    );
  }
}

class StudentTabContent extends StatelessWidget {
  const StudentTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          InfoCard(
            text: localizations.translate('student_name'),
            icon: Icons.person,
          ),
          InfoCard(
            text: localizations.translate('grade'),
            icon: Icons.grade,
          ),
          InfoCard(
            text: localizations.translate('language'),
            icon: Icons.language,
          ),
          InfoCard(
            text: localizations.translate('country'),
            icon: Icons.flag,
          ),
          InfoCard(
            text: localizations.translate('city'),
            icon: Icons.location_city,
          ),
          InfoCard(
            text: localizations.translate('phone'),
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
    final localizations = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(
        child: Column(
          children: [
            InfoCard(
              text: localizations.translate('parent_name'),
              icon: Icons.person,
            ),
            InfoCard(
              text: localizations.translate('parent_phone'),
              icon: Icons.phone,
            ),
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
