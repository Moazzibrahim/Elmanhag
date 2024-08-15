
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/Auth/sign_up_provider.dart';
import 'package:flutter_application_1/models/sign_up_model.dart';
import 'package:flutter_application_1/views/widgets/progress_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/Auth/country_provider.dart';
import 'package:flutter_application_1/views/widgets/text_field.dart';

class ThirdSignUp extends StatefulWidget {
  final String name;
  final String email;
  final String password;
  final String confpassword;
  final String phone;
  final String countryId;
  final String cityId;
  final String categoryId;
  final String educationId;

  const ThirdSignUp({
    super.key,
    required this.name,
    required this.email,
    required this.password,
    required this.confpassword,
    required this.phone,
    required this.countryId,
    required this.cityId,
    required this.categoryId,
    required this.educationId,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ThirdSignUpState createState() => _ThirdSignUpState();
}

class _ThirdSignUpState extends State<ThirdSignUp> {
  final TextEditingController _parentNameController = TextEditingController();
  final TextEditingController _parentPhoneController = TextEditingController();
  final TextEditingController _parentEmailController = TextEditingController();
  final TextEditingController _parentPasswordController =
      TextEditingController();
  final TextEditingController _parentConfirmPasswordController =
      TextEditingController();

  String? selectedParentRelation;
  List<ParentRelation> parentRelations = [];

  @override
  void initState() {
    super.initState();
    final dataProvider = Provider.of<DataProvider>(context, listen: false);
    dataProvider.fetchData(context).then((_) {
      setState(() {
        parentRelations = dataProvider.dataModel?.parentRelations ?? [];
      });
    });
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
            const ProgressCircles(currentScreen: 3),
            const SizedBox(height: 15),
            const Text(
              'أهلا بك معنا',
              style: TextStyle(
                fontSize: 24,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),
            buildTextField(
              controller: _parentNameController,
              labelText: 'اسم ولي الامر',
              prefixIcon: const Icon(Icons.person, color: redcolor),
            ),
            const SizedBox(height: 15),
            buildTextField(
              controller: _parentPhoneController,
              labelText: 'رقم هاتف ولي الامر',
              prefixIcon: const Icon(Icons.phone, color: redcolor),
            ),
            const SizedBox(height: 15),
            buildTextField(
              controller: _parentEmailController,
              labelText: 'ايميل ولي الامر',
              prefixIcon: const Icon(Icons.email, color: redcolor),
            ),
            const SizedBox(height: 15),
            PasswordField(
                controller: _parentPasswordController,
                labelText: "الرقم السري"),
            const SizedBox(height: 15),
            PasswordField(
                controller: _parentConfirmPasswordController,
                labelText: "تاكيد الرقم السري"),
            const SizedBox(height: 15),
            DropdownButtonFormField<String>(
              value: selectedParentRelation,
              items: parentRelations.map((ParentRelation relation) {
                return DropdownMenuItem<String>(
                  value: relation.id.toString(),
                  child: Text(relation.name),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'قرابة ولي الامر',
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
                  selectedParentRelation = newValue;
                });
              },
              validator: (value) =>
                  value == null ? 'Please select a parent relation' : null,
            ),
            const SizedBox(height: 30),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pop(); // Go back to the previous screen
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          redcolor, // Set a different color for the back button
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      textStyle: const TextStyle(fontSize: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'رجوع',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_parentPasswordController.text !=
                          _parentConfirmPasswordController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('كلمتا السر غير متطابقتين'),
                            backgroundColor: redcolor,
                          ),
                        );
                      } else {
                        await ApiService.signUp(
                          name: widget.name,
                          email: widget.email,
                          password: widget.password,
                          confpassword: widget.confpassword,
                          phone: widget.phone,
                          selectedCountryId: widget.countryId,
                          selectedCityId: widget.cityId,
                          selectedCategoryId: widget.categoryId,
                          selectedEducationId: widget.educationId,
                          parentname: _parentNameController.text,
                          parentemail: _parentEmailController.text,
                          parentpassword: _parentPasswordController.text,
                          parentphone: _parentPhoneController.text,
                          selectedparentrealtionId: selectedParentRelation,
                          context: context,
                        );
                      }
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
            const SizedBox(height: 30),
            const Divider(color: Colors.grey),
            const SizedBox(height: 20),
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
    );
  }
}
