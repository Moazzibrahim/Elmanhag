import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/Auth/login_provider.dart';
import 'package:flutter_application_1/controller/theme/theme_provider.dart';
import 'package:flutter_application_1/models/lessons_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import '../video_screen.dart'; // For encoding the JSON data

class ChaptersScreen extends StatelessWidget {
  final List<Chapter> chapters;

  const ChaptersScreen({super.key, required this.chapters});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: isDarkMode
                ? Image.asset(
                    'assets/images/Ellipse 198.png',
                    fit: BoxFit.cover,
                  )
                : Container(
                    color: Colors.white,
                  ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 10.0.h),
            child: Column(
              children: [
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: redcolor),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    const Spacer(flex: 2),
                    Text(
                      'الوحدات',
                      style: TextStyle(
                        color: redcolor,
                        fontSize: 25.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(flex: 3),
                  ],
                ),
                SizedBox(height: 20.h),
                Image.asset(
                  'assets/images/beaker.png',
                  width: 150.w,
                  height: 100.h,
                ),
                SizedBox(height: 20.h),
                Expanded(
                  child: chapters.isEmpty
                      ? Center(
                          child: Text(
                            'No chapters available',
                            style: TextStyle(color: redcolor, fontSize: 18.sp),
                          ),
                        )
                      : ListView.builder(
                          itemCount: chapters.length,
                          itemBuilder: (context, index) {
                            final chapter = chapters[index];
                            return ChapterTile(
                              chapter: chapter,
                              lessons: chapter.lessons,
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChapterTile extends StatefulWidget {
  const ChapterTile({super.key, required this.chapter, required this.lessons});
  final Chapter chapter;
  final List<Lesson> lessons;

  @override
  // ignore: library_private_types_in_public_api
  _ChapterTileState createState() => _ChapterTileState();
}

class _ChapterTileState extends State<ChapterTile> {
  bool _isExpanded = false;
  Future<void> _sendLesson(Lesson lesson) async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final String? token = tokenProvider.token;
    final url = 'https://bdev.elmanhag.shop/affilate/chapter/lesson/view';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'lesson_id': lesson.id, // Assuming lesson has an 'id' field
        }),
      );

      if (response.statusCode == 200) {
        log(response.body);
        final data = jsonDecode(response.body);

        if (data['success'] != null) {
          final lessonData = data['lesson'];
          print('Lesson sent successfully');

          // Navigate to LessonsVideos screen with lessonData
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LessonsVideos(
                lessonData: lessonData,
              ),
            ),
          );
        }
      } else {
        // Handle error
        print('Failed to send lesson: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network error
      print('Error sending lesson: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 5,
      child: Theme(
        data: ThemeData(
          dividerColor: Colors.transparent,
          hintColor: Colors.transparent,
        ),
        child: ExpansionTile(
          title: Text(
            widget.chapter.name,
            style: TextStyle(
              fontSize: 18.sp,
              color: redcolor,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Icon(
            _isExpanded
                ? Icons.keyboard_arrow_down_outlined
                : Icons.keyboard_arrow_left_outlined,
            color: redcolor,
          ),
          onExpansionChanged: (bool expanded) {
            setState(() {
              _isExpanded = expanded;
            });
          },
          children: widget.lessons.map<Widget>((lesson) {
            return ListTile(
              leading: Icon(
                Icons.circle,
                size: 10.w,
                color: redcolor,
              ),
              title: Text(
                lesson.name,
                style: TextStyle(fontSize: 16.sp, color: redcolor),
              ),
              onTap: () {
                _sendLesson(
                    lesson); // Call the function when a lesson is tapped
              },
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
              visualDensity: VisualDensity.compact,
            );
          }).toList(),
        ),
      ),
    );
  }
}
