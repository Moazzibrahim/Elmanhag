import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/views/screens/OTP/confirm_password.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  final String? user;
  const OtpScreen({super.key, this.user});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  int _countdown = 180; // 3 minutes in seconds
  late Timer _timer;
  String _pin = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        setState(() {
          if (_countdown < 1) {
            timer.cancel();
            // Add your logic when the countdown reaches 0
          } else {
            _countdown--;
          }
        });
      },
    );
  }

  String get timerText {
    int minutes = _countdown ~/ 60;
    int seconds = _countdown % 60;
    String minutesStr = (minutes < 10) ? '0$minutes' : '$minutes';
    String secondsStr = (seconds < 10) ? '0$seconds' : '$seconds';
    return '$minutesStr:$secondsStr';
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56.w,
      height: 60.h,
      textStyle: TextStyle(
        fontSize: 22.sp,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 214, 212, 212),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.transparent),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "المنهج",
          style: TextStyle(color: redcolor),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Container(
          margin: EdgeInsets.only(top: 40.h),
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Text(
                  "التحقق من OTP",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "أدخل كلمة مرور OTP المرسلة - ",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18.sp,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Pinput(
                  length: 6,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      border: Border.all(color: Colors.red),
                    ),
                  ),
                  onCompleted: (pin) => setState(() {
                    _pin = pin;
                  }),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Text(
                  " $timerText",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18.sp,
                  ),
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'لم تتلقي الرمز ؟',
                  style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400),
                  children: const <TextSpan>[
                    TextSpan(
                      text: 'اعادة ارسال',
                      style: TextStyle(
                        color: redcolor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ConfirmPassword()));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: redcolor,
                    padding: EdgeInsets.symmetric(
                      vertical: 12.h,
                      horizontal: 130.w,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r))),
                child: Text(
                  maxLines: 1,
                  'ارسال',
                  style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
