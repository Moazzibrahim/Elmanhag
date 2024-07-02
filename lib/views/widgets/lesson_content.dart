import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter_x5/webview_flutter.dart'; // Add this import for SystemChrome

class IdeasContent extends StatefulWidget {
  const IdeasContent({
    super.key,
  });
  //final Lesson lesson;

  @override
  State<IdeasContent> createState() => _IdeasContentState();
}

class _IdeasContentState extends State<IdeasContent> {
  late VideoPlayerController controller;
  int rating = 0;
  int viewedVideoIndex = 0;
  // @override
  // void initState() {
  //   super.initState();
  //   WebView.platform;
  //   SystemChrome.setPreferredOrientations([
  //     DeviceOrientation.landscapeRight,
  //     DeviceOrientation.landscapeLeft,
  //   ]);
  // }

  // @override
  // void dispose() {
  //   SystemChrome.setPreferredOrientations([
  //     DeviceOrientation.portraitUp,
  //     DeviceOrientation.portraitDown,
  //   ]);
  //   controller.dispose();
  //   super.dispose();
  // }

  void updateRating(int newRating) {
    setState(() {
      rating = newRating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const AspectRatio(
              aspectRatio: 1 / 1,
              child: WebView(
                initialUrl:
                    "https://ucloud.mfscripts.com/video/embed/4g/640x320/Iron_Sky_Trailer.mp4", //widget.lesson.videos[viewedVideoIndex].videoLink,
                javascriptMode: JavascriptMode.unrestricted,
                initialMediaPlaybackPolicy:
                    AutoMediaPlaybackPolicy.always_allow,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(' الوحده الاولى الدرس الثانى '),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/logo.png'),
                ),
                SizedBox(
                  width: 10,
                ),
                Text('مستر احمد الباشا'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                for (int i = 0; i < 5; i++)
                  GestureDetector(
                    onTap: () {
                      updateRating(i);
                    },
                    child: Icon(
                      i <= rating ? Icons.star : Icons.star_border_outlined,
                      color: Colors.redAccent[700],
                    ),
                  ),
                const SizedBox(
                  width: 5,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 194, 193, 193)),
                  child: const Row(
                    children: [
                      Text('Report'),
                      Icon(Icons.flag_outlined),
                    ],
                  ),
                ),
              ],
            ),
            //widget.lesson.videos.isNotEmpty
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 2, //widget.lesson.videos.length -1,
              itemBuilder: (context, i) {
                int index = i + 1;
                return Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          viewedVideoIndex = index;
                        });
                      },
                      child: Container(
                        height: 150,
                        width: 200,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color.fromARGB(255, 55, 54, 54),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
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
                                  child: const Text('2:30'),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(//widget.lesson.videos[index].videoName ??
                                  'مستر احمد الباشا'),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('الوحده الاولى الدرس الثالث'),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "هذا فديو رائع لهذه الوحده يوجد بها",
                            style: TextStyle(color: greycolor),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
