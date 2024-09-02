import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'المعاملات',
          style: TextStyle(color: redcolor, fontSize: 20),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: redcolor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTransactionButton(
                    'العمولات المدفوعة', '1000 ج.م', redcolor),
                _buildTransactionButton(
                    'العمولات المستحقه', '1000 ج.م', redcolor),
              ],
            ),
            const SizedBox(height: 32),
            const Text(
              'تاريخ معاملاتك:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildTransactionHistory(
                'لقد سحبت 1000 جنيه في 15/5/2024', '12:00 ص'),
            const Divider(),
            _buildTransactionHistory(
                'لقد سحبت 1000 جنيه في 15/4/2024', '12:00 ص'),
            const Divider(),
            _buildTransactionHistory(
                'لقد سحبت 500 جنيه في 15/6/2024', '12:00 ص'),
            const Divider(),
            _buildTransactionHistory(
                'لقد سحبت 1000 جنيه في 15/3/2024', '12:00 ص'),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionButton(String title, String amount, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
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
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionHistory(String description, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Text(
            time,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
