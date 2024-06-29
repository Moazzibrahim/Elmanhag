import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/views/screens/login/second_sign_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _parentNameController = TextEditingController();
  final TextEditingController _parentPhoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'انشاء حساب',
          style: TextStyle(fontWeight: FontWeight.bold, color: redcolor),
        ),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: redcolor),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'أهلا بك معنا',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 30),
              buildTextField(
                controller: _nameController,
                labelText: 'الاسم',
                prefixIcon: Icon(Icons.person, color: redcolor),
              ),
              SizedBox(height: 15),
              buildTextField(
                controller: _emailController,
                labelText: 'الايميل',
                prefixIcon: Icon(Icons.email, color: redcolor),
              ),
              SizedBox(height: 15),
              buildPasswordField(),
              SizedBox(height: 15),
              buildTextField(
                controller: _parentNameController,
                labelText: 'اسم ولي الامر',
                prefixIcon: Icon(Icons.person_outline, color: redcolor),
              ),
              SizedBox(height: 15),
              buildTextField(
                controller: _parentPhoneController,
                labelText: 'رقم ولي الامر',
                prefixIcon: Icon(Icons.phone, color: redcolor),
              ),
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SecondSignScreen(
                          name: _nameController.text,
                          email: _emailController.text,
                          password: _passwordController.text,
                          parentName: _parentNameController.text,
                          parentPhone: _parentPhoneController.text,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: redcolor,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    textStyle: TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'اكمل',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Divider(color: Colors.grey),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildSocialIconButton(FontAwesomeIcons.facebook),
                  SizedBox(width: 20),
                  buildSocialIconButton(FontAwesomeIcons.instagram),
                  SizedBox(width: 20),
                  buildSocialIconButton(FontAwesomeIcons.twitter),
                ],
              ),
              SizedBox(height: 30),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
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
        border: UnderlineInputBorder(),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: redcolor),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: redcolor),
        ),
      ),
    );
  }

  Widget buildPasswordField() {
    bool _passwordVisible = false;

    return TextField(
      controller: _passwordController,
      obscureText: !_passwordVisible,
      decoration: InputDecoration(
        labelText: 'الرقم السري',
        prefixIcon: Icon(Icons.lock, color: redcolor),
        suffixIcon: IconButton(
          icon: Icon(
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: redcolor,
          ),
          onPressed: () {
            _passwordVisible = !_passwordVisible;
          },
        ),
        border: UnderlineInputBorder(),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: redcolor),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: redcolor),
        ),
      ),
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
