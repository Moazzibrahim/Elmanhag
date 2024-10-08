import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/Auth/login_provider.dart';
import 'package:flutter_application_1/models/curriculums_model.dart';
import 'package:flutter_application_1/models/lessons_model.dart';
import 'package:flutter_application_1/views/screens/curriculum/allcurriculum/all_chapters_screen.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AllCurriculumsScreen extends StatelessWidget {
  final List<Subject> subjects;

  const AllCurriculumsScreen({super.key, required this.subjects});
  Future<void> fetchAndNavigate(BuildContext context, Subject subject) async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;

    final url =
        Uri.parse('https://bdev.elmanhag.shop/affilate/subject/chapter/view');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'subject_id': subject.id}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final List<Chapter> chapters = (responseData['chapter'] as List)
            .map((chapterJson) => Chapter.fromJson(chapterJson))
            .toList();

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChaptersScreen(
              chapters: chapters,
              coverPhotoUrl: subject.coverPhotoUrl, // Pass the coverPhotoUrl
            ),
          ),
        );
      } else {
        print('Failed to load chapters. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }

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
          Padding(
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
                        child:
                            const Icon(Icons.arrow_back_ios, color: redcolor),
                      ),
                    ),
                    const Spacer(flex: 2),
                    const Text(
                      'كل المناهج',
                      style: TextStyle(
                        color: redcolor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(flex: 3),
                  ],
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                    ),
                    itemCount: subjects.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => fetchAndNavigate(context, subjects[index]),
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
                              // ignore: unnecessary_null_comparison
                              subjects[index].coverPhotoUrl != null &&
                                      subjects[index].coverPhotoUrl!.isNotEmpty
                                  ? Image.network(
                                      subjects[index].coverPhotoUrl!,
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
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
