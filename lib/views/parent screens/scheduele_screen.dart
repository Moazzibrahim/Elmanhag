import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

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
            // Add navigation logic here
          },
        ),
        title: const Text(
          'الحصص والمراجعات',
          style: TextStyle(color: redcolor, fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl, // Make the layout right-to-left
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Class Schedule
              const Text(
                'جدول الحصص:',
                style: TextStyle(
                  fontSize: 18,
                  color: redcolor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              DataTable(
                columns: const [
                  DataColumn(
                    label: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'الماده',
                        style: TextStyle(color: redcolor),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'اليوم',
                        style: TextStyle(color: redcolor),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'الساعة',
                        style: TextStyle(color: redcolor),
                      ),
                    ),
                  ),
                ],
                rows: const [
                  DataRow(cells: [
                    DataCell(Text('العلوم')),
                    DataCell(Text('20/3')),
                    DataCell(Text('12:00 ص')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('الرياضيات')),
                    DataCell(Text('20/3')),
                    DataCell(Text('12:00 ص')),
                  ]),
                ],
              ),
              const SizedBox(height: 30),
              // Final Reviews
              const Text(
                'المراجعات النهائيه:',
                style: TextStyle(
                  fontSize: 18,
                  color: redcolor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              DataTable(
                columns: const [
                  DataColumn(
                    label: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'الماده',
                        style: TextStyle(color: redcolor),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'اليوم',
                        style: TextStyle(color: redcolor),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'الساعة',
                        style: TextStyle(color: redcolor),
                      ),
                    ),
                  ),
                ],
                rows: const [
                  DataRow(cells: [
                    DataCell(Text('العلوم')),
                    DataCell(Text('20/3')),
                    DataCell(Text('12:00 ص')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('الرياضيات')),
                    DataCell(Text('20/3')),
                    DataCell(Text('12:00 ص')),
                  ]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
