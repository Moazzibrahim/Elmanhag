import 'package:flutter/material.dart';
import 'package:flutter_application_1/affiliate/views/edit_profile.dart';
import 'package:flutter_application_1/constants/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
          },
        ),
        title: const Align(
          alignment: Alignment.centerRight,
          child: Text(
            'الملف الشخصي',
            style: TextStyle(
              color: redcolor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'اهلا بك احمد',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: redcolor,
                  ),
                ),
                const SizedBox(width: 8),
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/avatar.png'),
                  radius: 25,
                ),
                const SizedBox(
                  width: 8,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const EditaffilateProfileScreen()));
                    },
                    icon: const Icon(Icons.edit))
              ],
            ),
            const SizedBox(height: 40),
            _buildProfileItem('محمد احمد'),
            const SizedBox(height: 10),
            _buildProfileItem('amalghanrm888@gmail.com'),
            const SizedBox(height: 10),
            _buildProfileItem('15/5/2024'),
            const SizedBox(height: 10),
            _buildProfileItem('01228566645'),
            const SizedBox(height: 10),
            _buildProfileItem('نشط'),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey.shade700,
          ),
        ),
      ),
    );
  }
}
