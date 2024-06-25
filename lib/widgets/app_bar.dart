import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';

AppBar buildAppBar(){
  return AppBar(
      backgroundColor: redcolor,
      title: const Text('اهلا بك محمد',style: TextStyle(color: redcolor),),
    );
}