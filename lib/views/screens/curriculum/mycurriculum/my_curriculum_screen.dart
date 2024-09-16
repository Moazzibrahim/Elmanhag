import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/chapters_provider.dart';
import 'package:flutter_application_1/controller/subjects_services.dart';
import 'package:provider/provider.dart';

class MyCurriculumScreen extends StatelessWidget {
  const MyCurriculumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
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
                              ),
                              child: const Icon(Icons.arrow_back_ios,
                                  color: redcolor),
                            ),
                          ),
                          const Spacer(
                            flex: 2,
                          ),
                          const Text(
                            'موادي',
                            style: TextStyle(
                              color: redcolor,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(
                            flex: 3,
                          )
                        ],
                      ),
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
                                    onTap: () {
                                      postSubjectData(
                                          subjects[index].id.toString(),
                                          subjects[index].coverPhotoUrl ??
                                              '', 
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
    );
  }
}
