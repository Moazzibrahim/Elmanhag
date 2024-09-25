// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, unused_field, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/Auth/login_provider.dart';
import 'package:flutter_application_1/localization/app_localizations.dart';
import 'package:flutter_application_1/views/screens/forget_password/forget_password.dart';
import 'package:flutter_application_1/views/screens/login/sign_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:provider/provider.dart';

class RotatingImageIndicator extends StatefulWidget {
  final bool clockwise; 

  const RotatingImageIndicator({super.key, this.clockwise = true});

  @override
  _RotatingImageIndicatorState createState() => _RotatingImageIndicatorState();
}

class _RotatingImageIndicatorState extends State<RotatingImageIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(seconds: 2), vsync: this)..repeat();
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
        double angle = widget.clockwise ? _controller.value * 2.0 * 3.14 : -_controller.value * 2.0 * 3.14;
        return Transform.rotate(angle: angle, child: child);
      },
      child: Image.asset(
        'assets/images/amin2.png', // Path to your image
        height: 50,
        width: 50,
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscured = true;
  bool _isLoading = false; 
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
              Center(
                child: Image.asset(
                  'assets/images/amin2.png',
                  height: 220,
                  width: 250,
                ),
              ),
              _buildTextField(
                controller: _emailController,
                label: localizations.translate('email'),
                hint: localizations.translate('email'),
                obscureText: false,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                controller: _passwordController,
                label: localizations.translate('password'),
                hint: localizations.translate('password'),
                obscureText: _isObscured,
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
              const SizedBox(height: 10),
              _buildForgotPasswordText(localizations),
              const SizedBox(height: 30),
              Center(
                child: _isLoading
                    ? const RotatingImageIndicator(clockwise: false)
                    : _buildLoginButton(localizations),
              ),
              const SizedBox(height: 20),
              _buildDividerWithText(localizations),
              const SizedBox(height: 15),
              Center(child: _buildCreateAccountButton(localizations)),
              if (_errorMessage != null) 
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  TextField _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required bool obscureText,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: const TextStyle(color: greycolor),
        hintStyle: const TextStyle(color: greycolor),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: redcolor),
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }

  Align _buildForgotPasswordText(AppLocalizations localizations) {
    return Align(
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
    );
  }

  ElevatedButton _buildLoginButton(AppLocalizations localizations) {
    return ElevatedButton(
      onPressed: () async {
        String email = _emailController.text.trim();
        String password = _passwordController.text.trim();

        if (email.isEmpty || password.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("يجب مليء جميع البيانات")),
          );
          return;
        }

        setState(() {
          _isLoading = true;
          _errorMessage = null;
        });

        var response = await Provider.of<LoginModel>(context, listen: false)
            .loginUser(context, email, password);

        setState(() {
          _isLoading = false;
        });

      },
      style: ElevatedButton.styleFrom(
        backgroundColor: redcolor,
        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
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
    );
  }

  Row _buildDividerWithText(AppLocalizations localizations) {
    return Row(
      children: <Widget>[
        const Expanded(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Divider(color: greycolor, height: 50),
          ),
        ),
        Text(localizations.translate('or')),
        const Expanded(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Divider(color: greycolor, height: 50),
          ),
        ),
      ],
    );
  }

  ElevatedButton _buildCreateAccountButton(AppLocalizations localizations) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SignScreen(),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: redcolor, width: 2.0),
        ),
      ),
      child: Text(
        localizations.translate('create_account'),
        style: const TextStyle(
          color: redcolor,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
