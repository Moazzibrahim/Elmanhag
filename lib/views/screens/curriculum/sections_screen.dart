import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/sections_services.dart';
import 'package:flutter_application_1/views/screens/curriculum/video_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SectionsScreen extends StatelessWidget {
  const SectionsScreen({super.key, required this.id});
  final int id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الوحدات'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<SectionsProvider>(
          builder: (context,sectionProvider, _) {
            final sections = sectionProvider.allSections;
            if(sections.isEmpty){
              return const Center(child: CircularProgressIndicator(color: redcolor,),);
            }else{
              return ListView.builder(
                itemCount: sections.length,
                itemBuilder: (context, index) {
                  final lessons = sectionProvider.allLessons.where((element) => element.sectionId == sections[index].id,).toList();
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10.h),
                    child: ExpansionTile(
                      childrenPadding: const EdgeInsets.all(5),
                      tilePadding: const EdgeInsets.all(6),
                      title: Row(
            children: [
              Icon(
                Icons.video_collection_rounded,
                color: redcolor,
                size: 24.w,
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: Text(
                  sections[index].name,
                  style: TextStyle(fontSize: 16.sp,color: redcolor),
                ),
              ),
            ],
          ),
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          children: [
            Column(
              children: [
                for(var e in lessons)
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx)=> const LessonsVideos())
                      );
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.circle,size: 10,color: redcolor,),
                        const SizedBox(width: 5,),
                        Text(e.name,style: const TextStyle(color: redcolor),),
                      ],
                    ),
                  ),
              ],
            )
          ],
                      ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}