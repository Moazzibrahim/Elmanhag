import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/localization/app_localizations.dart';

class PrivateLiveScreen extends StatefulWidget {
  const PrivateLiveScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PrivateLiveScreenState createState() => _PrivateLiveScreenState();
}

class _PrivateLiveScreenState extends State<PrivateLiveScreen> {
  String? selectedUnit;
  String? selectedLesson;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    final List<String> units = [
      localizations.translate('unit_1'),
      localizations.translate('unit_2'),
      localizations.translate('unit_3')
    ];

    final List<String> lessons = [
      localizations.translate('lesson_1'),
      localizations.translate('lesson_2'),
      localizations.translate('lesson_3')
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          localizations.translate('private_classes'),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: redcolor,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildDropdownField(
              label: localizations.translate('select_unit'),
              value: selectedUnit,
              items: units,
              onChanged: (value) {
                setState(() {
                  selectedUnit = value;
                });
              },
            ),
            const SizedBox(height: 20),
            buildDropdownField(
              label: localizations.translate('select_lesson'),
              value: selectedLesson,
              items: lessons,
              onChanged: (value) {
                setState(() {
                  selectedLesson = value;
                });
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Handle button press
              },
              // ignore: sort_child_properties_last
              child: Text(
                localizations.translate('request'),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: redcolor,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: redcolor,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: redcolor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: redcolor, width: 2.0),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      ),
      value: value,
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: const TextStyle(fontSize: 16),
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
