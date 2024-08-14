import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';

class ProgressCircles extends StatelessWidget {
  final int currentScreen;

  const ProgressCircles({Key? key, required this.currentScreen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize:
            MainAxisSize.min, // Ensures the Row takes up minimal space
        children: List.generate(3, (index) {
          return Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: currentScreen > index ? redcolor : Colors.grey,
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              if (index < 2)
                Container(
                  width: 80, // Adjust this to control the line width
                  height: 2,
                  color: currentScreen > index ? redcolor : Colors.grey,
                ),
            ],
          );
        }),
      ),
    );
  }
}
