import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/views/screens/login/second_sign_screen.dart';
import 'package:flutter_application_1/views/widgets/progress_widget.dart';
import 'package:flutter_application_1/views/widgets/text_field.dart';

class SignScreen extends StatefulWidget {
  const SignScreen({super.key});

  @override
  _SignScreenState createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _parentNameController = TextEditingController();
  final TextEditingController _parentPhoneController = TextEditingController();
  final TextEditingController _parentEmailController = TextEditingController();

  String? _selectedGender;

  final RegExp emailRegExp =
      RegExp(r"^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[cC][oO][mM]$");
  final RegExp phoneRegExp = RegExp(r'^[0-9]{11}$');

  @override
  void initState() {
    super.initState();

    // Generate student email based on phone number
    _phoneController.addListener(() {
      String phoneNumber = _phoneController.text;
      if (phoneRegExp.hasMatch(phoneNumber)) {
        _emailController.text = '$phoneNumber@elmanhag.com';
      } else {
        _emailController.clear();
      }
    });

    // Generate parent email based on parent's phone number
    _parentPhoneController.addListener(() {
      String parentPhoneNumber = _parentPhoneController.text;
      if (phoneRegExp.hasMatch(parentPhoneNumber)) {
        _parentEmailController.text = '$parentPhoneNumber@elmanhag.com';
      } else {
        _parentEmailController.clear();
      }
    });
  }

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
            Row(
              children: [
                Expanded(
                  child: buildTextField(
                    controller: _nameController,
                    labelText: 'اسم الطالب',
                    prefixIcon: const Icon(Icons.person, color: redcolor),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'الجنس',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: redcolor),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: redcolor),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    value: _selectedGender,
                    hint: const Text('اختار الجنس'),
                    items: ['ذكر', 'أنثى'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedGender = newValue;
                      });
                    },
                  ),
                ),
              ],
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
              textdirection: TextDirection.ltr,
              prefixIcon: const Icon(Icons.email, color: redcolor),
            ),
            const SizedBox(height: 15),
            buildTextField(
              controller: _parentNameController,
              labelText: 'اسم ولي الامر',
              prefixIcon: const Icon(Icons.person, color: redcolor),
            ),
            const SizedBox(height: 15),
            buildTextField(
              controller: _parentPhoneController,
              labelText: 'رقم ولي الامر',
              prefixIcon: const Icon(Icons.phone, color: redcolor),
            ),
            const SizedBox(height: 15),
            buildTextField(
              controller: _parentEmailController,
              labelText: 'ايميل ولي الامر',
              textdirection: TextDirection.ltr,
              prefixIcon: const Icon(Icons.email, color: redcolor),
            ),
            const SizedBox(height: 15),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (_nameController.text.isEmpty ||
                      _emailController.text.isEmpty ||
                      _phoneController.text.isEmpty ||
                      _parentNameController.text.isEmpty ||
                      _parentPhoneController.text.isEmpty ||
                      _parentEmailController.text.isEmpty ||
                      _selectedGender == null) {
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
                  } else {
                    String genderToSend =
                        _selectedGender == 'ذكر' ? 'male' : 'female';

                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SecondSignScreen(
                          name: _nameController.text,
                          email: _emailController.text,
                          phone: _phoneController.text,
                          parentName: _parentNameController.text,
                          parentPhone: _parentPhoneController.text,
                          parentEmail: _parentEmailController.text,
                          gender: genderToSend, // Send "male" or "female"
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
                        _parentNameController.text =
                            result['parentName'] ?? _parentNameController.text;
                        _parentPhoneController.text = result['parentPhone'] ??
                            _parentPhoneController.text;
                        _parentEmailController.text = result['parentEmail'] ??
                            _parentEmailController.text;
                        _selectedGender = result['gender'] ?? _selectedGender;
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
