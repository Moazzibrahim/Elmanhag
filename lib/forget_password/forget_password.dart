// ignore_for_file: avoid_print, use_build_context_synchronously, prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _controller = TextEditingController();

  // Future<void> _sendForgetPasswordRequest() async {
  //   // final tokenProvider = Provider.of<TokenModel>(context, listen: false);
  //   // final token = tokenProvider.token;

  //   setState(() {
  //     _isLoading = true;
  //   });

  //   final String user = _controller.text;
  //   const String url = '';
  //   // 'https://login.mathshouse.net/api/forget_password';

  //   try {
  //     final response = await http.post(
  //       Uri.parse(url),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json',
  //         'Accept': 'application/json',
  //       },
  //       body: jsonEncode(<String, String>{
  //         'user': user,
  //       }),
  //     );

  //     if (response.statusCode == 200) {
  //     } else {
  //       final responseJson = jsonDecode(response.body);
  //       final errorMessage =
  //           responseJson['message']?.toString() ?? 'Failed to update password';
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Failed to update password: $errorMessage')),
  //       );
  //     }
  //   } catch (e) {
  //     print('An error occurred: $e');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('An error occurred: $e')),
  //     );
  //   } finally {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "المنهج",
          style: TextStyle(color: redcolor),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(19.w),
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (BuildContext context, Widget? child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: ' هل نسيت كلمة المرور ؟',
                    style: TextStyle(
                      fontSize: 27.sp,
                      fontWeight: FontWeight.w700,
                      color: greycolor,
                    ),
                    children: const <TextSpan>[],
                  ),
                ),
                SizedBox(height: 15.sp),
                RichText(
                  text: TextSpan(
                    text: 'يرجى تسجيل هاتفك أو بريدك الإلكتروني لتسليم OTP ',
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Color.fromRGBO(139, 139, 139, 1),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 10.sp),
                TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(color: redcolor),
                    labelText: 'الايميل او رقم التليفون',
                  ),
                ),
                SizedBox(height: 25.sp),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: redcolor,
                    padding: EdgeInsets.symmetric(
                      vertical: 12.sp,
                      horizontal: 130.sp,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.sp),
                    ),
                  ),
                  child: Text(
                    'اكمل',
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
