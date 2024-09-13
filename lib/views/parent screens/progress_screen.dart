import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/chapters_provider.dart';
import 'package:flutter_application_1/controller/subjects_services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class StudentProgressScreen extends StatelessWidget {
  const StudentProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text('تقدم الطالب',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: redcolor,
        elevation: 0,
        leading: InkWell(
          child: const Icon(
            Icons.arrow_back,
            color: redcolor,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: isDarkMode
                ? Image.asset(
                    'assets/images/Ellipse 198.png',
                    fit: BoxFit.cover,
                  )
                : Container(
                    color: Colors.white,
                  ),
          ),
          Positioned(
            top: 5.h,
            left: 12.w,
            right: 12.w,
            child: _buildProgressBar(55), // Add your progress bar here
          ),
          // const SizedBox(
          //   height: 28,
          // ),
          FutureBuilder(
            future: Provider.of<SubjectProvider>(context, listen: false)
                .getSubjects(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: redcolor,
                  ),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    'Failed to load subjects',
                    style: TextStyle(color: redcolor),
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 25),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     IconButton(
                      //       onPressed: () {
                      //         Navigator.pop(context);
                      //       },
                      //       icon: Container(
                      //         margin: const EdgeInsets.all(5),
                      //         padding: const EdgeInsets.all(9),
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(14),
                      //         ),
                      //         child: const Icon(Icons.arrow_back_ios,
                      //             color: redcolor),
                      //       ),
                      //     ),
                      //     const Spacer(
                      //       flex: 2,
                      //     ),
                      //     const Text(
                      //       'موادي',
                      //       style: TextStyle(
                      //         color: redcolor,
                      //         fontSize: 25,
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //     ),
                      //     const Spacer(
                      //       flex: 3,
                      //     )
                      //   ],
                      // ),
                      Expanded(
                        child: Consumer<SubjectProvider>(
                          builder: (context, subjectProvider, _) {
                            final subjects = subjectProvider.allSubjects;
                            if (subjects.isEmpty) {
                              return const Center(
                                child: Text(
                                  'No subjects available',
                                  style: TextStyle(color: redcolor),
                                ),
                              );
                            } else {
                              return GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 20,
                                  crossAxisSpacing: 20,
                                ),
                                itemCount: subjects.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () async {
                                      // Send the selected subject's ID to postSubjectData
                                      await postSubjectData(
                                          subjects[index].id.toString(),
                                          context);
                                    },
                                    child: Card(
                                      color: theme.scaffoldBackgroundColor,
                                      elevation: 3,
                                      shadowColor: redcolor,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            subjects[index].name,
                                            style: const TextStyle(
                                                color: redcolor,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 7),
                                          // ignore: unnecessary_null_comparison
                                          subjects[index].coverPhotoUrl !=
                                                      null &&
                                                  subjects[index]
                                                      .coverPhotoUrl!
                                                      .isNotEmpty
                                              ? Image.network(
                                                  subjects[index]
                                                      .coverPhotoUrl!,
                                                  height: 50,
                                                  width: 50,
                                                )
                                              : const Icon(
                                                  Icons.image_not_supported,
                                                  size: 50,
                                                )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
      //       SizedBox(height: 16.h),

      //       // Grid of Subjects
      //       Expanded(
      //         child: GridView.count(
      //           crossAxisCount: 2,
      //           childAspectRatio: 1.1,
      //           crossAxisSpacing: 10.w,
      //           mainAxisSpacing: 10.h,
      //           children: [
      //             subjectTile(
      //                 'عربي',
      //                 const Image(image: AssetImage("assets/images/2.png")),
      //                 redcolor),
      //             subjectTile(
      //                 'الرياضيات',
      //                 const Image(image: AssetImage("assets/images/1.png")),
      //                 redcolor),
      //             subjectTile(
      //                 'دراسات',
      //                 const Image(image: AssetImage("assets/images/3.png")),
      //                 redcolor),
      //             subjectTile(
      //                 'علوم',
      //                 const Image(image: AssetImage("assets/images/4.png")),
      //                 redcolor),
      //             subjectTile(
      //                 'اللغه الفرنسيه',
      //                 const Image(image: AssetImage("assets/images/5.png")),
      //                 redcolor),
      //             subjectTile(
      //                 'اللغه الانجليزيه',
      //                 const Image(image: AssetImage("assets/images/6.png")),
      //                 redcolor),
      //             subjectTile(
      //                 'التكنولوجيا',
      //                 const Image(image: AssetImage("assets/images/7.png")),
      //                 redcolor),
      //             subjectTile(
      //                 'المهارات',
      //                 const Image(image: AssetImage("assets/images/8.png")),
      //                 redcolor),
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  // Function to build each subject tile
  Widget subjectTile(String title, Image image, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          image,
          SizedBox(height: 10.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: redcolor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar(double progress) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15.r),
          child: LinearProgressIndicator(
            value: progress / 100,
            minHeight: 20.h,
            backgroundColor: Colors.grey[300],
            valueColor: const AlwaysStoppedAnimation<Color>(redcolor),
          ),
        ),
        Positioned.fill(
          child: Center(
            child: Text(
              '${progress.toInt()}%',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
