import 'package:flutter/material.dart';

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
            // Action for back button
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
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Replace with the actual number of videos
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: const Center(
                        child: Text(
                          'كيفيه تشغيل الابليكشن الطالب؟',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const Row(
              children: [
                SizedBox(width: 10,),
                Text('ستتوفر الفيديوهات التحديث القادم',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              ],
            ),
            const SizedBox(height: 330,),
          ],
        ),
      ),
    );
  }
}
