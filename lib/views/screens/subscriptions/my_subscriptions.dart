import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import '../payment/subscription_screen.dart';

class MySubscriptions extends StatelessWidget {
  const MySubscriptions({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    bool isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: isDarkMode
            ? const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Ellipse 198.png'),
                  fit: BoxFit.cover,
                ),
              )
            : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: redcolor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  "اشتراكاتي",
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: redcolor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: const [
                    SubscriptionCard(
                      title: 'باقه المواد',
                      description:
                          'انت الان على الباقه المجانيه. انتقل إلى الباقه المدفوعه للحصول على المواد المتقدمه بسعر 1500 جنيه لكل المواد بدلاً من 2600 جنيه.',
                      buttonText: 'اشترك الآن',
                      imagePath: 'assets/images/materials.png',
                      isPrimary: true,
                    ),
                    //  SizedBox(height: 16),
                    //  SubscriptionCard(
                    //   title: 'باقه حصص اللايف',
                    //   description:
                    //       'انت الان على الباقه المجانيه. تمتع بمزايا الباقه المدفوعه الآن.',
                    //   buttonText: 'انت على الباقه المدفوعه',
                    //   imagePath: 'assets/images/live_sessions.png',
                    //   isPrimary: false,
                    // ),
                  ],
                ),
              ),
            ],
          ),
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
    final theme = Theme.of(context);
    bool isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color.fromRGBO(49, 49, 49, 1)
            : const Color.fromRGBO(245, 245, 245, 1),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            imagePath,
            height: 100,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              color: redcolor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: isDarkMode ? Colors.white70 : Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (isPrimary) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SubscriptionScreen(),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isPrimary ? redcolor : Colors.grey[300],
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: 16,
                  color: isPrimary ? Colors.white : redcolor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
