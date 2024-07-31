// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/Auth/login_provider.dart';
import 'package:flutter_application_1/localization/app_localizations.dart';
import 'package:flutter_application_1/views/screens/forget_password/forget_password.dart';
import 'package:flutter_application_1/views/screens/home_screen.dart';
import 'package:flutter_application_1/views/screens/login/sign_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscured = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 50),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  localizations.translate('title'), // Localized title
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 32,
                    color: redcolor,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                localizations.translate('welcome'),
                style: const TextStyle(
                  fontSize: 32,
                  color: greycolor,
                ),
              ),
              const SizedBox(height: 20),
              if (_errorMessage != null)
                Center(
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: redcolor, fontSize: 16),
                  ),
                ),
              const SizedBox(height: 10),
              TextField(
                controller: _emailController,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  labelText: localizations.translate('email'),
                  hintText: localizations.translate('email'),
                  labelStyle: const TextStyle(color: greycolor),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: redcolor),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _passwordController,
                textAlign: TextAlign.right,
                obscureText: _isObscured,
                decoration: InputDecoration(
                  labelText: localizations.translate('password'),
                  hintText: localizations.translate('password'),
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
                  child: Text(
                    localizations.translate('forgot_password'),
                    style: const TextStyle(
                      color: redcolor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ForgetPasswordScreen(),
                    ));
                  },
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    String email = _emailController.text;
                    String password = _passwordController.text;
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );

                    if (email.isEmpty || password.isEmpty) {
                      setState(() {
                        _errorMessage =
                            localizations.translate('error_empty_fields');
                      });
                    } else {
                      String response =
                          await Provider.of<LoginModel>(context, listen: false)
                              .loginUser(context, email, password);

                      if (response == 'Authentication failed') {
                        setState(() {
                          _errorMessage =
                              localizations.translate('error_auth_failed');
                        });
                      } else {
                        setState(() {
                          _errorMessage = null;
                        });

                        // Navigate to home screen upon successful login
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: redcolor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 100,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    localizations.translate('login'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: <Widget>[
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Divider(
                        color: greycolor,
                        height: 50,
                      ),
                    ),
                  ),
                  Text(localizations.translate('or')), // Localized "or"
                  const Expanded(
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
                    icon: const FaIcon(
                      FontAwesomeIcons.facebook,
                      color: redcolor,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.instagram,
                      color: redcolor,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.xTwitter,
                      color: redcolor,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: localizations.translate('no_account'),
                        style: const TextStyle(color: greycolor, fontSize: 18),
                      ),
                      TextSpan(
                        text: localizations.translate('create_account'),
                        style: const TextStyle(
                          color: redcolor,
                          decoration: TextDecoration.underline,
                          fontSize: 18,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignScreen(),
                              ),
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
    );
  }
}
