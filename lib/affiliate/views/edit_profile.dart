import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart'; // Replace with your actual colors file

class EditaffilateProfileScreen extends StatelessWidget {
  const EditaffilateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: redcolor),
          onPressed: () {},
        ),
        title: const Text(
          'الملف الشخصي',
          style: TextStyle(
            color: redcolor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'اهلا بك احمد',
                  style: TextStyle(
                    color: redcolor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            _buildTextField('اسم المستخدم'),
            const SizedBox(height: 20),
            _buildTextField('البريد الالكترونى'),
            const SizedBox(height: 20),
            _buildTextField('رقم التليفون'),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Implement your save functionality here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: redcolor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'حفظ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label) {
    return TextField(
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        labelText: label,
        labelStyle: const TextStyle(
          color: redcolor,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: redcolor),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: redcolor),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
