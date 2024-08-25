import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:webview_flutter_x5/webview_flutter.dart';

class IdeasContent extends StatefulWidget {
  final List<dynamic> resources; // Add this line

  const IdeasContent(
      {super.key, required this.resources}); // Update constructor

  @override
  State<IdeasContent> createState() => _IdeasContentState();
}

class _IdeasContentState extends State<IdeasContent> {
  int rating = 0;
  int viewedVideoIndex = 0;
  bool isLandscape = false;

  void updateRating(int newRating) {
    setState(() {
      rating = newRating;
    });
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
    final videoResources =
        widget.resources.where((res) => res['type'] == 'video').toList();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1 / 1,
              child: WebView(
                initialUrl: videoResources[viewedVideoIndex]['link'],
                javascriptMode: JavascriptMode.unrestricted,
                initialMediaPlaybackPolicy:
                    AutoMediaPlaybackPolicy.always_allow,
              ),
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                SizedBox(width: 20),
                Text('الوحده الاولى الدرس الثانى'),
                SizedBox(width: 10),
              ],
            ),
            const SizedBox(height: 15),
            const Row(
              children: [
                SizedBox(width: 20),
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/logo.png'),
                ),
                SizedBox(width: 10),
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
                const SizedBox(width: 5),
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
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: videoResources.length - 1,
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
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('مستر احمد الباشا'),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text('الوحده الاولى الدرس الثالث'),
                          SizedBox(height: 10),
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
            ),
          ],
        ),
      ),
    );
  }
}
