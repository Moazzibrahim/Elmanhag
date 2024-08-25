import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/views/screens/bocklet/bocklet_screen.dart';
import 'package:flutter_application_1/views/screens/homework/hw_mcq_screen.dart';
import 'package:flutter_application_1/views/widgets/lesson_content.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LessonsVideos extends StatefulWidget {
  final dynamic lessonData;

  const LessonsVideos({super.key, required this.lessonData});

  @override
  State<LessonsVideos> createState() => _LessonsVideosState();
}

class _LessonsVideosState extends State<LessonsVideos> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.only(left: 10.w), // Adjust title padding
            child: Text(
              widget.lessonData['name'],
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          leading: Container(
            margin: EdgeInsets.all(6.w),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(250, 226, 229, 1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: redcolor,
              ),
            ),
          ),
          elevation: 4, // Add shadow to AppBar
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: EdgeInsets.all(8.0.w),
          child: Column(
            children: [
              Container(
                height: 50.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
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
                  unselectedLabelColor: redcolor,
                  tabs: const [
                    _CustomTab(text: 'فيديوهات'),
                    _CustomTab(text: 'واجبات'),
                    _CustomTab(text: 'مذكرات'),
                  ],
                ),
              ),
              SizedBox(height: 10.h), // Add spacing between TabBar and content
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                  child: TabBarView(
                    children: [
                      IdeasContent(resources: widget.lessonData['resources']),
                      const HomeworkMcqScreen(),
                      BockletScreen(resources: widget.lessonData['resources']),
                    ],
                  ),
                ),
              ),
            ],
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
