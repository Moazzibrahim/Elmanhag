import 'dart:developer';
import 'package:flutter/material.dart';
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

    // print({
    //   'payment_method_affilate_id': _selectedPaymentMethodId,
    //   'amount': amount,
    //   'description': description,
    // });

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
          'payment_method_affilate_id':
              _selectedPaymentMethodId, // Payment method ID
          'amount': amount, // Amount entered by the user
          'description': description, // Description entered by the user
        }),
      );

      if (response.statusCode == 200) {
        log(response.body);
        // ignore: use_build_context_synchronously
        _showProcessingDialog(context); // Show success dialog
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
          title: const Text('Error'),
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
              // Balance Cards with fetched balance
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BalanceCard(
                      amount: '${_walletBalance.toStringAsFixed(2)} ج.م',
                      label: 'محفظتك'),
                ],
              ),
              const SizedBox(height: 24),

              // Input for amount
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

              // Payment Methods
              const Text('طرق السحب',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

              const SizedBox(height: 16),

              // Payment method options
              if (paymentMethods.isNotEmpty)
                ...paymentMethods.map((method) {
                  return PaymentMethodOption(
                    label: method.method,
                    logo: method.thumbnail != null
                        ? 'https://bdev.elmanhag.shop/${method.thumbnail}'
                        : 'assets/images/Fawry.png', // Placeholder for missing image
                    value: method.id, // Use ID instead of method name
                    groupValue: _selectedPaymentMethodId,
                    onChanged: (value) {
                      setState(() {
                        _selectedPaymentMethodId = value;
                      });
                    },
                  );
                // ignore: unnecessary_to_list_in_spreads
                }).toList(),

              if (_selectedPaymentMethodId != null) ...[
                const SizedBox(height: 16),
                TextField( 
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    hintText: 'ادخل البيانات المطلوبة',
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
              ],

              const SizedBox(height: 24),

              // Withdrawal Button
              ElevatedButton(
                onPressed: _selectedPaymentMethodId != null
                    ? () {
                        _submitWithdrawalRequest(); // Trigger the POST request
                      }
                    : null, // Disable the button if no payment method is selected
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
  final String logo;
  final int value; // ID instead of method name
  final int? groupValue;
  final ValueChanged<int?> onChanged;

  const PaymentMethodOption({
    super.key,
    required this.label,
    required this.logo,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile<int>(
      title: Text(label),
      secondary: Image.network(
        logo,
        width: 50,
        height: 50,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset('assets/images/Fawry.png', width: 50, height: 50);
        },
      ),
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
    );
  }
}

void _showProcessingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevent dismissal by tapping outside
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          'طلبك قيد التنفيذ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black87,
          ),
        ),
        content: const Row(
          children: [
            Icon(Icons.hourglass_empty,
                color: redcolor, size: 40), // Hourglass icon
            SizedBox(width: 20),
            Expanded(
              child: Text(
                'برجاء الانتظار سيتم التحويل قريبا',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: redcolor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
