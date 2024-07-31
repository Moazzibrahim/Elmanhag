import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';

class LeadingIcon extends StatelessWidget {
  const LeadingIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 213, 213, 213),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 12.0), // Adjust padding here
            child: Icon(Icons.arrow_back_ios, color: redcolor),
          ),
        ),
      ),
    );
  }
}
