// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/affiliate/views/affiliate_home_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/Auth/country_provider.dart';
import 'package:flutter_application_1/controller/Auth/login_provider.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../controller/affiliate_provider.dart';

class WithdrawalScreen extends StatefulWidget {
  const WithdrawalScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WithdrawalScreenState createState() => _WithdrawalScreenState();
}

class _WithdrawalScreenState extends State<WithdrawalScreen> {
  int? _selectedPaymentMethodId; // Store payment method ID
  double _walletBalance = 0.0;
  double? _minPayout; // Store the min payout for the selected method
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<DataProvider>(context, listen: false).fetchData(context);
    _fetchUserBalance();
  }

  Future<void> _fetchUserBalance() async {
    final data = await ApiService().fetchUserProfile(context);
    if (data != null) {
      setState(() {
        _walletBalance = data.user.income.wallet.toDouble();
      });
    }
  }

  Future<void> _submitWithdrawalRequest() async {
    // Retrieve token from TokenModel
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final String? token = tokenProvider.token;

    if (_selectedPaymentMethodId == null || _walletBalance <= 0) {
      // Handle validation error
      _showErrorDialog("Please fill all required fields.");
      return;
    }

    final amount = _amountController.text.trim();
    final description = _descriptionController.text.trim();

    if (amount.isEmpty || description.isEmpty) {
      _showErrorDialog("Please enter valid data.");
      return;
    }

    final double parsedAmount = double.tryParse(amount) ?? 0.0;

    // Check if amount exceeds wallet balance
    if (parsedAmount > _walletBalance) {
      _showErrorDialog("رصيدك غير كافي لتنفيذ تلك العملية");
      return;
    }

    // Check if amount is less than the minimum payout
    if (_minPayout != null && parsedAmount < _minPayout!) {
      _showErrorDialog(" يجب تخطي الحد الادني للسحب");
      return;
    }

    try {
      // Send POST request with data
      final response = await http.post(
        Uri.parse('https://bdev.elmanhag.shop/affilate/account/withdraw'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'payment_method_affilate_id': _selectedPaymentMethodId,
          'amount': amount,
          'description': description,
        }),
      );

      if (response.statusCode == 200) {
        log(response.body);
        _showProcessingDialog(context);
      } else {
        _showErrorDialog("Failed to process request.");
      }
    } catch (e) {
      _showErrorDialog("An error occurred: $e");
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('عملية غير ناجحة'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    final paymentMethods = dataProvider.dataModel?.paymentMethods ?? [];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: redcolor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'السحب',
          style: TextStyle(
              color: redcolor, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BalanceCard(
                    amount: '${_walletBalance.toStringAsFixed(2)} ج.م',
                    label: 'محفظتك',
                  ),
                ],
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _amountController,
                decoration: InputDecoration(
                  hintText: 'المبلغ الذي تريد سحبه',
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: redcolor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: redcolor, width: 2),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 24),
              const Text('طرق السحب',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              if (paymentMethods.isNotEmpty)
                ...paymentMethods.map((method) {
                  return PaymentMethodOption(
                    label: method.method,
                    // logo: method.thumbnail != null
                    //     ? 'https://bdev.elmanhag.shop/${method.thumbnail}'
                    //     : 'assets/images/vod.png',
                    value: method.id,
                    groupValue: _selectedPaymentMethodId,
                    onChanged: (value) {
                      setState(() {
                        _selectedPaymentMethodId = value;
                        _minPayout =
                            method.minPayout.toDouble(); // Set min payout
                      });
                    },
                  );
                  // ignore: unnecessary_to_list_in_spreads
                }).toList(),
              if (_minPayout != null) ...[
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    'الحد الادني للسحب: $_minPayout',
                    style: const TextStyle(fontSize: 18, color: redcolor),
                  ),
                ),
              ],
              const SizedBox(height: 24),
              if (_selectedPaymentMethodId != null)
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    hintText: 'ادخل الرقم الذي تريد التحويل عليه ',
                    hintStyle: TextStyle(color: Colors.grey.shade600),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: redcolor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: redcolor, width: 2),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _selectedPaymentMethodId != null
                    ? _submitWithdrawalRequest
                    : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: redcolor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'اسحب ارباحك',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BalanceCard extends StatelessWidget {
  final String amount;
  final String label;

  const BalanceCard({super.key, required this.amount, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: redcolor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                amount,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentMethodOption extends StatelessWidget {
  final String label;
  final int value;
  final int? groupValue;
  final ValueChanged<int?> onChanged;

  const PaymentMethodOption({
    super.key,
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile<int>(
      title: Text(label),
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
    );
  }
}

void _showProcessingDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('طلبك قيد التنفيذ'),
        content: const Text('سيتم التحويل قريبا '),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AffiliateHomeScreen()));
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
