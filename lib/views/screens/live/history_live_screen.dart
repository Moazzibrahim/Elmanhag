import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/localization/app_localizations.dart';

class HistoryLiveScreen extends StatelessWidget {
  const HistoryLiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.translate('live_classes'),
            style:
                const TextStyle(color: redcolor, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: redcolor),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Center(
                          child: Text(localizations.translate('lesson_name'),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: redcolor)))),
                  Expanded(
                      child: Center(
                          child: Text(localizations.translate('timings'),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: redcolor)))),
                  Expanded(
                      child: Center(
                          child: Text(localizations.translate('cost'),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: redcolor)))),
                  Expanded(
                      child: Center(
                          child: Text(localizations.translate('status'),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: redcolor)))),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  buildClassRow(
                      localizations,
                      'أنا مميز',
                      '03:00 PM - 04:30 PM',
                      localizations.translate('free'),
                      localizations.translate('request_entry'),
                      redcolor),
                  buildClassRow(
                      localizations,
                      'أنا مميز',
                      '03:00 PM - 04:30 PM',
                      localizations.translate('paid'),
                      localizations.translate('enter'),
                      redcolor),
                  buildClassRow(
                      localizations,
                      'أنا مميز',
                      '03:00 PM - 04:30 PM',
                      '50 جنيه',
                      localizations.translate('buy'),
                      redcolor),
                  buildClassRow(
                      localizations,
                      'أنا مميز',
                      '03:00 PM - 04:30 PM',
                      localizations.translate('free'),
                      localizations.translate('request_entry'),
                      redcolor),
                  // Add more rows as needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildClassRow(AppLocalizations localizations, String className,
      String timings, String cost, String status, Color statusColor) {
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
