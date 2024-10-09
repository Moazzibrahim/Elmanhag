// ignore_for_file: avoid_print, use_build_context_synchronously, unused_local_variable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/Auth/login_provider.dart';
import 'package:flutter_application_1/controller/bundle/get_bundle_data.dart';
import 'package:flutter_application_1/controller/payment/payment_methods_provider.dart';
import 'package:flutter_application_1/controller/profile/profile_provider.dart';
import 'package:flutter_application_1/localization/app_localizations.dart';
import 'package:flutter_application_1/views/screens/home_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class VodafonePaymentScreen extends StatefulWidget {
  final int itemids;
  final int itemidsub;
  final String itemsprice;
  final String services;
  final int? paymentmtethodid;
  final String image;
  final String title;
  final String description;
  final List<int>? selectedSubjectIds;
  final List<String>? selectedPrices;
  final List<double>? selectedDiscounts;
  const VodafonePaymentScreen(
      {super.key,
      required this.itemids,
      required this.itemidsub,
      required this.itemsprice,
      required this.services,
      this.paymentmtethodid,
      required this.image,
      required this.title,
      required this.description,
      this.selectedDiscounts,
      this.selectedPrices,
      this.selectedSubjectIds});

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
        Future.microtask(() {
          Provider.of<PaymentMethodsProvider>(context, listen: false)
              .fetchPaymentMethods(context);
        });
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
      body: Consumer<PaymentMethodsProvider>(
          builder: (BuildContext context, value, Widget? child) {
        return Stack(
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
                      Image.network(
                        widget.image,
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
                            '${localizations.translate("details")} ${widget.description}',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          // const SizedBox(height: 10),
                          // Text(
                          //   'البريد الإلكتروني: ${user.email}',
                          //   style: const TextStyle(
                          //     fontSize: 18,
                          //     color: Colors.black,
                          //   ),
                          // ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                        if (_image == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(localizations.translate(
                                  'You should select a photo first!')),
                              backgroundColor: redcolor,
                            ),
                          );
                          return; // Exit if no image is selected
                        }
                        submitPayment();
                        log('price: ${widget.selectedPrices}');
                        log('service: ${widget.services}');
                        log('subid: ${widget.selectedSubjectIds}');
                        log("bundleid:  ${widget.selectedSubjectIds}");
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
        );
      }),
    );
  }

  Future<void> submitPayment() async {
    if (_image == null) {
      print('Please upload a receipt');
      return;
    }

    final url = Uri.parse(
        'https://bdev.elmanhag.shop/student/order/place'); // Replace with your API URL
    final token = Provider.of<TokenModel>(context, listen: false).token;

    try {
      final request = http.MultipartRequest('POST', url);
      request.headers['Content-Type'] = 'application/json';
      request.headers['Accept'] = 'application/json';
      request.headers['Authorization'] = 'Bearer $token';

      // Add fields
      request.fields['amount'] =
          widget.selectedPrices.toString(); // Replace with the actual amount
      request.fields['service'] =
          widget.services.toString(); // Replace with the actual service
      request.fields['payment_method_id'] = widget.paymentmtethodid
          .toString(); // Replace with the actual payment method ID
      if (widget.services == 'Bundle') {
        request.fields['bundle_id'] =
            widget.selectedSubjectIds.toString(); // Pass the bundle ID
      } else if (widget.services == 'Subject') {
        request.fields['subject_id'] = widget.selectedSubjectIds.toString();
      }

      // Add receipt (image file)
      request.files.add(
        await http.MultipartFile.fromPath(
          'receipt', // API key for the file
          _image!.path,
        ),
      );
      log("pay id:${widget.paymentmtethodid}");
      log("price: ${widget.itemsprice}");

      final response = await request.send();

      if (response.statusCode == 200) {
        print('Payment successful');
        _showSuccessDialog(context);
      } else {
        print('Failed to submit payment: ${response.statusCode} ');
        _showfilDialog(context);
      }
    } catch (e) {
      print('Error submitting payment: $e');
    }
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

  void _showfilDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Icon(Icons.error, color: redcolor, size: 60),
          content: const Text(
            ' عملية الدفع  مرفوضة!',
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
