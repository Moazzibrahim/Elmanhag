import 'package:flutter/material.dart';
import 'package:flutter_application_1/affiliate/views/video_affiliate.dart';
import '../controller/videos_affiliate_provider.dart';
import '../models/videos_affiliate_model.dart';
import '../../constants/colors.dart';

class HelpVideosScreen extends StatelessWidget {
  const HelpVideosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: redcolor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'فيديوهات مساعده',
          style: TextStyle(
            color: redcolor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<AffiliateGroupVideo>>(
          future: fetchAffiliateGroupVideos(context),
          builder: (BuildContext context,
              AsyncSnapshot<List<AffiliateGroupVideo>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No videos available'));
            } else {
              List<AffiliateGroupVideo> affiliateGroupVideos = snapshot.data!;
              return ListView(
                children: affiliateGroupVideos.map((group) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12.0),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ExpansionTile(
                      tilePadding: const EdgeInsets.all(16),
                      title: Text(
                        group.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      leading: const Icon(
                        Icons.video_library,
                        color: redcolor,
                      ),
                      children: group.affiliateVideos.isNotEmpty
                          ? group.affiliateVideos.map((video) {
                              return ListTile(
                                leading: const Icon(
                                  Icons.play_circle_fill,
                                  color: redcolor,
                                ),
                                title: Text(
                                  video.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                onTap: () {
                                  // Navigate to the video player screen
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => VideoPlayerScreen(
                                          videoUrl: video.videoLink),
                                    ),
                                  );
                                },
                              );
                            }).toList()
                          : [
                              const ListTile(
                                  title: Text(
                                      'No videos available for this group'))
                            ],
                    ),
                  );
                }).toList(),
              );
            }
          },
        ),
      ),
    );
  }
}
