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
}
