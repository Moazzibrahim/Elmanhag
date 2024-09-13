// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/theme/theme_provider.dart';
import 'package:flutter_application_1/views/screens/bocklet/bocklet_screen.dart';
import 'package:flutter_application_1/views/widgets/hw_levels_widget.dart';
import 'package:flutter_application_1/views/widgets/lesson_content.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LessonsVideos extends StatefulWidget {
  final dynamic lessonData;

  const LessonsVideos({super.key, required this.lessonData});

  @override
  State<LessonsVideos> createState() => _LessonsVideosState();
}

class _LessonsVideosState extends State<LessonsVideos> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        body: Container(
          decoration: isDarkMode
              ? const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/Ellipse 198.png'),
                    fit: BoxFit.cover,
                  ),
                )
              : null,
          child: Padding(
            padding: EdgeInsets.all(8.0.w),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: redcolor,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    Center(
                      child: Text(
                        widget.lessonData['name'],
                        style: const TextStyle(fontSize: 20, color: redcolor),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  height: 50.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: const [
                      BoxShadow(
                        //color: Colors.grey.withOpacity(0.2),
                        color: Colors.transparent,
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TabBar(
                    labelPadding: EdgeInsets.symmetric(horizontal: 10.w),
                    indicator: BoxDecoration(
                      color: redcolor,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor:
                        isDarkMode ? Colors.white54 : redcolor,
                    tabs: const [
                      _CustomTab(text: 'فيديوهات'),
                      _CustomTab(text: 'واجبات'),
                      _CustomTab(text: 'مذكرات'),
                    ],
                  ),
                ),
                SizedBox(
                    height: 10.h), // Add spacing between TabBar and content
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                    child: TabBarView(
                      children: [
                        IdeasContent(resources: widget.lessonData['resources']),
                        HomeWorkWidget(homework: widget.lessonData['homework']),
                        BockletScreen(
                            resources: widget.lessonData['resources']),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CustomTab extends StatelessWidget {
  final String text;

  const _CustomTab({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
