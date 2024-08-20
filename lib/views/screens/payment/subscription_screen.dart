import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/views/screens/payment/payment_screen.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  int selectedCardIndex = -1; // Track selected card index

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60), // Adjust the height as needed
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: redcolor),
            onPressed: () {
              // Handle back action
              Navigator.pop(context);
            },
          ),
          title: const Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'اهلا بك محمد',
                      style: TextStyle(
                        color: redcolor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'الصف الرابع لغات',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              CircleAvatar(
                radius: 20, // Adjust the radius as needed
                backgroundImage: AssetImage(
                    'assets/images/tefl.png'), // Replace with your asset
              ),
            ],
          ),
          centerTitle: false,
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    'اشتراك واحد يفتح لك باباً واسعاً من المعرفة',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildSubscriptionCard(
                        context,
                        index: 0,
                        title: 'ماده العلوم',
                        price: '300',
                        oldPrice: '350',
                        color: redcolor,
                      ),
                      buildSubscriptionCard(
                        context,
                        index: 1,
                        title: 'كل المواد',
                        price: '1000',
                        oldPrice: '1500',
                        color: redcolor,
                        isHighlighted: true,
                      ),
                    ],
                  ),
                  const SizedBox(
                      height:
                          80), // Adding space to avoid content overlapping with button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'استمتع بتجربة تعليمية شاملة: فيديوهات، واجبات، مراجعات، وحصص لايف لكل الدروس',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: redcolor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'التالي',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSubscriptionCard(
    BuildContext context, {
    required int index,
    required String title,
    required String price,
    required String oldPrice,
    required Color color,
    bool isHighlighted = false,
  }) {
    bool isSelected =
        index == selectedCardIndex; // Check if the card is selected

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCardIndex = index; // Set selected card
        });
      },
      child: Card(
        elevation: isSelected ? 12 : 4,
        color: isSelected
            ? Colors.red.shade100
            : Colors.white, // Change color when selected
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: isSelected ? redcolor : Colors.grey.shade300),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.42,
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18),
              ),
              const SizedBox(height: 16),
              Text(
                '$price جنيه',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: color, fontSize: 22),
              ),
              Text(
                'بدلاً من',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
              ),
              Text(
                '$oldPrice جنيه',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: isSelected ? redcolor : redcolor,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  shadowColor: Colors.black.withOpacity(0.2),
                  elevation: 6,
                ),
                child: const Text(
                  'اشترك الان',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
