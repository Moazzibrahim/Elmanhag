// ignore_for_file: must_be_immutable

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/views/screens/payment/fawry_payment_screen.dart';
import 'package:flutter_application_1/views/screens/payment/visa_payment_screen.dart';
import 'package:flutter_application_1/views/screens/payment/vodafone_payment_screen.dart';

class PaymentScreen extends StatefulWidget {
  final int itemid;
  final String itemprice;
  final String itemservice;
  const PaymentScreen(
      {super.key,
      required this.itemid,
      required this.itemprice,
      required this.itemservice});

  @override
  // ignore: library_private_types_in_public_api
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _selectedIndex = -1; // Initialize with -1 (none selected)
  final TextEditingController _promoCodeController = TextEditingController();
  String? _promoCodeError;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          if (isDarkMode)
            Positioned.fill(
              child: Image.asset(
                'assets/images/Ellipse 198.png',
                fit: BoxFit.cover,
              ),
            ),
          Positioned.fill(
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 25),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_ios, color: redcolor),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          const Spacer(flex: 2),
                          const Text(
                            'طرق الدفع',
                            style: TextStyle(
                              color: redcolor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(flex: 3),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'اختر طريقة الدفع',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildPaymentOption(0, 'فيزا', 'assets/images/visa.png'),
                      _buildPaymentOption(
                          1, 'فودافون كاش', 'assets/images/vod.png'),
                      _buildPaymentOption(2, 'فوري', 'assets/images/Fawry.png'),
                      const SizedBox(height: 16),
                      const Text(
                        'ادخل كود الخصم',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _promoCodeController,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                hintText: 'كود الخصم',
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                errorText: _promoCodeError,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: _applyPromoCode,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: redcolor,
                            ),
                            child: const Text('تطبيق',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 180),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _selectedIndex != -1
                                ? _navigateToSelectedScreen
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: redcolor,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 5,
                            ),
                            child: const Text(
                              'التالي',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _applyPromoCode() {
    final promoCode = _promoCodeController.text;

    // Sample validation logic for promo code
    if (promoCode.isEmpty) {
      setState(() {
        _promoCodeError = 'يرجى إدخال كود الخصم';
      });
      return;
    }

    // Here you would typically call an API or service to validate the promo code
    // For now, we'll just simulate success and failure
    if (promoCode == 'VALIDCODE') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('كود الخصم تم تطبيقه')),
      );
      setState(() {
        _promoCodeError = null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('كود الخصم غير صحيح')),
      );
      setState(() {
        _promoCodeError = 'كود الخصم غير صحيح';
      });
    }
  }

  void _navigateToSelectedScreen() {
    switch (_selectedIndex) {
      case 0:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (ctx) => const VisaPaymentScreen()),
        );
        break;
      case 1:
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (ctx) => VodafonePaymentScreen(
                    itemids: widget.itemid,
                    itemsprice: widget.itemprice,
                    services: widget.itemservice,
                  )),
        );
        log("${widget.itemid}");
        break;
      case 2:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (ctx) => const FawryPaymentScreen()),
        );
        break;
      default:
        // Handle the default case if needed
        break;
    }
  }

  Widget _buildPaymentOption(int index, String text, String imagePath) {
    final theme = Theme.of(context);
    bool isSelected = _selectedIndex == index;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: isSelected ? Colors.red.shade200 : theme.cardColor,
      elevation: isSelected ? 5 : 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Image.asset(imagePath, width: 30, height: 30),
        title: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: redcolor,
          ),
        ),
        trailing: Radio<int>(
          value: index,
          groupValue: _selectedIndex,
          activeColor: redcolor, // This sets the active circle color to red
          onChanged: (int? value) {
            setState(() {
              _selectedIndex = value!;
            });
          },
        ),
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
