// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/parent/get_children_subjects.dart';
import 'package:flutter_application_1/views/parent%20screens/progress_history.dart';
import 'package:provider/provider.dart';

class StudentAllSubjectsProgressScreen extends StatelessWidget {
  int? stid;

  StudentAllSubjectsProgressScreen({super.key, this.stid});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    // Fetch child subjects when the screen is built
    Provider.of<GetChildrenSubjects>(context, listen: false)
        .fetchChildrenSubjects(stid ?? 0, context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'تقدم الطالب',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
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
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                _buildProgressBar(
                  Provider.of<GetChildrenSubjects>(context)
                          .subjectResponseChild
                          ?.progress ??
                      0,
                ),
                const SizedBox(
                    height:
                        20), // Add some spacing between the progress bar and the grid
                Expanded(
                  child: Consumer<GetChildrenSubjects>(
                    builder: (context, subjectProvider, _) {
                      if (subjectProvider.subjectResponseChild == null) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: redcolor,
                          ),
                        );
                      } else if (subjectProvider
                          .subjectResponseChild!.subjects.isEmpty) {
                        return const Center(
                          child: Text(
                            'No subjects available',
                            style: TextStyle(color: redcolor),
                          ),
                        );
                      } else {
                        final subjects =
                            subjectProvider.subjectResponseChild!.subjects;
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const StudyProgressScreen()));
                              },
                              child: Card(
                                color: theme.scaffoldBackgroundColor,
                                elevation: 3,
                                shadowColor: redcolor,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      subjects[index].name,
                                      style: const TextStyle(
                                          color: redcolor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 7),
                                    subjects[index].coverPhotoUrl.isNotEmpty
                                        ? Image.network(
                                            subjects[index].coverPhotoUrl,
                                            height: 50,
                                            width: 50,
                                          )
                                        : const Icon(
                                            Icons.image_not_supported,
                                            size: 50,
                                          ),
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
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar(int progress) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: LinearProgressIndicator(
            value: progress / 100,
            minHeight: 20,
            backgroundColor: Colors.grey[300],
            valueColor: const AlwaysStoppedAnimation<Color>(redcolor),
          ),
        ),
        Positioned.fill(
          child: Center(
            child: Text(
              '${progress.toInt()}%',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
