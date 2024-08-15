// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/Auth/country_provider.dart';
import 'package:flutter_application_1/controller/Auth/login_provider.dart';
import 'package:flutter_application_1/models/sign_up_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/localization/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? _image;

  final picker = ImagePicker();

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery, // or ImageSource.camera for camera
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: redcolor),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Row(
            children: [
              CircleAvatar(
                backgroundImage: _image != null
                    ? FileImage(_image!)
                    : const AssetImage('assets/images/tefl.png'),
                radius: 20,
              ),
              IconButton(
                icon: const Icon(Icons.camera_alt, color: redcolor),
                onPressed: pickImage,
              ),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localizations.translate('welcome'),
                    style: TextStyle(
                      color: redcolor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    localizations.translate('class'),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
        body: StudentTabContent(
          image: _image,
        ),
      ),
    );
  }
}

class StudentTabContent extends StatefulWidget {
  final File? image;
  const StudentTabContent({super.key, this.image});

  @override
  State<StudentTabContent> createState() => _StudentTabContentState();
}

class _StudentTabContentState extends State<StudentTabContent> {
  String? selectedCountryId;
  String? selectedCityId;
  String? selectedCategoryId;
  String? selectedEducationId;

  String? selectedCountryName;
  String? selectedCityName;
  String? selectedCategoryName;
  String? selectedEducationName;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    Future<void> saveProfile() async {
      int id = Provider.of<LoginModel>(context, listen: false).id;
      final url = 'https://bdev.elmanhag.shop/student/profile/modify/$id';
      final token = Provider.of<TokenModel>(context, listen: false).token;

      final request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers['Authorization'] = 'Bearer $token';
      request.fields['name'] = _nameController.text;
      request.fields['email'] = _emailController.text;
      request.fields['phone'] = _phoneController.text;
      request.fields['password'] = _passwordController.text;
      request.fields['conf_password'] = _confirmpasswordController.text;
      request.fields['country_id'] = selectedCountryId ?? '';
      request.fields['city_id'] = selectedCityId ?? '';
      request.fields['category_id'] = selectedCategoryId ?? '';
      request.fields['education_id'] = selectedEducationId ?? '';

      if (widget.image != null) {
        request.files.add(
            await http.MultipartFile.fromPath('image', widget.image!.path));
      }

      final response = await request.send();

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update profile')),
        );
      }
    }

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CustomTextField(
                    hintText: localizations.translate('Name'),
                    textInputType: TextInputType.name,
                    icon: Icons.person,
                    controller: _nameController,
                  ),
                  CustomTextField(
                    hintText: localizations.translate('email'),
                    textInputType: TextInputType.emailAddress,
                    icon: Icons.person,
                    controller: _emailController,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    hintText: localizations.translate('password'),
                    textInputType: TextInputType.visiblePassword,
                    icon: Icons.password,
                    controller: _passwordController,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    hintText: localizations.translate('confirm_password'),
                    textInputType: TextInputType.visiblePassword,
                    icon: Icons.password,
                    controller: _confirmpasswordController,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  DropdownButtonFormField<String>(
                    value: selectedCategoryId,
                    items: categories.map((Category category) {
                      return DropdownMenuItem<String>(
                        value: category.id.toString(),
                        child: Text(category.name),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: ' ${localizations.translate('grade')}',
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
                            .firstWhere((category) =>
                                category.id.toString() == newValue)
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
                      labelText: localizations.translate('education'),
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
                            .firstWhere((education) =>
                                education.id.toString() == newValue)
                            .name;
                      });
                    },
                    validator: (value) =>
                        value == null ? 'Please select an education' : null,
                  ),
                  const SizedBox(height: 25),
                  DropdownButtonFormField<String>(
                    value: selectedCountryId,
                    items: countries.map((Country country) {
                      return DropdownMenuItem<String>(
                        value: country.id.toString(),
                        child: Text(
                          country.name,
                          style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 11,
                              fontWeight: FontWeight.bold),
                        ),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: localizations.translate('country'),
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
                      labelText: localizations.translate('city'),
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
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    hintText: localizations.translate('phone'),
                    textInputType: TextInputType.phone,
                    icon: Icons.phone,
                    controller: _phoneController,
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SaveButton(
            onPressed: () => saveProfile(),
          ),
        ),
      ],
    );
  }
}

// class ParentTabContent extends StatelessWidget {
//   const ParentTabContent({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final localizations = AppLocalizations.of(context);

//     return Column(
//       children: [
//         Expanded(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 children: [
//                   CustomTextField(
//                     hintText: localizations.translate('parent_name'),
//                     textInputType: TextInputType.name,
//                     icon: Icons.person,
//                   ),
//                   CustomTextField(
//                     hintText: localizations.translate('parent_phone'),
//                     textInputType: TextInputType.phone,
//                     icon: Icons.phone,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         const Padding(
//           padding: EdgeInsets.all(16.0),
//           child: SaveButton(),
//         ),
//       ],
//     );
//   }
// }

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextInputType textInputType;
  final TextEditingController controller;

  const CustomTextField(
      {super.key,
      required this.hintText,
      required this.icon,
      required this.textInputType,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: TextField(
        keyboardType: textInputType,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(
            icon,
            color: redcolor,
          ),
          contentPadding:
              EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: redcolor,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: redcolor,
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}

class SaveButton extends StatelessWidget {
  final VoidCallback onPressed;
  const SaveButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: redcolor,
          padding: EdgeInsets.symmetric(vertical: 12.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          shadowColor: Colors.black45,
        ),
        onPressed: onPressed,
        child: Text(
          localizations.translate('save'),
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
