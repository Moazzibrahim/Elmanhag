import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/views/screens/login/second_sign_screen.dart';
import 'package:flutter_application_1/views/widgets/progress_widget.dart';
import 'package:flutter_application_1/views/widgets/text_field.dart';

class SignScreen extends StatefulWidget {
  const SignScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignScreenState createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  // Regex for email and phone validation
  final RegExp emailRegExp =
      RegExp(r"^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[cC][oO][mM]$");
  // Simple email validation regex
  final RegExp phoneRegExp =
      RegExp(r'^[0-9]{11}$'); // Updated: 11-digit phone number validation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'انشاء حساب',
          style: TextStyle(fontWeight: FontWeight.bold, color: redcolor),
        ),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: redcolor),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProgressCircles(currentScreen: 1),
            const SizedBox(height: 15),
            const Text(
              '  بيانات الطالب',
              style: TextStyle(
                fontSize: 24,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),
            buildTextField(
              controller: _nameController,
              labelText: 'اسم الطالب',
              prefixIcon: const Icon(Icons.person, color: redcolor),
            ),
            const SizedBox(height: 15),
            buildTextField(
              controller: _phoneController,
              labelText: 'رقم تليفون الطالب',
              prefixIcon: const Icon(Icons.phone, color: redcolor),
            ),
            const SizedBox(height: 15),
            buildTextField(
              controller: _emailController,
              labelText: 'ايميل الطالب',
              prefixIcon: const Icon(Icons.email, color: redcolor),
            ),
            const SizedBox(height: 15),
            PasswordField(
                controller: _passwordController, labelText: "الرقم السري"),
            const SizedBox(height: 15),
            PasswordField(
                controller: _confirmPasswordController,
                labelText: "تاكيدالرقم السري"),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  // Validation logic
                  if (_nameController.text.isEmpty ||
                      _emailController.text.isEmpty ||
                      _passwordController.text.isEmpty ||
                      _confirmPasswordController.text.isEmpty ||
                      _phoneController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('يجب ملء جميع البيانات'),
                        backgroundColor: redcolor,
                      ),
                    );
                  } else if (!emailRegExp.hasMatch(_emailController.text)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('البريد الإلكتروني غير صالح'),
                        backgroundColor: redcolor,
                      ),
                    );
                  } else if (!phoneRegExp.hasMatch(_phoneController.text)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('رقم الهاتف غير صالح'),
                        backgroundColor: redcolor,
                      ),
                    );
                  } else if (_passwordController.text !=
                      _confirmPasswordController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('كلمتا السر غير متطابقتين'),
                        backgroundColor: redcolor,
                      ),
                    );
                  } else {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SecondSignScreen(
                          name: _nameController.text,
                          email: _emailController.text,
                          password: _passwordController.text,
                          confpassword: _confirmPasswordController.text,
                          phone: _phoneController.text,
                        ),
                      ),
                    );
                    if (result != null) {
                      setState(() {
                        _nameController.text =
                            result['name'] ?? _nameController.text;
                        _emailController.text =
                            result['email'] ?? _emailController.text;
                        _phoneController.text =
                            result['phone'] ?? _phoneController.text;
                        _passwordController.text =
                            result['password'] ?? _passwordController.text;
                        _confirmPasswordController.text =
                            result['confpassword'] ??
                                _confirmPasswordController.text;
                      });
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: redcolor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'التالي',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Divider(color: Colors.grey),
            const SizedBox(height: 20),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'لديك حساب؟ تسجيل الدخول',
                  style: TextStyle(
                      fontSize: 18,
                      color: redcolor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
