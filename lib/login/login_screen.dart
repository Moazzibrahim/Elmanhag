// ignore_for_file: avoid_print, library_private_types_in_public_api

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/forget_password/forget_password.dart';
import 'package:flutter_application_1/login/sign_screen.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_application_1/constants/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscured = true;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // Set the text direction to RTL
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 50),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'المنهج',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      color: redcolor,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'أهلا بك',
                  style: TextStyle(
                    fontSize: 32,
                    color: greycolor,
                  ),
                ),
                const SizedBox(height: 20),
                const TextField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    labelText: 'الاسم',
                    hintText: 'اسم المستخدم',
                    labelStyle: TextStyle(color: greycolor),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: redcolor),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  textAlign: TextAlign.right,
                  obscureText: _isObscured,
                  decoration: InputDecoration(
                    labelText: 'الرقم السري',
                    hintText: 'رقمك السري',
                    labelStyle: const TextStyle(color: greycolor),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: redcolor),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscured ? Icons.visibility_off : Icons.visibility,
                        color: redcolor,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscured = !_isObscured;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    child: const Text(
                      'هل نسيت كلمه المرور؟',
                      style: TextStyle(
                          color: redcolor,
                          decoration: TextDecoration.underline),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ForgetPasswordScreen()));
                    },
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx)=> const HomeScreen())
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: redcolor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 100, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'تسجيل الدخول',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Divider(
                          color: greycolor,
                          height: 50,
                        ),
                      ),
                    ),
                    Text("أو"),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Divider(
                          color: greycolor,
                          height: 50,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: const FaIcon(FontAwesomeIcons.facebook,
                          color: redcolor),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const FaIcon(FontAwesomeIcons.instagram,
                          color: redcolor),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const FaIcon(FontAwesomeIcons.xTwitter,
                          color: redcolor),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'ليس لديك حساب؟ ',
                          style: TextStyle(color: greycolor, fontSize: 18),
                        ),
                        TextSpan(
                          text: 'إنشاء حساب',
                          style: const TextStyle(
                              color: redcolor,
                              decoration: TextDecoration.underline,
                              fontSize: 18),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignScreen()),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
