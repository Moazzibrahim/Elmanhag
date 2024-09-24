// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, avoid_print

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/payment/payment_methods_provider.dart';
import 'package:flutter_application_1/localization/app_localizations.dart';
import 'package:flutter_application_1/models/payment_methods_model.dart';
import 'package:flutter_application_1/views/screens/payment/fawry_payment_screen.dart';
import 'package:flutter_application_1/views/screens/payment/visa_payment_screen.dart';
import 'package:flutter_application_1/views/screens/payment/vodafone_payment_screen.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatefulWidget {
  final int itemidbundle;
  final String? itemprice;
  final String itemservice;
  final int itemidsubject;
  final int? itemdiscount;
  const PaymentScreen(
      {super.key,
      required this.itemidbundle,
      required this.itemidsubject,
      this.itemprice,
      required this.itemservice,
      this.itemdiscount});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _selectedIndex = -1; // Initialize with -1 (none selected)
  final TextEditingController _promoCodeController = TextEditingController();
  String? _promoCodeError;
  int? itemPriceAsInt; // Variable to store converted price

  @override
  void initState() {
    super.initState();

    // Check if the item price is not null and not empty
    if (widget.itemprice != null && widget.itemprice!.isNotEmpty) {
      String cleanedPrice = widget.itemprice!.trim();

      // Attempt to parse the price as a double
      double? itemPriceAsDouble = double.tryParse(cleanedPrice);

      if (itemPriceAsDouble != null) {
        // Convert to int by rounding or truncating, depending on your requirement
        itemPriceAsInt =
            itemPriceAsDouble.round(); // Or use .toInt() for truncating
        print('Parsed Item Price as Integer: $itemPriceAsInt');
      } else {
        print('Failed to parse price as double: $cleanedPrice');
      }
    } else {
      print('Item price is null or empty');
    }

    Future.microtask(() {
      Provider.of<PaymentMethodsProvider>(context, listen: false)
          .fetchPaymentMethods(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final localizations = AppLocalizations.of(context);

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
              child: Consumer<PaymentMethodsProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (provider.errorMessage.isNotEmpty) {
                    return Center(child: Text(provider.errorMessage));
                  }
                  return SingleChildScrollView(
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
                                icon: const Icon(Icons.arrow_back_ios,
                                    color: redcolor),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              const Spacer(flex: 2),
                              Text(
                                ' ${localizations.translate('payment_methods')}',
                                style: const TextStyle(
                                  color: redcolor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(flex: 3),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Column(
                            children: [
                              if (widget.itemdiscount != null)
                                Row(
                                  children: [
                                    Text(
                                      "${widget.itemdiscount} EGP",
                                      style: const TextStyle(
                                          color: redcolor, fontSize: 20),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      localizations.translate('instead_of'),
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "$itemPriceAsInt EGP",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          decoration:
                                              TextDecoration.lineThrough),
                                    ),
                                  ],
                                )
                              else
                                Row(
                                  children: [
                                    // Display item price as integer if available
                                    Text(
                                      "$itemPriceAsInt EGP",
                                      style: const TextStyle(
                                          fontSize: 20, color: redcolor),
                                    ),
                                  ],
                                ),
                              // Continue with the rest of your widgets here...
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            localizations.translate('choose payment methods'),
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          ...provider.paymentMethods.map((paymentMethod) =>
                              _buildPaymentOption(
                                  paymentMethod.id, paymentMethod)),
                          const SizedBox(height: 16),
                          Text(
                            ' ${localizations.translate('enter_promo_code')}',
                            style: const TextStyle(
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
                                    hintText:
                                        ' ${localizations.translate('promo_code')}',
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
                                child: Text(localizations.translate('apply'),
                                    style:
                                        const TextStyle(color: Colors.white)),
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
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 5,
                                ),
                                child: Text(
                                  localizations.translate('next'),
                                  style: const TextStyle(
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
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _applyPromoCode() {
    final localizations = AppLocalizations.of(context);
    final promoCode = _promoCodeController.text;

    // Sample validation logic for promo code
    if (promoCode.isEmpty) {
      setState(() {
        _promoCodeError = localizations.translate('you must enter promo code');
      });
      return;
    }

    // Here you would typically call an API or service to validate the promo code
    // For now, we'll just simulate success and failure
    if (promoCode == 'VALIDCODE') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                '  ${localizations.translate('promo code is applied successfully')} ')),
      );
      setState(() {
        _promoCodeError = null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(localizations.translate('invalid promo code'))),
      );
      setState(() {
        _promoCodeError = ' ${localizations.translate('invalid promo code')}';
      });
    }
  }

  void _navigateToSelectedScreen() {
    final localizations = AppLocalizations.of(context);
    if (_selectedIndex == -1) {
      // If no payment method is selected, show a message or prevent navigation
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                localizations.translate('you must choose payment method'))),
      );
      return;
    }

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
              itemids: widget.itemidbundle,
              itemsprice: widget.itemprice!,
              services: widget.itemservice,
              itemidsub: widget.itemidsubject,
              paymentmtethodid:
                  _selectedIndex, // Pass selected payment method ID here
            ),
          ),
        );
        log("Payment method ID: $_selectedIndex");
        break;
      case 2:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (ctx) => const FawryPaymentScreen()),
        );
        log("Payment method ID: $_selectedIndex");
        break;
      default:
        // Handle the default case if needed
        break;
    }
  }

  Widget _buildPaymentOption(int index, PaymentMethodstudent paymentMethod) {
    final theme = Theme.of(context);
    bool isSelected = _selectedIndex == paymentMethod.id;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: isSelected ? Colors.red.shade200 : theme.cardColor,
      elevation: isSelected ? 5 : 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading:
            Image.network(paymentMethod.thumbnailLink, width: 30, height: 30),
        title: Text(
          paymentMethod.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: redcolor,
          ),
        ),
        trailing: Radio<int>(
          value: paymentMethod.id,
          groupValue: _selectedIndex,
          activeColor: redcolor,
          onChanged: (int? value) {
            setState(() {
              _selectedIndex = value!;
            });
          },
        ),
        onTap: () {
          setState(() {
            _selectedIndex = paymentMethod.id;
          });
        },
      ),
    );
  }
}
