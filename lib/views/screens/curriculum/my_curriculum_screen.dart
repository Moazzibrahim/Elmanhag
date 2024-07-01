import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/subjects_services.dart';
import 'package:provider/provider.dart';

class MyCurriculumScreen extends StatelessWidget {
  const MyCurriculumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back)),
                const Row(
                  children: [
                    Text(
                      'اهلا بك يوسف',
                      style: TextStyle(
                          color: redcolor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    CircleAvatar(),
                  ],
                ),
              ],
            ),
            Consumer<SubjectProvider>(builder: (context, subjectProvider, _) {
              if(subjectProvider.allSubjects.isEmpty){
                return const Center(child: CircularProgressIndicator(color: redcolor,),);
              }else{
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for(var e in subjectProvider.allSubjects)
                      Text(e.name),
                  ],
                );
              }
            },)
          ],
        ),
      ),
    );
  }
}