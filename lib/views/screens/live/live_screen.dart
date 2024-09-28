import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/live/purshased_live_controller.dart';
import 'package:provider/provider.dart';

class LiveSessionsScreen extends StatefulWidget {
  const LiveSessionsScreen({super.key});

  @override
  State<LiveSessionsScreen> createState() => _LiveSessionsScreenState();
}

class _LiveSessionsScreenState extends State<LiveSessionsScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<PurshasedLiveController>(context).getLiveDatapurshased(context);
  }

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
    return arabicDays[(date.weekday + 1) % 7]; // Adjust to start from Saturday
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'حصص لايف',
          style: TextStyle(
              color: redcolor, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: redcolor),
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
                  icon: const Icon(Icons.arrow_back_ios, color: redcolor),
                  onPressed: () {},
                ),
                const Text(
                  'سبتمبر 2024',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, color: redcolor),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Date Picker with Day Names
          SizedBox(
            height: 70, // Increased height to accommodate day names
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 31, // Assuming a month with 31 days
              itemBuilder: (context, index) {
                DateTime currentDate =
                    DateTime(2024, 9, index); // Mock March 2024
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
                          color: index == 2
                              ? redcolor
                              : Colors.white, // Highlight selected day
                          shape: BoxShape.circle,
                          border: Border.all(color: redcolor),
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
                return const SessionCard(
                  time: '01:00 م - 02:00 م',
                  teacher: 'أحمد علي',
                  subject: 'ماده اللغه العربيه',
                  sessionType: 'درس انا مميز',
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

  const SessionCard({
    super.key,
    required this.time,
    required this.teacher,
    required this.subject,
    required this.sessionType,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: ListTile(
        leading: SizedBox(
          child: Image.asset(
            "assets/images/side.png",
          ),
        ),
        title: Text(time,
            style:
                const TextStyle(color: redcolor, fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(teacher),
            Text(subject),
            Text(sessionType, style: const TextStyle(color: Colors.grey)),
          ],
        ),
        trailing: Image.asset("assets/images/livei.png"),
      ),
    );
  }
}
