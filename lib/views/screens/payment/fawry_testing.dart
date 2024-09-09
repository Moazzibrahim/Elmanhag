// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class FawryPaymentScreen extends StatefulWidget {
  const FawryPaymentScreen({super.key});

  @override
  _FawryPaymentScreenState createState() => _FawryPaymentScreenState();
}

class _FawryPaymentScreenState extends State<FawryPaymentScreen> {
  bool isLoading = false;
  String? redirectUrl;
  String? statusDescription;

  // Function to initiate the Fawry payment
  Future<void> initiateFawryPayment() async {
    setState(() {
      isLoading = true;
    });

    const url = 'https://your-backend.com/payment/fawry';  // Replace with your actual backend URL
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'orderId': '12345',  // Order ID to identify the payment
        'amount': 100.0,     // Payment amount
        'customerEmail': 'customer@example.com',  // Customer email
      }),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse['nextAction'] != null && jsonResponse['nextAction']['type'] == 'THREE_D_SECURE') {
        setState(() {
          redirectUrl = jsonResponse['nextAction']['redirectUrl'];
          statusDescription = jsonResponse['statusDescription'];
        });
      }
    } else {
      setState(() {
        statusDescription = 'Failed to initiate payment. Please try again.';
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  // Function to launch the 3D Secure URL
  Future<void> _launchPaymentUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    initiateFawryPayment();  // Initiate payment when the screen loads
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fawry Payment')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : redirectUrl == null
              ? Center(child: Text(statusDescription ?? 'Unknown error'))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Payment Initiated:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        statusDescription ?? 'Operation done successfully',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (redirectUrl != null) {
                            _launchPaymentUrl(redirectUrl!);  // Launch the 3D Secure URL
                          }
                        },
                        child: const Text('Complete Payment'),
                      ),
                    ],
                  ),
                ),
    );
  }
}
