// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/bundle/get_bundle_data.dart';
import 'package:flutter_application_1/controller/profile/profile_provider.dart';
import 'package:flutter_application_1/localization/app_localizations.dart';
import 'package:flutter_application_1/views/screens/home_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:provider/provider.dart';

class VodafonePaymentScreen extends StatefulWidget {
  final int itemids;
  const VodafonePaymentScreen({super.key, required this.itemids});

  @override
  // ignore: library_private_types_in_public_api
  _VodafonePaymentScreenState createState() => _VodafonePaymentScreenState();
}

class _VodafonePaymentScreenState extends State<VodafonePaymentScreen> {
  File? _image;
  bool _isInitialized = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isInitialized) {
        Provider.of<UserProfileProvider>(context, listen: false)
            .fetchUserProfile(context);
        _isInitialized = true;
        Provider.of<GetBundleData>(context, listen: false)
            .fetchMainModel(context);
      }
    });
    super.initState();
  }

  Future<void> _uploadFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        print('Image selected from gallery: ${_image!.path}');
      });
    }
  }

  Future<void> _takePhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        print('Image taken from camera: ${_image!.path}');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final userProfileProvider = Provider.of<UserProfileProvider>(context);
    final user = userProfileProvider.user;
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.transparent : Colors.white,
      body: Stack(
        children: [
          if (isDarkMode)
            Positioned.fill(
              child: Image.asset(
                'assets/images/Ellipse 198.png',
                fit: BoxFit.cover,
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: redcolor),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Image.asset(
                      'assets/images/vod.png',
                      height: 50,
                    ),
                    Container(width: 50),
                  ],
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Text(
                      'أدخل تفاصيل الدفع',
                      style: TextStyle(
                        fontSize: 24,
                        color: redcolor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'رقم التليفون: ${user!.phone}',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'البريد الإلكتروني: ${user.email}',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            _image != null
                                ? Image.file(
                                    _image!,
                                    width: 200,
                                    height: 200,
                                  )
                                : Text(
                                    localizations.translate('Upload_receipt'),
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: redcolor,
                                    ),
                                  ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: _uploadFromGallery,
                                  child: Text(
                                    localizations
                                        .translate('Upload from Gallery'),
                                    style: const TextStyle(color: redcolor),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: _takePhoto,
                                  child: Text(
                                    localizations.translate('Take_Photo'),
                                    style: const TextStyle(color: redcolor),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: redcolor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      _showSuccessDialog(context);
                    },
                    child: Text(
                      localizations.translate('subscripe'),
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Icon(Icons.warning, color: Colors.grey, size: 60),
          content: const Text(
            ' عملية الدفع قيد المراجعة!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ));
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
