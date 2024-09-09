import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentProgressScreen extends StatelessWidget {
  const StudentProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تقدم الطالب', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: redcolor,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: redcolor),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Progress Bar
            Container(
              width: double.infinity,
              height: 20.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Colors.grey[300],
              ),
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.55, // 55%
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: redcolor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),

            // Grid of Subjects
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.1,
                crossAxisSpacing: 10.w,
                mainAxisSpacing: 10.h,
                children: [
                  subjectTile('عربي', Icons.language, redcolor),
                  subjectTile('الرياضيات', Icons.calculate, redcolor),
                  subjectTile('دراسات', Icons.public, redcolor),
                  subjectTile('علوم', Icons.science, redcolor),
                  subjectTile('اللغه الفرنسيه', Icons.flag, redcolor),
                  subjectTile('اللغه الانجليزيه', Icons.translate, redcolor),
                  subjectTile('التكنولوجيا', Icons.computer, redcolor),
                  subjectTile('المهارات', Icons.psychology, redcolor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to build each subject tile
  Widget subjectTile(String title, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 40.r),
          SizedBox(height: 10.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: redcolor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}