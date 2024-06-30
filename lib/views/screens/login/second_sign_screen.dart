
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/Auth/country_provider.dart';
import 'package:flutter_application_1/controller/Auth/sign_up_provider.dart';
import 'package:flutter_application_1/model/login/sign_up_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SecondSignScreen extends StatefulWidget {
  final String name;
  final String email;
  final String password;
  final String confpassword;
  final String parentName;
  final String parentPhone;

  const SecondSignScreen({
    Key? key,
    required this.name,
    required this.email,
    required this.password,
    required this.confpassword,
    required this.parentName,
    required this.parentPhone,
  }) : super(key: key);

  @override
  _SecondSignScreenState createState() => _SecondSignScreenState();
}

class _SecondSignScreenState extends State<SecondSignScreen> {
  final TextEditingController _studentPhoneController = TextEditingController();

  String? selectedCountryId;
  String? selectedCityId;
  String? selectedCategoryId;
  String? selectedType;

  String? selectedCountryName;
  String? selectedCityName;
  String? selectedCategoryName;

  List<Country> countries = [];
  List<City> cities = [];
  List<Category> categories = [];
  List<String> types = ['عربي', 'لغات'];

  @override
  void initState() {
    super.initState();
    fetchData().then((data) {
      setState(() {
        countries = data.countries;
        cities = data.cities;
        categories = data.categories;
      });
    });
  }

  void signUp() {
    if (_studentPhoneController.text.isEmpty ||
        selectedCountryId == null ||
        selectedCityId == null ||
        selectedCategoryId == null ||
        selectedType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'من فضلك املأ جميع البيانات',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: redcolor,
        ),
      );
      return;
    }

    ApiService.signUp(
      name: widget.name,
      email: widget.email,
      password: widget.password,
      confpassword: widget.confpassword, // Added confpassword
      parentName: widget.parentName,
      parentPhone: widget.parentPhone,
      phone: _studentPhoneController.text, // Added phone
      selectedCountryId: selectedCountryId,
      selectedCityId: selectedCityId,
      selectedCategoryId: selectedCategoryId,
      selectedType: selectedType,
      context: context,
    );
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
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'أهلا بك معنا',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _studentPhoneController,
                decoration: InputDecoration(
                  labelText: 'رقم تليفون الطالب',
                  prefixIcon: const Icon(Icons.phone, color: redcolor),
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
              ),
              const SizedBox(height: 15),
              DropdownButtonFormField<String>(
                value: selectedCountryId,
                items: countries.map((Country country) {
                  return DropdownMenuItem<String>(
                    value: country.id.toString(),
                    child: Text(country.countryName),
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
                            (country) => country.id == int.parse(newValue!))
                        .countryName;
                  });
                },
              ),
              const SizedBox(height: 15),
              DropdownButtonFormField<String>(
                value: selectedCityId,
                items: cities.map((City city) {
                  return DropdownMenuItem<String>(
                    value: city.id.toString(),
                    child: Text(city.cityName),
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
                        .firstWhere((city) => city.id == int.parse(newValue!))
                        .cityName;
                  });
                },
              ),
              const SizedBox(height: 15),
              DropdownButtonFormField<String>(
                value: selectedCategoryId,
                items: categories.map((Category category) {
                  return DropdownMenuItem<String>(
                    value: category.id.toString(),
                    child: Text(category.category),
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
                            (category) => category.id == int.parse(newValue!))
                        .category;
                  });
                },
              ),
              const SizedBox(height: 15),
              DropdownButtonFormField<String>(
                value: selectedType,
                items: types.map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'الفئة',
                  prefixIcon: const Icon(Icons.language, color: redcolor),
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
                    selectedType = newValue;
                  });
                },
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    signUp();
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
                    'ارسال',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.facebook,
                        color: redcolor),
                    iconSize: 30,
                    onPressed: () {},
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.instagram,
                        color: redcolor),
                    iconSize: 30,
                    onPressed: () {},
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    icon:
                        const FaIcon(FontAwesomeIcons.twitter, color: redcolor),
                    iconSize: 30,
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'لديك حساب؟ تسجيل الدخول',
                    style: TextStyle(fontSize: 18, color: redcolor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}