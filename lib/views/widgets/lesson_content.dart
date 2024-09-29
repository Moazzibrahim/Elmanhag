import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../screens/curriculum/mycurriculum/report_video_screen.dart';

class IdeasContent extends StatefulWidget {
  final List<dynamic> resources;
  final int lessonId; // Accept lessonId here

  const IdeasContent(
      {super.key, required this.resources, required this.lessonId});

  @override
  State<IdeasContent> createState() => _IdeasContentState();
}

class _IdeasContentState extends State<IdeasContent> {
  int rating = 0;
  int viewedVideoIndex = 0;
  bool isLandscape = false;
  List videoResources = [];
  final controller = WebViewController();

  void updateRating(int newRating) {
    setState(() {
      rating = newRating;
    });
  }

  @override
  void initState() {
    videoResources =
        widget.resources.where((res) => res['type'] == 'video').toList();
    if (videoResources.isNotEmpty) {
      controller
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadRequest(Uri.parse(videoResources[viewedVideoIndex]['file_link']));
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showNoVideosDialog();
      });
    }
    super.initState();
  }

  void _showNoVideosDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('No Videos'),
          content: const Text('There are no videos for this lesson.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void toggleRotation() {
    if (isLandscape) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    }
    setState(() {
      isLandscape = !isLandscape;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (videoResources.isNotEmpty)
              Container(
                height: 200,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: WebViewWidget(
                    controller: controller,
                  ),
                ),
              )
            else
              Container(
                height: 200, // Adjust as needed
                alignment: Alignment.center,
                child: const Text(
                  'No video available',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: redcolor,
                  ),
                ),
              ),
            const SizedBox(height: 15),
            Row(
              children: [
                const SizedBox(width: 20),
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/amin2.png'),
                ),
                const SizedBox(width: 10),
                const Text(
                  'المنهج',
                  style: TextStyle(fontSize: 16),
                ),
                const Spacer(), // This will push the report button to the right
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) =>
                              ReportVideoScreen(lessonId: widget.lessonId)),
                    );
                  },
                  icon: const Icon(Icons.flag),
                  label: const Text('Report'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: redcolor, // Text color
                  ),
                ),
                const SizedBox(
                    width:
                        20), // Add some padding between the button and the edge of the screen
              ],
            ),
            const SizedBox(height: 15),
            if (videoResources.isNotEmpty)
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      isLandscape
                          ? Icons.screen_lock_rotation
                          : Icons.screen_rotation,
                      color: redcolor,
                    ),
                    onPressed: toggleRotation,
                  ),
                  const Text(
                    'اقلب الشاشة لمشاهدة الفيديو كامل',
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            const SizedBox(height: 15),
            if (videoResources.isNotEmpty)
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: videoResources.length - 1,
                itemBuilder: (context, i) {
                  int index = i + 1;
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            viewedVideoIndex = index;
                          });
                        },
                        child: Container(
                          height: 100,
                          width: 150,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color.fromARGB(255, 55, 54, 54),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image.network(
                                videoResources[index]['thumbnail'],
                                fit: BoxFit.cover,
                                height: 80,
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: const Color.fromARGB(
                                          255, 195, 194, 194),
                                    ),
                                    child: Text(
                                      videoResources[index]['duration'],
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              videoResources[index]['title'],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              videoResources[index]['description'],
                              style: const TextStyle(color: greycolor),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
