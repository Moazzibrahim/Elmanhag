import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';

class CurriculumGrid extends StatelessWidget {
  const CurriculumGrid({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> texts = ['رياضيات','عربي','دراسات','علوم','اللغة الفرنسية','اللغة الانجليزية','التكنولوجيا','المهارات'];
    List<String> images = ['assets/images/1.png','assets/images/2.png','assets/images/3.png','assets/images/4.png','assets/images/5.png','assets/images/6.png','assets/images/7.png','assets/images/8.png'];
    return  GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        ),
      itemCount: texts.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: (){},
          child: Card(
            color: Colors.white,
            elevation: 3,
            shadowColor: redcolor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(texts[index],style:const TextStyle(color: redcolor,fontSize: 20) ,),
                const SizedBox(height: 7,),
                Image.asset(images[index]),
              ],
            ),
          ),
        );
      },
    );
  }
}