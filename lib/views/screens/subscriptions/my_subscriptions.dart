// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/live/purshased_live_controller.dart';
import 'package:flutter_application_1/controller/payment/payment_methods_provider.dart';
import 'package:flutter_application_1/views/screens/payment/fawry_payment_screen.dart';
import 'package:flutter_application_1/views/screens/subscriptions/purchased_subscriptions_screen.dart';
import 'package:provider/provider.dart';
import '../../../localization/app_localizations.dart';
import '../payment/subscription_screen.dart';

class MySubscriptions extends StatelessWidget {
  const MySubscriptions({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    bool isDarkMode = theme.brightness == Brightness.dark;
    final localization = AppLocalizations.of(context);

    return Scaffold(
      body: Consumer<PurshasedLiveController>(
        builder: (context, itemProvider, _) {
          if (itemProvider.dataModelss == null) {
            return Container(
              decoration: isDarkMode
                  ? const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/Ellipse 198.png'),
                        fit: BoxFit.cover,
                      ),
                    )
                  : null,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: redcolor,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          iconSize: 28.0,
                        ),
                        Text(
                          localization.translate("my_subscriptions"),
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: redcolor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20, // Increased font size for emphasis
                          ),
                        ),
                        const SizedBox(
                            width: 48), // Invisible space to balance the row
                      ],
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView(
                        children: [
                          SubscriptionCard(
                            title: localization.translate("materials_package"),
                            description:
                                localization.translate("materials_description"),
                            buttonText: localization.translate("subscribe_now"),
                            imagePath: 'assets/images/materials.png',
                            isPrimary: false,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container(
              decoration: isDarkMode
                  ? const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/Ellipse 198.png'),
                        fit: BoxFit.cover,
                      ),
                    )
                  : null,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: redcolor,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          iconSize: 28.0,
                        ),
                        Text(
                          localization.translate("my_subscriptions"),
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: redcolor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20, // Increased font size for emphasis
                          ),
                        ),
                        const SizedBox(
                            width: 48), // Invisible space to balance the row
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 450,
                      child: ListView(
                        children: const [
                  SubscriptionCard(
                  title: 'الباقة المدفوعة',
                  description: 'انت الان على الباقة المدفوعة تمتع بجميع المزايا',
                  buttonText: 'عرض',
                  imagePath: 'assets/images/paidpng.png',
                  isPrimary: true,
                  ),
                        ],
                      ),
                    ),
                    Consumer<PaymentMethodsProvider>(
                      builder: (context, provider, _) {
                        return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(onPressed: () async{
                            await provider.getSavedData();
                            if(provider.savedmerchantRefNumber == null){
                              Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SubscriptionScreen(),
                          ),
                        );
                            }else{
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (ctx)=> const FawryPaymentScreen())
                              );
                            }
                          }, 
                          style: ElevatedButton.styleFrom(
                            backgroundColor: redcolor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)
                            )
                          ),
                          child: const Text('اشترك الان',style: TextStyle(fontSize: 18),)),
                        ],
                      );
                      },
                    )
                  ],
                ),
              ),
            );
          }
        },
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
      margin: const EdgeInsets.symmetric(
          vertical: 10.0), // Add vertical margin between cards
      padding: const EdgeInsets.all(20.0), // Increased padding
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color.fromRGBO(49, 49, 49, 1)
            : const Color.fromRGBO(245, 245, 245, 1),
        borderRadius: BorderRadius.circular(20.0), // Softer, larger corners
        boxShadow: [
          BoxShadow(
            color: Colors.black
                .withOpacity(0.1), // Slightly more pronounced shadow
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // Center the content
        children: [
          ClipRRect(
            borderRadius:
                BorderRadius.circular(12.0), // Rounded corners for the image
            child: Image.asset(
              imagePath,
              height: 120, // Slightly larger image
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              color: redcolor,
              fontWeight: FontWeight.bold,
              fontSize: 20, // Larger title font size
            ),
            textAlign: TextAlign.center, // Center the title text
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: isDarkMode ? Colors.white70 : Colors.black87,
              fontSize: 16,
              height: 1.5, // Line height for better readability
            ),
            textAlign: TextAlign.center, // Center the description text
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (isPrimary) {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx)=> const PurchasedSubscriptionsScreen())
                  );
                }else{
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
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                shadowColor: isPrimary
                    ? Colors.redAccent.withOpacity(0.5)
                    : Colors.grey.withOpacity(0.5),
                elevation: 8, // Increased elevation for the button
              ),
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: 18, // Larger button text
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