import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/localization/app_localizations.dart';
import 'package:flutter_application_1/views/screens/OTP/otp_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}
class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          localizations.translate('title'), // Localized title
          style: const TextStyle(color: redcolor),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
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
                    text: localizations.translate(
                        'forgot_password_title'), // Localized forgot password title
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
                    text: localizations.translate(
                        'forgot_password_instruction'), // Localized instruction
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: const Color.fromRGBO(139, 139, 139, 1),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 10.sp),
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelStyle: const TextStyle(color: redcolor),
                    labelText: localizations.translate(
                        'email_or_phone'), // Localized email or phone
                  ),
                ),
                SizedBox(height: 25.sp),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const OtpScreen()));
                    },
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
                      localizations.translate('continue'), // Localized continue
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
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
