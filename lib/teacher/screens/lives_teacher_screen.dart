import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/models/sessions_model.dart';
import 'package:flutter_application_1/teacher/widgets/lives_teacher_card.dart';

class LivesTeacherScreen extends StatelessWidget {
  const LivesTeacherScreen({super.key, required this.title, required this.lives, required this.image});
  final String title;
  final List<Live> lives;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title,style: const TextStyle(color: redcolor,fontSize: 20),),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back_ios,color: redcolor,)),
      ),
      body: Column(
        children: [
          // Calendar Row (days and dates)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('الجمعة', style: TextStyle(color: Colors.black)),
                Text('الخميس', style: TextStyle(color: Colors.black)),
                Text('الاربعاء', style: TextStyle(color: Colors.black)),
                Text('الثلاثاء', style: TextStyle(color: Colors.black)),
                Text('الاثنين', style: TextStyle(color: Colors.black)),
                Text('الاحد', style: TextStyle(color: Colors.black)),
                Text('السبت', style: TextStyle(color: Colors.black)),
              ],
            ),
          ),
          const Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('31', style: TextStyle(color: Colors.black)),
                Text('1', style: TextStyle(color: Colors.black)),
                Text('2', style: TextStyle(color: Colors.black)),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: redcolor,
                  child: Text(
                    '3',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Text('4', style: TextStyle(color: Colors.black)),
                Text('5', style: TextStyle(color: Colors.black)),
                Text('6', style: TextStyle(color: Colors.black)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: lives.length, 
              itemBuilder: (context, index) {
                return LivesTeacherCard(live: lives[index],image: image,);
              },
            ),
          ),
        ],
      ),
    );
  }
}