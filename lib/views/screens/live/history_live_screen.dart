import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';

class HistoryLiveScreen extends StatelessWidget {
  const HistoryLiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('حصص لايف',
              style: TextStyle(color: redcolor, fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: redcolor),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // Handle back button press
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Center(
                            child: Text('اسم الدرس',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: redcolor)))),
                    Expanded(
                        child: Center(
                            child: Text('المواعيد',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: redcolor)))),
                    Expanded(
                        child: Center(
                            child: Text('التكلفه',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: redcolor)))),
                    Expanded(
                        child: Center(
                            child: Text('الحاله',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: redcolor)))),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    buildClassRow('أنا مميز', '03:00 PM - 04:30 PM', 'مجانا',
                        'طلب دخول', redcolor),
                    buildClassRow('أنا مميز', '03:00 PM - 04:30 PM', 'تم الدفع',
                        'دخول', redcolor),
                    buildClassRow('أنا مميز', '03:00 PM - 04:30 PM', '50 جنيه',
                        'شراء', redcolor),
                    buildClassRow('أنا مميز', '03:00 PM - 04:30 PM', 'مجانا',
                        'طلب دخول', redcolor),
                    // Add more rows as needed
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildClassRow(String className, String timings, String cost,
      String status, Color statusColor) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Center(
                    child: Text(className,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14)))),
            Expanded(
                child: Center(
                    child: Text(timings,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14)))),
            Expanded(
                child: Center(
                    child: Text(cost,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14)))),
            Expanded(
              child: Center(
                child: Text(
                  status,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: statusColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
