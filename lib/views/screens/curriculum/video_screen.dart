import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/screens/homework/home_work_screen.dart';
import 'package:flutter_application_1/views/widgets/lesson_content.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LessonsVideos extends StatefulWidget {
  const LessonsVideos({
    super.key,
  });
  //final Lesson lesson;

  @override
  State<LessonsVideos> createState() => _LessonsVideosState();
}

class _LessonsVideosState extends State<LessonsVideos> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("lesson 1"),
          leading: Container(
            margin: const EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: const Color.fromRGBO(250, 226, 229, 1),
                borderRadius: BorderRadius.circular(12)),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.redAccent[700],
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TabBar(
                  labelPadding:
                      EdgeInsets.zero, // No padding between label and indicator
                  indicator: BoxDecoration(
                    color: Colors.redAccent[700],
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.redAccent[700],
                  tabs: const [
                    _CustomTab(text: 'فيديوهات'),
                    _CustomTab(text: 'واجبات'),
                  ],
                ),
              ),
              const Expanded(
                child: TabBarView(children: [
                  IdeasContent(),
                  HomeWorkScreen()
                ]),
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
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
