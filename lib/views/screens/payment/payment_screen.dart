import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/views/screens/payment/fawry_payment_screen.dart';
import 'package:flutter_application_1/views/screens/payment/visa_payment_screen.dart';
import 'package:flutter_application_1/views/screens/payment/vodafone_payment_screen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _selectedIndex = -1; // Initialize with -1 (none selected)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'طرق الدفع',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'اختر طريقة الدفع',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildPaymentOption(0, 'فيزا', 'assets/images/visa.png'),
            _buildPaymentOption(1, 'فودافون كاش', 'assets/images/vod.png'),
            _buildPaymentOption(2, 'فوري', 'assets/images/Fawry.png'),
            const Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _selectedIndex != -1
                        ? () {
                            _navigateToSelectedScreen();
                          }
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
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToSelectedScreen() {
    switch (_selectedIndex) {
      case 0:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (ctx) => VisaPaymentScreen()),
        );
        break;
      case 1:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (ctx) => VodafonePaymentScreen()),
        );
        break;
      case 2:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (ctx) => FawryPaymentScreen()),
        );
        break;
      default:
        // Handle the default case if needed
        break;
    }
  }

  Widget _buildPaymentOption(int index, String text, String imagePath) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: _selectedIndex == index ? Colors.red.shade200 : Colors.white,
      elevation: _selectedIndex == index ? 5 : 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Image.asset(imagePath, width: 30, height: 30),
        title: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
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
