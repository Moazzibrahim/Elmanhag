import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/widgets/progress_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/Auth/country_provider.dart';
import 'package:flutter_application_1/models/sign_up_model.dart';
import 'package:flutter_application_1/views/screens/login/third_sign_screen.dart';

class SecondSignScreen extends StatefulWidget {
  final String name;
  final String email;
  final String password;
  final String confpassword;
  final String phone;

  const SecondSignScreen({
    super.key,
    required this.email,
    required this.password,
    required this.confpassword,
    required this.name,
    required this.phone,
  });

  @override
  // ignore: library_private_types_in_public_api
  _SecondSignScreenState createState() => _SecondSignScreenState();
}

class _SecondSignScreenState extends State<SecondSignScreen> {
  final TextEditingController _studentPhoneController = TextEditingController();

  String? selectedCountryId;
  String? selectedCityId;
  String? selectedCategoryId;
  String? selectedEducationId;

  String? selectedCountryName;
  String? selectedCityName;
  String? selectedCategoryName;
  String? selectedEducationName;

  List<Country> countries = [];
  List<City> cities = [];
  List<Category> categories = [];
  List<Education> educations = [];

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
      });
    });
  }

  void signUp() {
    if (selectedCountryId != null &&
        selectedCityId != null &&
        selectedCategoryId != null &&
        selectedEducationId != null) {
      // Ensure the phone number is assigned correctly
      String phoneToPass = _studentPhoneController.text.isNotEmpty
          ? _studentPhoneController.text
          : widget.phone;

      log('Phone number in second: $phoneToPass');

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ThirdSignUp(
            name: widget.name,
            email: widget.email,
            password: widget.password,
            confpassword: widget.confpassword,
            phone: phoneToPass, // Check this value
            countryId: selectedCountryId!,
            cityId: selectedCityId!,
            categoryId: selectedCategoryId!,
            educationId: selectedEducationId!,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يجب ملء جميع البيانات '),
          backgroundColor: redcolor,
        ),
      );
    }
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
            const SizedBox(height: 30),
            DropdownButtonFormField<String>(
              value: selectedCountryId,
              items: countries.map((Country country) {
                return DropdownMenuItem<String>(
                  value: country.id.toString(),
                  child: Text(country.name),
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
                });
              },
              validator: (value) =>
                  value == null ? 'Please select a country' : null,
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField<String>(
              value: selectedCityId,
              items: cities.map((City city) {
                return DropdownMenuItem<String>(
                  value: city.id.toString(),
                  child: Text(city.name),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'المدينة',
                prefixIcon: const Icon(Icons.location_city, color: redcolor),
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
                      .firstWhere((city) => city.id.toString() == newValue)
                      .name;
                });
              },
              validator: (value) =>
                  value == null ? 'Please select a city' : null,
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField<String>(
              value: selectedCategoryId,
              items: categories.map((Category category) {
                return DropdownMenuItem<String>(
                  value: category.id.toString(),
                  child: Text(category.name),
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
                  child: Text(education.name),
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
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  signUp();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: redcolor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'التالي',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Divider(color: Colors.grey),
            const SizedBox(height: 30),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'لديك حساب؟ تسجيل الدخول',
                  style: TextStyle(
                      fontSize: 18,
                      color: redcolor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
