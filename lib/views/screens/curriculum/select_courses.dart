import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/views/screens/curriculum/curriculums_screen.dart';
import 'package:flutter_application_1/views/screens/curriculum/my_curriculum_screen.dart';

class SelectCourse extends StatelessWidget {
  const SelectCourse({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المناهج',style: TextStyle(color: redcolor),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            const Spacer(
              flex: 1,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx)=> const MyCurriculumScreen())
                );
              },
              child:  SizedBox(
                height: 200,
                width: double.infinity,
                child: Padding(
                  padding:  const EdgeInsets.all(8.0),
                  child:  Card(
                    elevation: 4,
                    shadowColor: redcolor, 
                    color : Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('موادي',style: TextStyle(color: redcolor,fontSize: 20),),
                          const SizedBox(height: 20,),
                          Image.asset('assets/images/icons8-books-64.png')
                        ],
                      ),
                  )
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const CurriculumsScreen()),
                );
              },
              child:  SizedBox(
                height: 200,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 4,
                    shadowColor: redcolor,
                    color : Colors.white,
                      child: Column(
                        children: [
                          const Text('جميع المواد',style: TextStyle(color: redcolor,fontSize: 20),),
                          const SizedBox(height: 20,),
                          Image.asset('assets/images/icons8-books-64.png')
                        ],
                      ),
                  )
                ),
              ),
            ),
            const Spacer(
              flex: 2,
            ), 
          ],
        ),
      ),
    );
  }
}