 import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';

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
    return StatefulBuilder(
      builder: (context, setState) {
        bool _passwordVisible = false;
        return TextField(
          controller: controller,
          obscureText: !_passwordVisible,
          decoration: InputDecoration(
            labelText: labelText,
            prefixIcon: const Icon(Icons.lock, color: redcolor),
            suffixIcon: IconButton(
              icon: Icon(
                // ignore: dead_code
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