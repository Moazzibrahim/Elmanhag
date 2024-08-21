// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/Auth/logout_provider.dart';
import 'package:flutter_application_1/controller/profile/profile_provider.dart';
import 'package:flutter_application_1/controller/theme/theme_provider.dart';
import 'package:flutter_application_1/localization/app_localizations.dart';
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

  Future<void> _navigateAndRefresh() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => const EditProfileScreen()),
    );

    if (result == true) {
      Provider.of<UserProfileProvider>(context, listen: false)
          .fetchUserProfile(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProfileProvider = Provider.of<UserProfileProvider>(context);
    final isLoading = userProfileProvider.isLoading;
    final localizations = AppLocalizations.of(context);
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return DefaultTabController(
      animationDuration: const Duration(seconds: 1),
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: isDarkMode ? Colors.black : Colors.white,
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
                            '${localizations.translate('welcome')} ${userProfileProvider.name ?? localizations.translate('Name')}',
                            style: TextStyle(
                                color: redcolor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${userProfileProvider.category}',
                            style:
                                TextStyle(color: Colors.grey, fontSize: 14.sp),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit, color: redcolor),
                      onPressed: _navigateAndRefresh,
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
                unselectedLabelColor: isDarkMode
                    ? Colors.white
                    : redcolor, // Adjust for dark mode
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
    final userProfileProvider = Provider.of<UserProfileProvider>(context);
    final isLoading = userProfileProvider.isLoading;
    final localizations = AppLocalizations.of(context);
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                InfoCard(
                  text:
                      '${localizations.translate('Name')}: ${userProfileProvider.name ?? 'N/A'}',
                  icon: Icons.person,
                  isDarkMode: isDarkMode,
                ),
                InfoCard(
                  text:
                      '${localizations.translate('phone')}: ${userProfileProvider.phone ?? 'N/A'}',
                  icon: Icons.phone,
                  isDarkMode: isDarkMode,
                ),
                InfoCard(
                  // ignore: unnecessary_string_interpolations
                  text: '${userProfileProvider.email ?? 'N/A'}',
                  icon: Icons.email,
                  isDarkMode: isDarkMode,
                ),
                InfoCard(
                  text:
                      '${localizations.translate('grade')}: ${userProfileProvider.category ?? 'N/A'}',
                  icon: Icons.grade,
                  isDarkMode: isDarkMode,
                ),
                InfoCard(
                  text:
                      '${localizations.translate('education')}: ${userProfileProvider.education ?? 'N/A'}',
                  icon: Icons.language,
                  isDarkMode: isDarkMode,
                ),
                InfoCard(
                  text:
                      '${localizations.translate('country')}: ${userProfileProvider.countryName ?? 'N/A'}',
                  icon: Icons.flag,
                  isDarkMode: isDarkMode,
                ),
                InfoCard(
                  text:
                      '${localizations.translate('city')}: ${userProfileProvider.cityName ?? 'N/A'}',
                  icon: Icons.location_city,
                  isDarkMode: isDarkMode,
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
    final localizations = AppLocalizations.of(context);
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
                children: [
                  InfoCard(
                    text:
                        '${localizations.translate('parent_name')}: ${userProfileProvider.parentName ?? 'N/A'}',
                    icon: Icons.person,
                    isDarkMode: isDarkMode,
                  ),
                  InfoCard(
                    text:
                        '${localizations.translate('parent_phone')}: ${userProfileProvider.parentPhone ?? 'N/A'}',
                    icon: Icons.phone,
                    isDarkMode: isDarkMode,
                  ),
                  InfoCard(
                    text:
                        '${localizations.translate('parent_email')}: ${userProfileProvider.parentEmail ?? 'N/A'}',
                    icon: Icons.email,
                    isDarkMode: isDarkMode,
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
  final bool isDarkMode;

  const InfoCard({
    super.key,
    required this.text,
    required this.icon,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isDarkMode ? Colors.black : Colors.grey[200],
      margin: EdgeInsets.symmetric(vertical: 8.h),
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: redcolor, width: 2.0), // Add a red border
        borderRadius: BorderRadius.circular(8.0), // Rounded corners
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: isDarkMode ? Colors.grey : redcolor,
              size: 24.sp,
            ),
            SizedBox(width: 10.w),
            Text(
              text,
              style: TextStyle(
                fontSize: 16.sp,
                color: isDarkMode ? Colors.grey : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
