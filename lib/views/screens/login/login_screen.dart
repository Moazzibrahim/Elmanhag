// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, unused_field
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/Auth/login_provider.dart';
import 'package:flutter_application_1/localization/app_localizations.dart';
import 'package:flutter_application_1/views/screens/forget_password/forget_password.dart';
import 'package:flutter_application_1/views/screens/login/sign_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

// Define RotatingImageIndicator widget
class RotatingImageIndicator extends StatefulWidget {
  const RotatingImageIndicator({super.key});

  @override
  _RotatingImageIndicatorState createState() => _RotatingImageIndicatorState();
}

class _RotatingImageIndicatorState extends State<RotatingImageIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2.0 * 3.14,
          child: child,
        );
      },
      child: Image.asset(
        'assets/images/amin2.png', // Path to your image
        height: 50, // Adjust the height as needed
        width: 50, // Adjust the width as needed
      ),
    );
  }
}

// LoginScreen class
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscured = true;
  bool _isLoading = false; // Track if the login process is ongoing
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
                child: _isLoading
                    ? const RotatingImageIndicator() // Show loading indicator
                    : ElevatedButton(
                        onPressed: () async {
                          String email = _emailController.text;
                          String password = _passwordController.text;

                          if (email.isEmpty || password.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("يجب مليء جميع البيانات")),
                            );
                          } else {
                            setState(() {
                              _isLoading = true;
                              _errorMessage = null;
                            });

                            String response = await Provider.of<LoginModel>(
                                    context,
                                    listen: false)
                                .loginUser(context, email, password);

                            setState(() {
                              _isLoading = false;
                            });

                            if (response == 'successful login') {
                              // Handle successful login
                            } else {
                              setState(() {
                                _errorMessage =
                                    response; // Show the error under the text fields
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(response)),
                              );
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
