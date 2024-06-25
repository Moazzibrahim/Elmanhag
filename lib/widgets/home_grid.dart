import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';

class HomeGrid extends StatelessWidget {
  const HomeGrid({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> texts = ['واجبات','مناهج','مراجعات شهور','حصص لايف','حل امتحانات','مراجعة نهائية'];
    List<String> images = ['assets/images/Frame.png','assets/images/Frame (1).png','assets/images/Frame (2).png','assets/images/ICON.png','assets/images/Layer_1.png','assets/images/Group.png'];
    return GridView.builder(
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