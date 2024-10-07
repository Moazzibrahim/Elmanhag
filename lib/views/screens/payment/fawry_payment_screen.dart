import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/payment/payment_methods_provider.dart';
import 'package:provider/provider.dart';

class FawryPaymentScreen extends StatelessWidget {
  const FawryPaymentScreen({super.key, required this.itemId, required this.service});
  final int itemId;
  final String service;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.transparent : Colors.white,
      body: Consumer<PaymentMethodsProvider>(
        builder: (context, provider, _) {
          if(provider.merchantRefNumber == null){
            return const Center(child: CircularProgressIndicator(),);
          }else{
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('احفظ الرقم للدفع'),
                  Text(provider.referenceNumber.toString(),style: const TextStyle(fontSize: 30,color: redcolor,fontWeight: FontWeight.w500),),
                  const SizedBox(height: 30,),
                  ElevatedButton(
                  onPressed: (){
                    
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
      )
    );
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
