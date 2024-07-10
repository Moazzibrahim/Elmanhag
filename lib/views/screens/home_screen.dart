import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/views/screens/profile/profile_screen.dart';
import 'package:flutter_application_1/views/widgets/home_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => const CustomProfileScreen()));
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
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
                  CircleAvatar(
                    backgroundImage: AssetImage(
                        'assets/images/tefl.png'), // Replace with actual image asset or network image
                    radius: 20,
                  ),
                ],
              ),
            ),
            const Expanded(child: HomeGrid()),
          ],
        ),
      ),
    );
  }
}
