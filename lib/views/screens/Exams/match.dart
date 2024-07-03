import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';

class ExamScreenMatch extends StatelessWidget {
  const ExamScreenMatch({super.key});

  void showResultDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/starts.png",
                      width: 65,
                      height: 65,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'النتيجة',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Align(
                        alignment: Alignment.topRight,
                        child: Icon(
                          Icons.close,
                          color: redcolor,
                          size: 25,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  '20/15',
                  style: TextStyle(
                    color: redcolor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Text(
                      "لقد اجتزت الامتحان",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'تهانينا لك ',
                      style: TextStyle(
                        color: redcolor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'الامتحان',
          style: TextStyle(color: redcolor, fontSize: 24),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: redcolor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            const Text(
              'صل عمود (أ) بعمود (ب)',
              style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.w400, color: greycolor),
            ),
            const SizedBox(height: 20),
            const Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('(ب)',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          SizedBox(height: 20),
                          Text('حيوانات ليس لها عمود فقري.',
                              style: TextStyle(
                                fontSize: 18,
                              )),
                          SizedBox(height: 10),
                          Text('حيوانات لها عمود فقري.',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                          SizedBox(height: 10),
                          Text('حيوانات تأكل الحيوانات الأخرى.',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                          SizedBox(height: 10),
                          Text('حيوانات تأكل النباتات.',
                              style: TextStyle(fontSize: 18, color: redcolor)),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('(أ)',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          SizedBox(height: 20),
                          Text('اللافقاريات', style: TextStyle(fontSize: 18)),
                          SizedBox(height: 10),
                          Text('الفقاريات', style: TextStyle(fontSize: 18)),
                          SizedBox(height: 10),
                          Text('اللوامح', style: TextStyle(fontSize: 18)),
                          SizedBox(height: 10),
                          Text('العواشب',
                              style: TextStyle(fontSize: 18, color: redcolor)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: redcolor),
                  onPressed: () {
                    // Handle previous button press
                  },
                  child: const Text(
                    'السابق',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: redcolor),
                    onPressed: () {
                      showResultDialog(context);
                      // Handle next button press
                    },
                    child: const Text(
                      'التالي',
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
