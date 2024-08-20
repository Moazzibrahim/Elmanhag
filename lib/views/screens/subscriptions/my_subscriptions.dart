import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';

import '../payment/subscription_screen.dart';

class MySubscriptions extends StatelessWidget {
  const MySubscriptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'اشتراكاتي',
          style: TextStyle(color: redcolor, fontSize: 24),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: redcolor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                  child: SubscriptionCard(
                    title: 'باقه حصص اللايف',
                    description:
                        'انت الان على الباقه المجانيه تمتع بمزايا الباقه المدفوعه الآن',
                    buttonText: 'انت على الباقه المدفوعه',
                    imagePath: 'assets/images/live_sessions.png',
                    isPrimary: false,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: SubscriptionCard(
                    title: 'باقه المواد',
                    description:
                        'انت الان على الباقه المجانيه انتقل الى الباقه المدفوعه للحصول على المواد المتقدمه بسعر 1500 جنيه لكل المواد بدلا من 2600 جنيه',
                    buttonText: 'اشترك الان',
                    imagePath: 'assets/images/materials.png',
                    isPrimary: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SubscriptionCard extends StatelessWidget {
  final String title;
  final String description;
  final String buttonText;
  final String imagePath;
  final bool isPrimary;

  const SubscriptionCard({
    super.key,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.imagePath,
    required this.isPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 430,
      padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 12),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(235, 235, 235, 1),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
        border: Border.all(color: Colors.transparent), // Border.none equivalent
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            imagePath,
            height: 110,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              color: redcolor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SubscriptionScreen()));
                // Handle button press
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isPrimary ? redcolor : Colors.grey[200],
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: 14,
                  color: isPrimary ? Colors.white : redcolor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
