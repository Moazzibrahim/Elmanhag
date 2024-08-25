import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:webview_flutter_x5/webview_flutter.dart';

class IdeasContent extends StatefulWidget {
  final List<dynamic> resources;

  const IdeasContent({super.key, required this.resources});

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
              aspectRatio: isLandscape ? 16 / 9 : 1 / 1,
              child: Container(
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: WebView(
                    initialUrl: videoResources[viewedVideoIndex]['link'],
                    javascriptMode: JavascriptMode.unrestricted,
                    initialMediaPlaybackPolicy:
                        AutoMediaPlaybackPolicy.always_allow,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                SizedBox(width: 20),
                Text(
                  'الوحده الاولى الدرس الثانى',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
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
                Text('المنهج', style: TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                for (int i = 0; i < 5; i++)
                  GestureDetector(
                    onTap: () {
                      updateRating(i + 1);
                    },
                    child: Icon(
                      i < rating ? Icons.star : Icons.star_border_outlined,
                      color: Colors.redAccent[700],
                      size: 28,
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
            const SizedBox(height: 15),
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
                          const Text(
                            'مستر احمد الباشا',
                            style: TextStyle(fontSize: 14),
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
