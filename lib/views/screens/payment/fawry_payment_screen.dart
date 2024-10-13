// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/payment/payment_methods_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FawryPaymentScreen extends StatefulWidget {
  const FawryPaymentScreen(
      {super.key,
      this.id,
      this.service,
      this.quantity,
      this.amount});
  final String? id;
  final String? service;
  final int? quantity;
  final int? amount;

  @override
  State<FawryPaymentScreen> createState() => _FawryPaymentScreenState();
}

class _FawryPaymentScreenState extends State<FawryPaymentScreen> {
  
  Future<void> savemerchantRefNum(String merchantRefNum,String refNumber) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('merchantRefNum', merchantRefNum);
    await prefs.setString('refNumber', refNumber);
  }
  @override
  void initState() {
      if(widget.id != null){
        Provider.of<PaymentMethodsProvider>(context, listen: false).postFawryData(
        context,
        id: widget.id!,
        service: widget.service!,
        quantity: widget.quantity!,
        amount: widget.amount!);
      }
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
        backgroundColor: isDarkMode ? Colors.transparent : Colors.white,
        body: Consumer<PaymentMethodsProvider>(
          builder: (context, provider, _) {
            if (provider.merchantRefNumber == null && provider.savedmerchantRefNumber == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if(widget.id != null){
                savemerchantRefNum(provider.merchantRefNumber!, provider.referenceNumber!);
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('احفظ الرقم للدفع'),
                    Text( 
                      provider.savedreferenceNumber == null ?
                      provider.referenceNumber! : 
                      provider.savedreferenceNumber!
                      ,
                      style: const TextStyle(
                          fontSize: 30,
                          color: redcolor,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                        onPressed: () async{
                          await provider.postMerchantNum(context, merchantRefNum: provider.merchantRefNumber?? provider.savedmerchantRefNumber!);
                          if(provider.isPaid){
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Payment is Done')));
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            await prefs.remove('merchantRefNum');
                            await prefs.remove('refNumber');
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('please pay first')));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: redcolor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text('اكد الدفع')),
                  ],
                ),
              );
            }
          },
        ));
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Icon(Icons.check_circle, color: Colors.green, size: 60),
          content: const Text(
            'تمت عملية الدفع بنجاح!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                Navigator.pushReplacementNamed(
                    context, '/home'); // Navigate to home screen
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
