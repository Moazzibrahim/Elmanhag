import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/Auth/sign_up_provider.dart';
import 'package:flutter_application_1/views/widgets/progress_widget.dart';
import 'package:flutter_application_1/views/widgets/text_field.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/Auth/country_provider.dart';
import 'package:flutter_application_1/models/sign_up_model.dart';

class SecondSignScreen extends StatefulWidget {
  final String name;
  final String email;
  final String phone;
  final String parentName;
  final String parentPhone;
  final String parentEmail;
  final String gender;

  const SecondSignScreen({
    super.key,
    required this.email,
    required this.name,
    required this.phone,
    required this.parentName,
    required this.parentPhone,
    required this.parentEmail,
    required this.gender,
  });

  @override
  _SecondSignScreenState createState() => _SecondSignScreenState();
}

class _SecondSignScreenState extends State<SecondSignScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _codecontroller = TextEditingController();
  String? selectedCountryId;
  String? selectedCityId;
  String? selectedCategoryId;
  String? selectedEducationId;

  String? selectedCountryName;
  String? selectedCityName;
  String? selectedCategoryName;
  String? selectedEducationName;
  String? selectedJobId;
  String? selectedJobName;

  List<Country> countries = [];
  List<City> cities = [];
  List<Category> categories = [];
  List<Education> educations = [];
  List<StudentJob> studentJobs = [];

  final List<String> genderOptions = ['male', 'female'];

  @override
  void initState() {
    super.initState();
    final dataProvider = Provider.of<DataProvider>(context, listen: false);
    dataProvider.fetchData(context).then((_) {
      setState(() {
        countries = dataProvider.dataModel?.countries ?? [];
        cities = dataProvider.dataModel?.cities ?? [];
        categories = dataProvider.dataModel?.categories ?? [];
        educations = dataProvider.dataModel?.educations ?? [];
        studentJobs = dataProvider.dataModel?.studentJobs ?? [];
      });
    });
    final savedData = Provider.of<ApiService>(context, listen: false);
    log('${savedData.previousCountry}');
    if (savedData.previousCategory != null) {
      selectedCategoryName = savedData.previousCategory;
    }
    if (savedData.previousCity != null) {
      selectedCityName = savedData.previousCity;
    }
    if (savedData.previousCountry != null) {
      setState(() {
        selectedCountryName = savedData.previousCountry;
      });
    }
    if (savedData.previousEdu != null) {
      selectedEducationName = savedData.previousEdu;
    }

    if (savedData.previousjob != null) {
      selectedJobName = savedData.previousjob;
    }
  }

  String truncateString(String text, int length) {
    return text.length > length ? '${text.substring(0, length)}...' : text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'انشاء حساب',
          style: TextStyle(fontWeight: FontWeight.bold, color: redcolor),
        ),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: redcolor),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProgressCircles(currentScreen: 2),
            const SizedBox(height: 15),
            const Text(
              'أهلا بك معنا',
              style: TextStyle(
                fontSize: 24,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedCountryId,
                    items: countries.map((Country country) {
                      return DropdownMenuItem<String>(
                        value: country.id.toString(),
                        child: Text(truncateString(country.name, 30)),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: 'البلد',
                      prefixIcon: const Icon(Icons.public, color: redcolor),
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
                        selectedCountryId = newValue;
                        selectedCountryName = countries
                            .firstWhere(
                                (country) => country.id.toString() == newValue)
                            .name;
                        final dataProvider = context.read<DataProvider>();
                        cities = dataProvider.dataModel?.cities
                                .where((city) =>
                                    city.countryId.toString() ==
                                    selectedCountryId)
                                .toList() ??
                            [];
                        selectedCityId = null;
                      });
                    },
                    validator: (value) =>
                        value == null ? 'Please select a country' : null,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedCityId,
                    items: cities.map((City city) {
                      return DropdownMenuItem<String>(
                        value: city.id.toString(),
                        child: Text(truncateString(city.name, 20)),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: 'المدينة',
                      prefixIcon:
                          const Icon(Icons.location_city, color: redcolor),
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
                        selectedCityId = newValue;
                        selectedCityName = cities
                            .firstWhere(
                                (city) => city.id.toString() == newValue)
                            .name;
                      });
                    },
                    validator: (value) =>
                        value == null ? 'Please select a city' : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField<String>(
              value: selectedCategoryId,
              items: categories.map((Category category) {
                return DropdownMenuItem<String>(
                  value: category.id.toString(),
                  child: Text(truncateString(category.name, 20)),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'السنة الدراسية',
                prefixIcon: const Icon(Icons.school, color: redcolor),
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
                      .firstWhere(
                          (category) => category.id.toString() == newValue)
                      .name;
                });
              },
              validator: (value) =>
                  value == null ? 'Please select a category' : null,
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField<String>(
              value: selectedEducationId,
              items: educations.map((Education education) {
                return DropdownMenuItem<String>(
                  value: education.id.toString(),
                  child: Text(truncateString(education.name, 20)),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'التعليم',
                prefixIcon: const Icon(Icons.school, color: redcolor),
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
                      .firstWhere(
                          (education) => education.id.toString() == newValue)
                      .name;
                });
              },
              validator: (value) =>
                  value == null ? 'Please select an education' : null,
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField<String>(
              value: selectedJobId,
              items: studentJobs.map((StudentJob job) {
                return DropdownMenuItem<String>(
                  value: job.id.toString(),
                  child: Text(truncateString(job.job, 30)),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'نفسك تطلع اي',
                prefixIcon: const Icon(Icons.work, color: redcolor),
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
                  selectedJobId = newValue;
                  selectedJobName = studentJobs
                      .firstWhere((job) => job.id.toString() == newValue)
                      .job;
                });
              },
              validator: (value) =>
                  value == null ? 'Please select a job' : null,
            ),
            const SizedBox(
              height: 10,
            ),
            PasswordField(
                controller: _passwordController, labelText: 'الرقم السري'),
            const SizedBox(
              height: 10,
            ),
            PasswordField(
                controller: _confirmPasswordController,
                labelText: 'تاكيد الرقم السري'),
            const SizedBox(
              height: 10,
            ),
            buildTextField(
                controller: _codecontroller, labelText: 'كود التسويق'),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: redcolor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      textStyle: const TextStyle(fontSize: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('رجوع',
                        style: TextStyle(color: Colors.white)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      print('Name: ${widget.name}');
                      print('Name: ${widget.gender}');

                      print('Email: ${widget.email}');
                      print('Password: ${_passwordController.text}');
                      print(
                          'Confirm Password: ${_confirmPasswordController.text}');
                      print('Phone: ${widget.phone}');
                      print('Country ID: $selectedCountryId');
                      print('City ID: $selectedCityId');
                      print('Category ID: $selectedCategoryId');
                      print('Education ID: $selectedEducationId');
                      print('Parent Name: ${widget.parentName}');
                      print('Parent Email: ${widget.parentEmail}');
                      print('Parent Password: ${_passwordController.text}');
                      print('Parent Phone: ${widget.parentPhone}');
                      print('Parent Relation ID: 1');
                      print('Job ID: ${selectedJobId.toString()}');
                      print('Affiliate Code: ${_codecontroller.text}');
                      ApiService.signUp(
                          name: widget.name,
                          email: widget.email,
                          password: _passwordController.text,
                          confpassword: _confirmPasswordController.text,
                          phone: widget.phone,
                          selectedCountryId: selectedCountryId,
                          selectedCityId: selectedCityId,
                          selectedCategoryId: selectedCategoryId,
                          selectedEducationId: selectedEducationId,
                          parentname: widget.parentName,
                          parentemail: widget.parentEmail,
                          parentpassword: _passwordController.text,
                          parentphone: widget.parentPhone,
                          selectedparentrealtionId: '1',
                          jobId: selectedJobId.toString(),
                          affilateCode: _codecontroller.text,
                          context: context,
                          gender: widget.gender);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: redcolor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      textStyle: const TextStyle(fontSize: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'تسجيل',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
