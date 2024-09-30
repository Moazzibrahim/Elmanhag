import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/live/purshased_live_controller.dart';
import 'package:flutter_application_1/localization/app_localizations.dart';
import 'package:provider/provider.dart';

class PurchasedSubscriptionsScreen extends StatelessWidget {
  const PurchasedSubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    bool isDarkMode = theme.brightness == Brightness.dark;
    final localization = AppLocalizations.of(context);
    return Scaffold(
      body: Consumer<PurshasedLiveController>(
        builder: (context, subProvider, _) {
          if (subProvider.dataModelss != null) {
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
                        const SizedBox(width: 48), // Invisible space to balance the row
                      ],
                    ),
                  ],
                ),
              ),
            );
          }else{
            return const Center(
              child: CircularProgressIndicator(color: redcolor,),
            );
          }
        },
      ),
    );
  }
}