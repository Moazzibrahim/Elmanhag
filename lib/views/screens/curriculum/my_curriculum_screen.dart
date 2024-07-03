
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/sections_services.dart';
import 'package:flutter_application_1/controller/subjects_services.dart';
import 'package:flutter_application_1/views/screens/curriculum/sections_screen.dart';
import 'package:provider/provider.dart';

class MyCurriculumScreen extends StatelessWidget {
  const MyCurriculumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    icon: Container(
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: const Color.fromARGB(255, 213, 213, 213),
                      ),
                      child: const Icon(Icons.arrow_back_ios,color: redcolor,))),
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
            Consumer<SubjectProvider>(
              builder: (context, subjectProvider, _) {
                final subjects = subjectProvider.allSubjects;
                if (subjectProvider.allSubjects.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: redcolor,
                    ),
                  );
                } else {
                  return Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 20,
                              ),
                              itemCount:subjects.length ,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Provider.of<SectionsProvider>(context,listen: false).getSections(context, subjects[index].id);
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (ctx)=> SectionsScreen(id: subjects[index].id))
                            );
                          },
                          child: Card(
                                  color: Colors.white,
                                  elevation: 3,
                                  shadowColor: redcolor,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(subjects[index].name,style:const TextStyle(color: redcolor,fontSize: 20) ,),
                                      const SizedBox(height: 7,),
                                      // Image.asset(images[index]),
                                    ],
                                  ),
                                ),
                        );
                      },
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
