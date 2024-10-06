import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON encoding and decoding
import 'package:flutter_application_1/constants/colors.dart'; // Replace with your actual colors file
import 'package:provider/provider.dart'; // Make sure you have this imported for Provider

import '../../controller/Auth/login_provider.dart'; // Replace with your actual TokenModel import

class EditAffiliateProfileScreen extends StatefulWidget {
  const EditAffiliateProfileScreen({super.key});

  @override
  _EditAffiliateProfileScreenState createState() =>
      _EditAffiliateProfileScreenState();
}

class _EditAffiliateProfileScreenState
    extends State<EditAffiliateProfileScreen> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // Function to send data to the API
  Future<void> _updateProfile() async {
    final String phone = _phoneController.text;
    final String password = _passwordController.text;
    final String confirmPassword = _confirmPasswordController.text;

    // Get the token from TokenModel provider
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final String? token = tokenProvider.token;

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    final url = Uri.parse('https://bdev.elmanhag.shop/affilate/profile/update');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Include the token in the header
      },
      body: jsonEncode({
        'phone': phone,
        'password': password,
        'conf_password': confirmPassword,
      }),
    );

    if (response.statusCode == 200) {
      // Handle successful response
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
      Navigator.of(context).pop(); // Navigate back after successful update
    } else {
      // Handle error response
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update profile')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: redcolor),
          onPressed: () {
            Navigator.of(context).pop();
          },
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

            _buildTextField('رقم التليفون', _phoneController),
            const SizedBox(height: 20),
            _buildPasswordField(
                'كلمة المرور', _passwordController, _obscurePassword, () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            }), // Password field
            const SizedBox(height: 20),
            _buildPasswordField('تأكيد كلمة المرور', _confirmPasswordController,
                _obscureConfirmPassword, () {
              setState(() {
                _obscureConfirmPassword = !_obscureConfirmPassword;
              });
            }), // Confirm password field
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _updateProfile, // Call the function to send data
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

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
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

  Widget _buildPasswordField(String label, TextEditingController controller,
      bool obscureText, VoidCallback toggleObscureText) {
    return TextField(
      controller: controller,
      obscureText: obscureText, // Toggles visibility
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
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
            color: redcolor,
          ),
          onPressed: toggleObscureText,
        ),
      ),
    );
  }
}
