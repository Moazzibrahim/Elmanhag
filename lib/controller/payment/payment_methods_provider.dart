// ignore_for_file: unused_local_variable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/Auth/login_provider.dart';
import 'package:flutter_application_1/models/payment_methods_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class PaymentMethodsProvider with ChangeNotifier {
  List<PaymentMethodstudent> _paymentMethods = [];
  bool _isLoading = false;
  String _errorMessage = '';
  String? referenceNumber;
  String? merchantRefNumber;

  List<PaymentMethodstudent> get paymentMethods => _paymentMethods;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Method to fetch payment methods
  Future<void> fetchPaymentMethods(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    const url = 'https://bdev.elmanhag.shop/student/paymentMethods';
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final String? token = tokenProvider.token;

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final paymentMethodsResponse =
            PaymentMethodsResponse.fromJson(jsonData);

        _paymentMethods = paymentMethodsResponse.paymentMethods;
        _errorMessage = '';
      } else {
        _errorMessage = 'Failed to load payment methods';
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> postFawryData(BuildContext context, {required int id, required String service,required int quantity}) async {
  final tokenProvider = Provider.of<TokenModel>(context, listen: false);
  final String? token = tokenProvider.token;
  final List chargeItems = [
    {
      "itemId": id, 
      "description": service, 
      "quantity": quantity
    }
  ];
  
  try {
    final response = await http.post(
      Uri.parse('https://bdev.elmanhag.shop/api/pay-at-fawry'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'chargeItems': chargeItems
      })
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);  // Parse the JSON response
      referenceNumber = responseData['referenceNumber'];
      merchantRefNumber = responseData['merchantRefNumber'];
      notifyListeners();
      log('Reference Number: $referenceNumber');
      log('Merchant Ref Number: $merchantRefNumber');

    } else {
      _errorMessage = 'Failed to load payment methods';
      log('error with status: ${response.statusCode}');
    }
  } catch (e) {
    _errorMessage = 'An error occurred: $e';
  }
}

Future<void> postMerchantNum(BuildContext context, {required String merchantRefNum}) async {
  final tokenProvider = Provider.of<TokenModel>(context, listen: false);
  final String? token = tokenProvider.token;
  
  
  
  try {
    final response = await http.post(
      Uri.parse('https://bdev.elmanhag.shop/api/fawry/check-status'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'merchantRefNum': merchantRefNum
      })
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      notifyListeners();


    } else {
      _errorMessage = 'Failed to load payment methods';
    }
  } catch (e) {
    _errorMessage = 'An error occurred: $e';
  }
}



}
