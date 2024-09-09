// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/views/parent%20screens/home_parent_screen.dart';

class ChooseSon extends StatefulWidget {
  const ChooseSon({super.key});

  @override
  _ChooseSonState createState() => _ChooseSonState();
}

class _ChooseSonState extends State<ChooseSon> {
  int? selectedIndex; // To keep track of which card is selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: redcolor),
          onPressed: () {},
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Center(
          child: Text(
            'اهلا بك حسين',
            style: TextStyle(
              color: redcolor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  UserCard(
                    name: 'حور حسين منصور',
                    grade: 'الصف الرابع لغات',
                    isSelected: selectedIndex == 0,
                    onTap: () {
                      setState(() {
                        selectedIndex = 0;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  UserCard(
                    name: 'يامن حسين منصور',
                    grade: 'الصف الخامس لغات',
                    isSelected: selectedIndex == 1,
                    onTap: () {
                      setState(() {
                        selectedIndex = 1;
                      });
                    },
                  ),
                ],
              ),
            ),
            if (selectedIndex !=
                null) // Show the button only if a card is selected
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Add your logic here when the button is pressed
                    print("Continue with selected son: $selectedIndex");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>const HomeParentScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 80, vertical: 16),
                    backgroundColor: redcolor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  final String name;
  final String grade;
  final bool isSelected;
  final VoidCallback onTap;

  const UserCard({
    super.key,
    required this.name,
    required this.grade,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 4,
        color: isSelected
            ? Colors.red[100]
            : Colors.white, // Change color if selected
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              const CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 30,
                backgroundImage: AssetImage(
                  'assets/images/Memoji.png',
                ), // Placeholder for the avatar
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      color: redcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    grade,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
