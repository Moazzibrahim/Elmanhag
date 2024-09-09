import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';

class WithdrawalScreen extends StatefulWidget {
  const WithdrawalScreen({super.key});

  @override
  _WithdrawalScreenState createState() => _WithdrawalScreenState();
}

class _WithdrawalScreenState extends State<WithdrawalScreen> {
  String? _selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
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
              // Balance Cards
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BalanceCard(amount: '1000 ج.م', label: 'العمولات المستحقه'),
                ],
              ),
              const SizedBox(height: 24),

              // Input for amount
              TextField(
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
              PaymentMethodOption(
                label: 'فودافون كاش',
                icon: Icons.mobile_friendly,
                logo: 'assets/images/vod.png', // Replace with your asset path
                value: 'vodafone_cash',
                groupValue: _selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value;
                  });
                },
              ),
              PaymentMethodOption(
                label: 'فوري',
                icon: Icons.local_atm,
                logo: 'assets/images/Fawry.png', // Replace with your asset path
                value: 'fawry',
                groupValue: _selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value;
                  });
                },
              ),

              // Show the text field under the selected method
              if (_selectedPaymentMethod != null) ...[
                const SizedBox(height: 16),
                TextField(
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
                onPressed: _selectedPaymentMethod != null
                    ? () {
                        _showProcessingDialog(context);
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

void _showProcessingDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: const Row(
          children: [
            Icon(
              Icons.info_outline,
              color: redcolor,
            ),
            SizedBox(width: 8),
            Text(
              'طلبك تحت التنفيذ',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        content: const Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            'لقد تم إرسال طلبك، وسيتم تنفيذه في أقرب وقت ممكن.',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        actions: <Widget>[
          Center(
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: redcolor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'حسناً',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
        actionsPadding: const EdgeInsets.only(bottom: 10),
      );
    },
  );
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
  final IconData icon;
  final String logo;
  final String value;
  final String? groupValue;
  final ValueChanged<String?> onChanged;

  const PaymentMethodOption({
    super.key,
    required this.label,
    required this.icon,
    required this.logo,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(value);
      },
      child: ListTile(
        leading: Image.asset(logo, width: 40, height: 40),
        title: Text(label, style: const TextStyle(fontSize: 16)),
        trailing: Radio<String>(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
          activeColor: redcolor,
        ),
      ),
    );
  }
}
