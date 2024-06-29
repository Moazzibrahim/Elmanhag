import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/widgets/curriculum_grid.dart';

class CurriculumsScreen extends StatelessWidget {
  const CurriculumsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding:  EdgeInsets.all(12.0),
        child: Column(
          children:  [
            SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('اهلا بك يوسف',style: TextStyle(color: redcolor,fontSize: 20,fontWeight: FontWeight.bold),),
                SizedBox(width: 10,),
                CircleAvatar(),
              ],
            ),
            Expanded(child: CurriculumGrid()),
          ],
        ),
      ),
    );
  }
}