// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/Auth/country_provider.dart';
import 'package:flutter_application_1/controller/Auth/login_provider.dart';
import 'package:flutter_application_1/models/curriculums_model.dart';
import 'package:flutter_application_1/models/sign_up_model.dart';
import 'package:flutter_application_1/views/screens/curriculum/allcurriculum/all_curricilms_screen.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class FilterCurriculumsScreen extends StatefulWidget {
  const FilterCurriculumsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FilterCurriculumsScreenState createState() =>
      _FilterCurriculumsScreenState();
}

class _FilterCurriculumsScreenState extends State<FilterCurriculumsScreen> {
  List<Category> categories = [];
  List<Education> educations = [];

  String? selectedCategoryId;
  String? selectedCategoryName;

  String? selectedEducationId;
  String? selectedEducationName;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final dataProvider = Provider.of<DataProvider>(context, listen: false);
    setState(() {
      isLoading = true;
    });

    try {
      await dataProvider.fetchData(context);
      setState(() {
        categories = dataProvider.dataModel?.categories ?? [];
        educations = dataProvider.dataModel?.educations ?? [];
      });
    } catch (e) {
      print('Error loading data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading data: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _filterData() async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;

    try {
      if (selectedCategoryId != null && selectedEducationId != null) {
        final response = await http.post(
          Uri.parse('https://bdev.elmanhag.shop/student/setting/subject/view'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            'category_id': selectedCategoryId!,
            'education_id': selectedEducationId!,
          }),
        );
        print(selectedEducationId);
        print(selectedCategoryId);
 
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body);
          if (jsonResponse is Map<String, dynamic>) {
            final subjectResponse = SubjectResponse.fromJson(jsonResponse);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    AllCurriculumsScreen(subjects: subjectResponse.subjects),
              ),
            );
          } else {
            throw Exception('Unexpected response format');
          }
        } else if (response.statusCode == 403) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('ستتوفر التجربة التحديث القادم')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${response.statusCode}')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Please select both category and education')),
        );
      }
    } catch (e) {
      print('An error occurred: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: redcolor),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                    const Text(
                      'كل المواد',
                      style: TextStyle(
                        color: redcolor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(
                      flex: 3,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Spacer(),
                            DropdownButtonFormField<String>(
                              value: selectedEducationId,
                              items: educations.map((Education education) {
                                return DropdownMenuItem<String>(
                                  value: education.id.toString(),
                                  child:
                                      Text(truncateString(education.name, 20)),
                                );
                              }).toList(),
                              decoration: InputDecoration(
                                labelText: 'Education',
                                prefixIcon:
                                    const Icon(Icons.school, color: redcolor),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: redcolor),
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: redcolor),
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedEducationId = newValue;
                                  selectedEducationName = educations
                                      .firstWhere((education) =>
                                          education.id.toString() == newValue)
                                      .name;
                                });
                              },
                              validator: (value) => value == null
                                  ? 'Please select an education'
                                  : null,
                            ),
                            const SizedBox(height: 20),
                            DropdownButtonFormField<String>(
                              value: selectedCategoryId,
                              items: categories.map((Category category) {
                                return DropdownMenuItem<String>(
                                  value: category.id.toString(),
                                  child:
                                      Text(truncateString(category.name, 20)),
                                );
                              }).toList(),
                              decoration: InputDecoration(
                                labelText: 'Category',
                                prefixIcon:
                                    const Icon(Icons.category, color: redcolor),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: redcolor),
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: redcolor),
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedCategoryId = newValue;
                                  selectedCategoryName = categories
                                      .firstWhere((category) =>
                                          category.id.toString() == newValue)
                                      .name;
                                });
                              },
                              validator: (value) => value == null
                                  ? 'Please select a category'
                                  : null,
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: _filterData,
                              // ignore: sort_child_properties_last
                              child: const Text(
                                'اختيار',
                                style: TextStyle(fontSize: 20),
                              ),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: redcolor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                              ),
                            ),
                            const Spacer()
                          ],
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

String truncateString(String text, int length) {
  return text.length > length ? '${text.substring(0, length)}...' : text;
}
