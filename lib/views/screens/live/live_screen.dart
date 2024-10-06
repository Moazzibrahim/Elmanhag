// ignore_for_file: use_build_context_synchronously, deprecated_member_use, unused_local_variable
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/Auth/login_provider.dart';
import 'package:flutter_application_1/controller/live/purshased_live_controller.dart';
import 'package:flutter_application_1/localization/app_localizations.dart';
import 'package:flutter_application_1/views/screens/payment/payment_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

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
    selectedDate = DateTime.now(); // Automatically select today's date
    Future.delayed(Duration.zero, () {
      Provider.of<PurshasedLiveController>(context, listen: false)
          .getLiveDatapurshased(context)
          .then((_) {
        // Check if there are any live sessions for today and display them
        if (liveSessionsForSelectedDay(
                Provider.of<PurshasedLiveController>(context, listen: false)
                    .dataModelss!
                    .live!)
            .isNotEmpty) {
          setState(() {
            showSessions = true; // Automatically show sessions if they exist
          });
        } else {
          setState(() {
            showSessions = false; // Hide sessions if none exist for today
          });
        }
      });
    });
  }

  // Function to get the day name in Arabic
  String getDayName(DateTime date) {
    final localizations = AppLocalizations.of(context);
    List<String> arabicDays = [
      (localizations.translate('saturday')),
      (localizations.translate('sunday')),
      (localizations.translate('monday')),
      (localizations.translate('tuesday')),
      (localizations.translate('wednesday')),
      (localizations.translate('thursday')),
      (localizations.translate('friday'))
    ];
    return arabicDays[(date.weekday + 1) % 7]; // Adjust to start from Saturday
  }

  // Get the month name in Arabic
  String getMonthName(int month) {
    final localizations = AppLocalizations.of(context);
    List<String> arabicMonths = [
      (localizations.translate('january')),
      (localizations.translate('february')),
      (localizations.translate('march')),
      (localizations.translate('april')),
      (localizations.translate('may')),
      (localizations.translate('june')),
      (localizations.translate('july')),
      (localizations.translate('august')),
      (localizations.translate('september')),
      (localizations.translate('october')),
      (localizations.translate('november')),
      (localizations.translate('december'))
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
    final localizations = AppLocalizations.of(context);
    final parts = time.split(':');
    if (parts.length >= 2) {
      final hour = int.parse(parts[0]);
      final minute = parts[1];
      // Determine AM or PM
      final period = hour >= 12
          ? localizations.translate('pm')
          : localizations.translate('am');
      // Convert hour to 12-hour format
      final formattedHour = hour % 12 == 0 ? 12 : hour % 12;
      return '$formattedHour:$minute $period'; // Return formatted time
    }
    return time; // Return the original time if format is not matched
  }

  // Function to filter live sessions based on selected day
  // Function to filter live sessions based on selected day and current time
  List liveSessionsForSelectedDay(List liveData) {
    return liveData.where((session) {
      DateTime sessionDate =
          DateTime.parse(session.date!); // Parse session date
      DateTime sessionStartTime = DateTime.parse(
          "${session.date!} ${session.from!}"); // Parse session start time
      DateTime sessionEndTime = DateTime.parse(
          "${session.date!} ${session.to!}"); // Parse session end time

      // Filter sessions that are on the selected date and haven't ended
      return sessionDate.year == selectedDate?.year &&
          sessionDate.month == selectedDate?.month &&
          sessionDate.day == selectedDate?.day &&
          DateTime.now().isBefore(
              sessionEndTime); // Only show sessions that have not ended
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ' ${localizations.translate('live_classes')}',
          style: const TextStyle(
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
                            onTap: () {
                              setState(() {
                                selectedDate = day; // Set selected date
                                showSessions =
                                    true; // Show sessions based on the date
                              });
                            },
                            child: Column(
                              children: [
                                Text(
                                  dayName,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 11,
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
                    if (showSessions) // Only show if the flag is true
                      Expanded(
                        child: selectedDate != null
                            ? liveSessionsForSelectedDay(liveData).isNotEmpty
                                ? ListView.builder(
                                    itemCount:
                                        liveSessionsForSelectedDay(liveData)
                                            .length, // Number of live sessions
                                    itemBuilder: (context, index) {
                                      final session =
                                          liveSessionsForSelectedDay(
                                              liveData)[index];
                                      return SessionCard(
                                        fromTime:
                                            formatToHourMinute(session.from!),
                                        toTime: formatToHourMinute(session.to!),
                                        teacher:
                                            session.teacher?.name ?? "Unknown",
                                        subject:
                                            session.subject?.name ?? "Unknown",
                                        thumbnailUrl:
                                            session.subject?.thumbnailUrl ?? '',
                                        link: session.link ?? '',
                                        sessionId: session.id ?? 0,
                                        sessionPrice: session.price ?? 0,
                                      );
                                    },
                                  )
                                : const Center(
                                    child: Text(
                                      'No live sessions available for this date',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.grey),
                                    ),
                                  )
                            : const Center(
                                child: Text(
                                  'No live sessions available for this date',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey),
                                ),
                              ),
                      )
                    else
                      const Center(
                        child: Text(
                          'No live sessions available for this date',
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
  final String link;
  final int sessionId;
  final int sessionPrice; // Add sessionPrice here

  const SessionCard({
    super.key,
    required this.fromTime,
    required this.toTime,
    required this.teacher,
    required this.subject,
    required this.thumbnailUrl,
    required this.link,
    required this.sessionId,
    required this.sessionPrice, // Add this line
  });

  @override
  Widget build(BuildContext context) {
    void navigateToPaymentScreen(BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentScreen(
            itemservice: 'Live session',
            sessionliveid: sessionId,
            itemidbundle: 0,
            itemidsubject: 0,
            itemprice: sessionPrice.toString(),
          ), // Pass sessionId and price to the PaymentScreen
        ),
      );
    }

    // Function to show the "Buy" dialog
    void showBuyDialog(BuildContext context, String errorMessage) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(errorMessage),
                const SizedBox(height: 10),
                Text(
                  "Price: $sessionPrice L.E", // Show session price
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: redcolor),
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: redcolor),
                onPressed: () {
                  navigateToPaymentScreen(
                      context); // Navigate to the payment screen
                },
                child: const Text(
                  "Buy Now",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        },
      );
    }

    Future<void> checkpaidlive() async {
      final url =
          "https://bdev.elmanhag.shop/student/subscription/check/$sessionId";
      final token = Provider.of<TokenModel>(context, listen: false).token;

      DateTime now = DateTime.now();

      // Helper function to convert Arabic AM/PM to English
      String convertArabicToEnglishTime(String time) {
        // Replace Arabic AM/PM with English equivalents
        time = time.replaceAll('ص', 'AM').replaceAll('م', 'PM');
        return time;
      }

      try {
        // Call the API and check if the user is allowed to attend
        final response = await http.post(Uri.parse(url), headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });

        if (response.statusCode == 200) {
          final responseBody = jsonDecode(response.body);

          if (responseBody.containsKey('success') &&
              responseBody['success'] == "You are allowed to attend") {
            // Proceed to the 10-minute time check only if the API response is successful

            // Convert the Arabic fromTime to English AM/PM
            String convertedFromTime = convertArabicToEnglishTime(fromTime);

            // Create a DateFormat object for parsing the time (now using standard AM/PM format)
            DateFormat timeFormat =
                DateFormat('hh:mm a'); // For 12-hour format with AM/PM

            // Parse the convertedFromTime
            DateTime sessionStartTime = timeFormat.parse(convertedFromTime);

            // Check if the current time is within 10 minutes before the session start time
            Duration timeDifference = sessionStartTime.difference(now);

            if (timeDifference.inMinutes <= 10 &&
                timeDifference.inMinutes >= 0) {
              // Open the session link
              final uri = Uri.parse(link);
              if (await canLaunch(uri.toString())) {
                await launch(uri.toString());
              } else {
                log('Could not launch $uri');
              }
            } else {
              // If the user is trying to enter more than 10 minutes before the session starts
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                      'You can only join 10 minutes before the session starts.')));
            }
          } else {
            showBuyDialog(context, 'You must buy live first');
          }
        } else {
          log("Error in posting session ID. Status code: ${response.statusCode}");
          showBuyDialog(context, 'You must buy live first');
        }
      } catch (e) {
        log("Error: $e");
      }
    }

    // Function to navigate to the payment screen

    final localizations = AppLocalizations.of(context);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Column(
        children: [
          ListTile(
            title: Text(
              '${localizations.translate('from')} $fromTime - ${localizations.translate('to')} $toTime',
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
                await checkpaidlive();
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
              child: Text(
                localizations.translate('attend'),
                style: const TextStyle(
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
