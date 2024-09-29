// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/live/purshased_live_controller.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LiveSessionsScreen extends StatefulWidget {
  const LiveSessionsScreen({super.key});

  @override
  State<LiveSessionsScreen> createState() => _LiveSessionsScreenState();
}

class _LiveSessionsScreenState extends State<LiveSessionsScreen> {
  DateTime currentDate = DateTime.now(); // Start with the current date
  DateTime? selectedDate;
  bool showSessions = true; // Flag to control the display of sessions

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<PurshasedLiveController>(context, listen: false)
          .getLiveDatapurshased(context);
    });
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

  // Get the month name in Arabic
  String getMonthName(int month) {
    List<String> arabicMonths = [
      "يناير",
      "فبراير",
      "مارس",
      "أبريل",
      "مايو",
      "يونيو",
      "يوليو",
      "أغسطس",
      "سبتمبر",
      "أكتوبر",
      "نوفمبر",
      "ديسمبر"
    ];
    return arabicMonths[month - 1];
  }

  // Get the start of the current week (Saturday)
  DateTime getStartOfWeek(DateTime date) {
    int difference = (date.weekday + 1) % 7;
    return date.subtract(Duration(days: difference));
  }

  // Get the week (Saturday to Friday)
  List<DateTime> getWeekDays(DateTime currentDate) {
    DateTime startOfWeek = getStartOfWeek(currentDate);
    return List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
  }
  // Function to check if a session date is today
  bool isToday(DateTime sessionDate) {
    final now = DateTime.now();
    return sessionDate.year == now.year &&
        sessionDate.month == now.month &&
        sessionDate.day == now.day;
  }

  // Function to format time to "hh:mm a" format (12-hour clock)
  String formatToHourMinute(String time) {
    final parts = time.split(':');
    if (parts.length >= 2) {
      final hour = int.parse(parts[0]);
      final minute = parts[1];

      // Determine AM or PM
      final period = hour >= 12 ? 'pm' : 'am';

      // Convert hour to 12-hour format
      final formattedHour = hour % 12 == 0 ? 12 : hour % 12;

      return '$formattedHour:$minute $period'; // Return formatted time
    }
    return time; // Return the original time if format is not matched
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
      body: Consumer<PurshasedLiveController>(
        builder: (context, purchasedLiveController, child) {
          final liveData = purchasedLiveController.dataModelss?.live ?? [];

          return purchasedLiveController.dataModelss == null
              ? const Center(
                  child: CircularProgressIndicator()) // Loading state
              : Column(
                  children: [
                    // Calendar Section
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_ios,
                                color: redcolor),
                            onPressed: () {
                              setState(() {
                                currentDate = currentDate
                                    .subtract(const Duration(days: 7));
                              });
                            },
                          ),
                          Text(
                            '${getMonthName(currentDate.month)} ${currentDate.year}',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: const Icon(Icons.arrow_forward_ios,
                                color: redcolor),
                            onPressed: () {
                              setState(() {
                                currentDate =
                                    currentDate.add(const Duration(days: 7));
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Date Picker with Day Names for the current week (Saturday to Friday)
                    SizedBox(
                      height: 70,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 7, // 7 days for the week
                        itemBuilder: (context, index) {
                          DateTime day = getWeekDays(currentDate)[index];
                          String dayName = getDayName(day);
                          return GestureDetector(
                            onTap: () {},
                            child: Column(
                              children: [
                                Text(
                                  dayName,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  width: 40,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                    color: day.day == DateTime.now().day &&
                                            currentDate.month ==
                                                DateTime.now().month
                                        ? redcolor
                                        : Colors.white, // Highlight current day
                                    shape: BoxShape.circle,
                                    border: Border.all(color: redcolor),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    '${day.day}',
                                    style: TextStyle(
                                        color: day.day == DateTime.now().day &&
                                                currentDate.month ==
                                                    DateTime.now().month
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Live Sessions List (conditional rendering)
                    if (showSessions) // Only show if the flag is true
                      Expanded(
                        child: liveData.isNotEmpty
                            ? ListView.builder(
                                itemCount:
                                    liveData.length, // Number of live sessions
                                itemBuilder: (context, index) {
                                  final session = liveData[index];
                                  return SessionCard(
                                    fromTime: formatToHourMinute(session.from!),
                                    toTime: formatToHourMinute(session.to!),
                                    teacher: session.teacher?.name ?? "Unknown",
                                    subject: session.subject?.name ?? "Unknown",
                                    thumbnailUrl:
                                        session.subject?.thumbnailUrl ?? '',
                                    link: session.link ??
                                        '', // Pass the link from the session
                                  );
                                },
                              )
                            : const Center(
                                child: Text(
                                  'No sessions available for this date',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey),
                                ),
                              ),
                      )
                    else
                      const Center(
                        child: Text(
                          'No sessions available for this date',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ),
                  ],
                );
        },
      ),
    );
  }
}

class SessionCard extends StatelessWidget {
  final String fromTime;
  final String toTime;
  final String teacher;
  final String subject;
  final String thumbnailUrl;
  final String link; // Add this line

  const SessionCard({
    super.key,
    required this.fromTime,
    required this.toTime,
    required this.teacher,
    required this.subject,
    required this.thumbnailUrl,
    required this.link, // Add this line
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Column(
        children: [
          ListTile(
            title: Text(
              'from $fromTime - to $toTime',
              style: const TextStyle(
                color: redcolor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: SizedBox(
              width: 50,
              height: 50,
              child: thumbnailUrl.isNotEmpty
                  ? Image.network(thumbnailUrl)
                  : const Icon(Icons.image, size: 50, color: Colors.grey),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  teacher,
                  style: const TextStyle(color: Colors.black87, fontSize: 14),
                ),
                Text(
                  subject,
                  style: const TextStyle(color: Colors.black54, fontSize: 14),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                final url = Uri.parse(link); // Use the passed link
                if (await canLaunch(url.toString())) {
                  await launch(url.toString());
                } else {
                  throw 'Could not launch $url';
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: redcolor,
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
              ),
              child: const Text(
                'حضور',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
