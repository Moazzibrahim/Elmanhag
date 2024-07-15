import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/views/widgets/leading_icon.dart';

class NotficationsParentScreen extends StatelessWidget {
  const NotficationsParentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('الاشعارات',style: TextStyle(color: redcolor),),
        leading: const LeadingIcon(),
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        
      },),
    );
  }
}