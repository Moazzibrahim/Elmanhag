// ignore_for_file: use_build_context_synchronously, avoid_print
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/Auth/country_provider.dart';
import 'package:flutter_application_1/controller/Auth/login_provider.dart';
import 'package:flutter_application_1/controller/profile/profile_provider.dart';
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
  bool _isInitialized = false;

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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isInitialized) {
        Provider.of<UserProfileProvider>(context, listen: false)
            .fetchUserProfile(context);
        _isInitialized = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final userProfileProvider = Provider.of<UserProfileProvider>(context);
    final user = userProfileProvider.user;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.black
              : Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
                color: Theme.of(context).brightness == Brightness.dark
                    ? redcolor
                    : redcolor),
            onPressed: () {
              Navigator.pop(
                context,
              );
            },
          ),
          title: Row(
            children: [
              CircleAvatar(
                backgroundImage: _image != null
                    ? FileImage(_image!)
                    : NetworkImage(user!.imageLink!),
                radius: 20,
              ),
              IconButton(
                icon: Icon(Icons.camera_alt,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? redcolor
                        : redcolor),
                onPressed: pickImage,
              ),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localizations.translate('welcome'),
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? redcolor
                          : redcolor,
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

  String truncateString(String str, int maxLength) {
    return str.length > maxLength ? '${str.substring(0, maxLength)}...' : str;
  }

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
      const url = 'https://bdev.elmanhag.shop/student/profile/modify';
      final token = Provider.of<TokenModel>(context, listen: false).token;

      // Print selected IDs and image path
      print('Selected Country ID: $selectedCountryId');
      print('Selected City ID: $selectedCityId');
      if (widget.image != null) {
        print('Selected Image Path: ${widget.image!.path}');
      } else {
        print('No image selected');
      }

      final request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers['Content-Type'] = 'application/json';
      request.headers['Accept'] = 'application/json';
      request.headers['Authorization'] = 'Bearer $token';

      final Map<String, String> fieldsMap = {
        'name': _nameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
        'password': _passwordController.text,
        'conf_password': _confirmpasswordController.text,
        'country_id': selectedCountryId ?? '',
        'city_id': selectedCityId ?? '',
        'category_id': selectedCategoryId ?? '',
        'education_id': selectedEducationId ?? '',
      };

      request.fields.addAll(fieldsMap);

      if (widget.image != null) {
        request.files.add(
          await http.MultipartFile.fromPath('image', widget.image!.path),
        );
      }

      final response = await request.send();

      if (response.statusCode == 200) {
        // Fetch updated profile data
        await Provider.of<UserProfileProvider>(context, listen: false)
            .fetchUserProfile(context);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully')),
        );
        Navigator.pop(context, true); // Indicate the update was successful
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
                  // CustomTextField(
                  //   hintText: localizations.translate('Name'),
                  //   textInputType: TextInputType.name,
                  //   icon: Icons.person,
                  //   controller: _nameController,
                  // ),
                  // CustomTextField(
                  //   hintText: localizations.translate('email'),
                  //   textInputType: TextInputType.emailAddress,
                  //   icon: Icons.person,
                  //   controller: _emailController,
                  // ),
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
                    value: selectedCountryId,
                    items: countries.map((Country country) {
                      return DropdownMenuItem<String>(
                        value: country.id.toString(),
                        child: Text(
                          truncateString(
                              country.name, 30), // Truncate the country name
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 12
                                .sp, // Use ScreenUtil for responsive font size
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: localizations.translate('country'),
                      prefixIcon: const Icon(Icons.public, color: redcolor),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 12.h,
                          horizontal: 16.w), // Responsive padding
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
                                    city.countryId.toString() ==
                                    selectedCountryId)
                                .toList() ??
                            [];
                        selectedCityId = null; // Reset selected city
                      });
                    },
                    validator: (value) =>
                        value == null ? 'Please select a country' : null,
                  ),

                  const SizedBox(height: 15),

// Disable city dropdown if no country is selected
                  DropdownButtonFormField<String>(
                    value: selectedCityId,
                    items: cities.map(
                      (City city) {
                        return DropdownMenuItem<String>(
                          value: city.id.toString(),
                          child: Text(city.name),
                        );
                      },
                    ).toList(),
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
                    onChanged: selectedCountryId == null
                        ? null // Disable city dropdown if no country is selected
                        : (String? newValue) {
                            setState(() {
                              selectedCityId = newValue;
                              selectedCityName = cities
                                  .firstWhere(
                                      (city) => city.id.toString() == newValue)
                                  .name;
                            });
                          },
                    validator: (value) => selectedCountryId == null
                        ? 'Please select a country first'
                        : value == null
                            ? 'Please select a city'
                            : null,
                    onSaved: (value) {
                      selectedCityId = value;
                    }, // Disable city dropdown until country is selected
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

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextInputType textInputType;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.icon,
    required this.textInputType,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: TextField(
        controller: controller, // Ensure the controller is set here
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
