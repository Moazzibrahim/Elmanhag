import 'package:flutter/material.dart';// for date formatting


class LiveSessionsScreen extends StatelessWidget {
  const LiveSessionsScreen({super.key});

  // Function to get the day name in Arabic
  String getDayName(DateTime date) {
    List<String> arabicDays = [
      "السبت",
      "الأحد",
      "الاثنين",
      "الثلاثاء",
      "الأربعاء",
      "الخميس",
      "الجمعة"
    ];
    return arabicDays[date.weekday % 7]; // % 7 to wrap days properly
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'حصص لايف',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.red),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Calendar Section
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.red),
                  onPressed: () {},
                ),
                const Text(
                  'مارس 2024',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, color: Colors.red),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Date Picker with Day Names
          Container(
            height: 70, // Increased height to accommodate day names
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 31, // Assuming a month with 31 days
              itemBuilder: (context, index) {
                DateTime currentDate = DateTime(2024, 3, index + 1); // Mock March 2024
                String dayName = getDayName(currentDate);

                return GestureDetector(
                  onTap: () {
                    // Handle date selection
                  },
                  child: Column(
                    children: [
                      Text(
                        dayName,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        width: 40,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: index == 2 ? Colors.red : Colors.white, // Highlight selected day
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.red),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                              color: index == 2 ? Colors.white : Colors.black),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          // Live Sessions List
          Expanded(
            child: ListView.builder(
              itemCount: 5, // Number of live sessions
              itemBuilder: (context, index) {
                return SessionCard(
                  time: '01:00 م - 02:00 م',
                  teacher: 'أحمد علي',
                  subject: 'ماده اللغه العربيه',
                  sessionType: 'درس انا مميز',
                  imageUrl: 'https://via.placeholder.com/150', // Replace with actual image
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SessionCard extends StatelessWidget {
  final String time;
  final String teacher;
  final String subject;
  final String sessionType;
  final String imageUrl;

  SessionCard({
    required this.time,
    required this.teacher,
    required this.subject,
    required this.sessionType,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.network(imageUrl, width: 50, height: 50, fit: BoxFit.cover),
        ),
        title: Text(time, style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(teacher),
            Text(subject),
            Text(sessionType, style: const TextStyle(color: Colors.grey)),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.red),
      ),
    );
  }
}
