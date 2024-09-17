// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/Auth/login_provider.dart';
import 'package:flutter_application_1/controller/Auth/logout_provider.dart';
import 'package:flutter_application_1/controller/parent/get_children_provider.dart';
import 'package:flutter_application_1/controller/theme/theme_provider.dart';
import 'package:flutter_application_1/localization/app_localizations.dart';
import 'package:flutter_application_1/views/parent%20screens/profile/edit_parent_profile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CustomProfileParentScreen extends StatefulWidget {
  final String? childname;
  final String? childcategory;
  final String? imagelnk;
  final String? phonechild;
  final String? emailchild;
  final String? childeducation;
  final String? childcountry;
  final String? childcity;
  final String? parentname;
  const CustomProfileParentScreen(
      {super.key,
      this.childname,
      this.childcategory,
      this.imagelnk,
      this.phonechild,
      this.emailchild,
      this.childeducation,
      this.childcountry,
      this.childcity,
      this.parentname});

  @override
  State<CustomProfileParentScreen> createState() =>
      _CustomProfileParentScreenState();
}

class _CustomProfileParentScreenState extends State<CustomProfileParentScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GetChildrenProvider>(context, listen: false)
          .fetchChildren(context);
    });
  }

  Future<void> _navigateAndRefresh() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
          builder: (ctx) => EditProfileParentScreen(
                childnme: widget.childname,
                parentname: widget.parentname,
                imglink: widget.imagelnk,
              )),
    );

    if (result == true) {
      Provider.of<GetChildrenProvider>(context, listen: false)
          .fetchChildren(context);
    }
  }

  @override
  Widget build(BuildContext context) {
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
          title: Consumer<GetChildrenProvider>(
            builder: (context, getChildrenProvider, child) {
              final isLoading = getChildrenProvider.isLoading;
              return isLoading
                  ? const CircularProgressIndicator()
                  : Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            widget.imagelnk!,
                          ),
                          radius: 20,
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${localizations.translate('welcome')} ${widget.parentname}',
                                style: TextStyle(
                                  color: redcolor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                widget.childcategory ?? '',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // IconButton(
                        //   icon: const Icon(Icons.edit, color: redcolor),
                        //   onPressed: _navigateAndRefresh,
                        // ),
                        IconButton(
                          icon: const Icon(Icons.logout, color: redcolor),
                          onPressed: () async {
                            await Provider.of<LogoutModel>(context,
                                    listen: false)
                                .logout(context);
                          },
                        ),
                      ],
                    );
            },
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
                  Tab(text: localizations.translate('student')),
                  Tab(text: localizations.translate('parent')),
                ],
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  StudentTabContent(
                    childcategory: widget.childcategory,
                    childcity: widget.childcity,
                    childcountry: widget.childcountry,
                    childeducation: widget.childeducation,
                    childname: widget.childname,
                    emailchild: widget.emailchild,
                    imagelnk: widget.imagelnk,
                    phonechild: widget.phonechild,
                  ),
                  const ParentTabContent(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StudentTabContent extends StatelessWidget {
  final String? childname;
  final String? childcategory;
  final String? imagelnk;
  final String? phonechild;
  final String? emailchild;
  final String? childeducation;
  final String? childcountry;
  final String? childcity;
  const StudentTabContent(
      {super.key,
      this.childname,
      this.childcategory,
      this.imagelnk,
      this.phonechild,
      this.emailchild,
      this.childeducation,
      this.childcountry,
      this.childcity});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Consumer<GetChildrenProvider>(
      builder: (context, getChildrenProvider, child) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              InfoCard(
                text:
                    '${localizations.translate('Name')}: ${childname ?? 'N/A'}',
                icon: Icons.person,
                isDarkMode: isDarkMode,
              ),
              InfoCard(
                text:
                    '${localizations.translate('phone')}: ${phonechild ?? 'N/A'}',
                icon: Icons.phone,
                isDarkMode: isDarkMode,
              ),
              InfoCard(
                text: emailchild ?? 'N/A',
                icon: Icons.email,
                isDarkMode: isDarkMode,
              ),
              InfoCard(
                text:
                    '${localizations.translate('grade')}: ${childcategory ?? 'N/A'}',
                icon: Icons.grade,
                isDarkMode: isDarkMode,
              ),
              InfoCard(
                text:
                    '${localizations.translate('education')}: ${emailchild ?? 'N/A'}',
                icon: Icons.language,
                isDarkMode: isDarkMode,
              ),
              InfoCard(
                text:
                    '${localizations.translate('country')}: ${childcountry ?? 'N/A'}',
                icon: Icons.flag,
                isDarkMode: isDarkMode,
              ),
              InfoCard(
                text:
                    '${localizations.translate('city')}: ${childcity ?? 'N/A'}',
                icon: Icons.location_city,
                isDarkMode: isDarkMode,
              ),
            ],
          ),
        );
      },
    );
  }
}

class ParentTabContent extends StatelessWidget {
  const ParentTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Consumer<LoginModel>(
      builder: (context, loginprovider, child) {
        // Get children list

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              InfoCard(
                text:
                    '${localizations.translate('parent_name')}: ${loginprovider.name ?? 'N/A'}',
                icon: Icons.person,
                isDarkMode: isDarkMode,
              ),
              InfoCard(
                text:
                    '${localizations.translate('parent_phone')}: ${loginprovider.phone ?? 'N/A'}',
                icon: Icons.phone,
                isDarkMode: isDarkMode,
              ),
              InfoCard(
                text:
                    '${localizations.translate('parent_email')}: ${loginprovider.email ?? 'N/A'}',
                icon: Icons.email,
                isDarkMode: isDarkMode,
              ),
            ],
          ),
        );
      },
    );
  }
}

class InfoCard extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool isDarkMode;

  const InfoCard({
    required this.text,
    required this.icon,
    required this.isDarkMode,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isDarkMode ? Colors.black : Colors.white,
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      child: ListTile(
        leading: Icon(icon, color: redcolor),
        title: Text(
          text,
          style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
