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
  String? selectedGender;
  String? selectedCareer;

  List<Country> countries = [];
  List<City> cities = [];
  List<Category> categories = [];
  List<Education> educations = [];

  final List<String> genderOptions = ['ذكر', 'أنثى'];
  final List<String> careerOptions = [
    'مستشار',
    'طيار',
    'ظابط',
    'مدرس',
    'دكتور',
    'مهندس'
  ];

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

  String truncateString(String text, int length) {
    return text.length > length ? '${text.substring(0, length)}...' : text;
  }

  void signUp() {
    if (selectedCountryId != null &&
        selectedCityId != null &&
        selectedCategoryId != null &&
        selectedEducationId != null) {
      String phoneToPass = _studentPhoneController.text.isNotEmpty
          ? _studentPhoneController.text
          : widget.phone;

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ThirdSignUp(
            name: widget.name,
            email: widget.email,
            password: widget.password,
            confpassword: widget.confpassword,
            phone: phoneToPass,
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
                  // Access the provider here
                  final dataProvider = context.read<DataProvider>();
                  // Filter cities based on selected country
                  cities = dataProvider.dataModel?.cities
                          .where((city) =>
                              city.countryId.toString() == selectedCountryId)
                          .toList() ??
                      [];
                  selectedCityId = null; // Reset selected city
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
                  child: Text(truncateString(city.name, 20)),
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
            // New gender dropdown
            DropdownButtonFormField<String>(
              value: selectedGender,
              items: genderOptions.map((String gender) {
                return DropdownMenuItem<String>(
                  value: gender,
                  child: Text(gender),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'الجنس',
                prefixIcon: const Icon(Icons.person, color: redcolor),
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
                  selectedGender = newValue;
                });
              },
              validator: (value) =>
                  value == null ? 'Please select a gender' : null,
            ),
            const SizedBox(height: 15),
            // New career dropdown
            DropdownButtonFormField<String>(
              value: selectedCareer,
              items: careerOptions.map((String career) {
                return DropdownMenuItem<String>(
                  value: career,
                  child: Text(career),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'نفسك تبقي ايه لما تكبر',
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
                  selectedCareer = newValue;
                });
              },
              validator: (value) =>
                  value == null ? 'Please select a career' : null,
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
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
                    child: const Text('رجوع',
                        style: TextStyle(color: Colors.white)),
                  ),
                  ElevatedButton(
                    onPressed: signUp,
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
                      'التالي',
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
