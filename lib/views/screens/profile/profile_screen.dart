import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/Auth/logout_provider.dart';
import 'package:flutter_application_1/controller/profile/profile_provider.dart';
import 'package:flutter_application_1/views/screens/profile/edit_profile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CustomProfileScreen extends StatefulWidget {
  const CustomProfileScreen({super.key});

  @override
  State<CustomProfileScreen> createState() => _CustomProfileScreenState();
}

class _CustomProfileScreenState extends State<CustomProfileScreen> {
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isInitialized) {
        Provider.of<UserProfileProvider>(context, listen: false)
            .fetchUserProfile(context);
        _isInitialized = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProfileProvider = Provider.of<UserProfileProvider>(context);
    final isLoading = userProfileProvider.isLoading;

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
          title: isLoading
              ? const CircularProgressIndicator()
              : Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(userProfileProvider.image ??
                          'https://example.com/default.png'),
                      radius: 20,
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome ${userProfileProvider.name ?? 'User'}',
                            style: TextStyle(
                                color: redcolor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${userProfileProvider.category}', // Modify according to your actual requirement
                            style:
                                TextStyle(color: Colors.grey, fontSize: 14.sp),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit, color: redcolor),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => const EditProfileScreen()));
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.logout, color: redcolor),
                      onPressed: () async {
                        await Provider.of<LogoutModel>(context, listen: false)
                            .logout(context);
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
                tabs: const [
                  Tab(
                    text: 'Student',
                  ),
                  Tab(
                    text: 'Parent',
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
    final userProfileProvider = Provider.of<UserProfileProvider>(context);
    final isLoading = userProfileProvider.isLoading;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                InfoCard(
                  text: 'Name: ${userProfileProvider.name ?? 'N/A'}',
                  icon: Icons.person,
                ),
                InfoCard(
                  text: 'Email: ${userProfileProvider.email ?? 'N/A'}',
                  icon: Icons.person,
                ),
                InfoCard(
                  text:
                      'Grade: ${userProfileProvider.category ?? 'N/A'}', // Modify as needed
                  icon: Icons.grade,
                ),
                InfoCard(
                  text:
                      'education: ${userProfileProvider.education ?? 'N/A'}', // Modify according to actual data
                  icon: Icons.language,
                ),
                InfoCard(
                  text: 'Country: ${userProfileProvider.countryName ?? 'N/A'}',
                  icon: Icons.flag,
                ),
                InfoCard(
                  text: 'City: ${userProfileProvider.cityName ?? 'N/A'}',
                  icon: Icons.location_city,
                ),
                InfoCard(
                  text: 'Phone: ${userProfileProvider.phone ?? 'N/A'}',
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
    final userProfileProvider = Provider.of<UserProfileProvider>(context);
    final isLoading = userProfileProvider.isLoading;

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
                children: [
                  InfoCard(
                    text:
                        'Parent Name: ${userProfileProvider.parentName ?? 'N/A'}',
                    icon: Icons.person,
                  ),
                  InfoCard(
                    text:
                        'Parent Phone: ${userProfileProvider.parentPhone ?? 'N/A'}',
                    icon: Icons.phone,
                  ),
                  InfoCard(
                    text:
                        'Parent Email: ${userProfileProvider.parentEmail ?? 'N/A'}',
                    icon: Icons.email,
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
