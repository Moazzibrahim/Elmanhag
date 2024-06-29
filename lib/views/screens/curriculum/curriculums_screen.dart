import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/views/widgets/curriculum_grid.dart';

class CurriculumsScreen extends StatelessWidget {
  const CurriculumsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back)),
                const Row(
                  children: [
                    Text(
                      'اهلا بك يوسف',
                      style: TextStyle(
                          color: redcolor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    CircleAvatar(),
                  ],
                ),
              ],
            ),
            const Expanded(child: CurriculumGrid()),
          ],
        ),
      ),
    );
  }
}
