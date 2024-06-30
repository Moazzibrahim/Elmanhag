import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/views/screens/login/second_sign_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _parentNameController = TextEditingController();
  final TextEditingController _parentPhoneController = TextEditingController();

  SignScreen({super.key});

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
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'أهلا بك معنا',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 30),
              buildTextField(
                controller: _nameController,
                labelText: 'الاسم',
                prefixIcon: const Icon(Icons.person, color: redcolor),
              ),
              const SizedBox(height: 15),
              buildTextField(
                controller: _emailController,
                labelText: 'الايميل',
                prefixIcon: const Icon(Icons.email, color: redcolor),
              ),
              const SizedBox(height: 15),
              buildPasswordField(_passwordController, 'الرقم السري'),
              const SizedBox(height: 15),
              buildPasswordField(
                  _confirmPasswordController, 'تأكيد الرقم السري'),
              const SizedBox(height: 15),
              buildTextField(
                controller: _parentNameController,
                labelText: 'اسم ولي الامر',
                prefixIcon: const Icon(Icons.person_outline, color: redcolor),
              ),
              const SizedBox(height: 15),
              buildTextField(
                controller: _parentPhoneController,
                labelText: 'رقم ولي الامر',
                prefixIcon: const Icon(Icons.phone, color: redcolor),
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_nameController.text.isEmpty ||
                        _emailController.text.isEmpty ||
                        _passwordController.text.isEmpty ||
                        _confirmPasswordController.text.isEmpty ||
                        _parentNameController.text.isEmpty ||
                        _parentPhoneController.text.isEmpty) {
                      // Show an error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('يجب ملء جميع الحقول'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else if (_passwordController.text !=
                        _confirmPasswordController.text) {
                      // Show an error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('كلمتا السر غير متطابقتين'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else {
                      // Navigate to the next screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SecondSignScreen(
                            confpassword: _confirmPasswordController.text,
                            name: _nameController.text,
                            email: _emailController.text,
                            password: _passwordController.text,
                            parentName: _parentNameController.text,
                            parentPhone: _parentPhoneController.text,
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: redcolor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    textStyle: const TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'اكمل',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Divider(color: Colors.grey),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildSocialIconButton(FontAwesomeIcons.facebook),
                  const SizedBox(width: 20),
                  buildSocialIconButton(FontAwesomeIcons.instagram),
                  const SizedBox(width: 20),
                  buildSocialIconButton(FontAwesomeIcons.twitter),
                ],
              ),
              const SizedBox(height: 15),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'لديك حساب؟ تسجيل الدخول',
                    style: TextStyle(fontSize: 18, color: redcolor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String labelText,
    Widget? prefixIcon,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: prefixIcon,
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
    );
  }

  Widget buildPasswordField(
      TextEditingController controller, String labelText) {
    bool _passwordVisible = false;

    return StatefulBuilder(
      builder: (context, setState) {
        return TextField(
          controller: controller,
          obscureText: !_passwordVisible,
          decoration: InputDecoration(
            labelText: labelText,
            prefixIcon: const Icon(Icons.lock, color: redcolor),
            suffixIcon: IconButton(
              icon: Icon(
                _passwordVisible ? Icons.visibility : Icons.visibility_off,
                color: redcolor,
              ),
              onPressed: () {
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
            ),
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
        );
      },
    );
  }

  Widget buildSocialIconButton(IconData icon) {
    return IconButton(
      icon: FaIcon(icon, color: redcolor),
      iconSize: 30,
      onPressed: () {},
    );
  }
}
