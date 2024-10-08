// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'dart:developer';
import 'package:flutter_application_1/views/screens/curriculum/video_screen.dart';
import 'package:flutter_application_1/views/screens/payment/subscription_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/Auth/login_provider.dart';
import 'package:flutter_application_1/controller/theme/theme_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
class SectionsScreen extends StatefulWidget {
  const SectionsScreen({
    super.key,
    required this.chapters,
    required this.subjectId,
    this.coverPhotoUrl,
  });
  final List<dynamic> chapters;
  final String subjectId;
  final String? coverPhotoUrl;

  @override
  // ignore: library_private_types_in_public_api
  _SectionsScreenState createState() => _SectionsScreenState();
}
class _SectionsScreenState extends State<SectionsScreen> {
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
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: redcolor),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                    Text(
                      'الوحدات',
                      style: TextStyle(
                        color: redcolor,
                        fontSize: 25.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(
                      flex: 3,
                    )
                  ],
                ),
                SizedBox(height: 20.h),
                Image.network(
                  widget.coverPhotoUrl ?? 'assets/images/beaker.png',
                  height: 100,
                  width: 100,
                ),
                Expanded(
                  child: widget.chapters.isEmpty
                      ? Center(
                          child: Text(
                            'No chapters available',
                            style: TextStyle(color: redcolor, fontSize: 18.sp),
                          ),
                        )
                      : ListView.builder(
                          itemCount: widget.chapters.length,
                          itemBuilder: (context, index) {
                            final chapter = widget.chapters[index];
                            final lessons = chapter['lessons'];
                            return ChapterTile(
                              chapter: chapter,
                              lessons: lessons,
                              subjectId:
                                  widget.subjectId,
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
  const ChapterTile({
    super.key,
    required this.chapter,
    required this.lessons,
    required this.subjectId,
  });

  final dynamic chapter;
  final List<dynamic> lessons;
  final String subjectId;

  @override
  // ignore: library_private_types_in_public_api
  _ChapterTileState createState() => _ChapterTileState();
}

class _ChapterTileState extends State<ChapterTile> {
  void showUnpaidDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          content: const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'يجب عليك الاشتراك لتكملة تعلم هذا الدرس',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                ' لاحقا',
                style: TextStyle(color: Colors.grey[700]),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SubscriptionScreen(
                      subjectId: widget.subjectId,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: redcolor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'اشترك الان',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  void showClosedMaterialDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          content: const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'عفوا هذا الدرس غير متوفر حاليا.سوف يتوفر قريبا',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: redcolor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'موافق',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> postLessonData(String lessonId, String subjectId) async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;

    final url =
        Uri.parse('https://bdev.elmanhag.shop/student/chapter/lesson/view');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    Map<String, String> body = {
      'subject_id': subjectId,
      'lesson_id': lessonId,
    };

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(body),
      );
      log(response.body);
      log(response.statusCode.toString());

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        log('Response data: $responseData');
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                LessonsVideos(lessonData: responseData['lesson']),
          ),
        );
      } else if (response.statusCode == 400) {
        var responseData = json.decode(response.body);

        if (responseData['faield'] == 'This Lesson Unpaid') {
          showUnpaidDialog();
        } else if (responseData['faield'] ==
            'This Material for This Lesson is Closed') {
          showClosedMaterialDialog();
        } else {
          log('Unexpected response: $responseData');
        }
      } else if (response.statusCode == 500) {
        var responseData = json.decode(response.body);

        if (responseData['lesson_not_solved'] ==
            'The previous lesson was not solved.') {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                content: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'يجب عليك حل الدرس السابق قبل المتابعة.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: redcolor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'موافق',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              );
            },
          );
        }
      } else {
        log('Request failed with status: ${response.statusCode}.');
        log(response.body);
      }
    } catch (e) {
      log('Error occurred: $e');
    }
  }

  bool _isExpanded = false;

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
            widget.chapter['name'],
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
                lesson['name'],
                style: TextStyle(fontSize: 16.sp, color: redcolor),
              ),
              onTap: () {
                postLessonData(lesson['id'].toString(), widget.subjectId);
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
