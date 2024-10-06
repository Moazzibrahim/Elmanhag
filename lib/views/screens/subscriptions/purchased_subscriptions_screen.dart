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
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                    const SizedBox(height: 30,),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset('assets/images/allsubjects.png'),
                        const Column(
                          children: [
                            Align(alignment: Alignment.topCenter,child: Text('كل المواد',style: TextStyle(fontSize: 20,color: redcolor),)),
                            SizedBox(height: 95,)
                          ],
                        )
                      ],
                    ),
                    Expanded(
                      child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 20,
                            ),
                            itemCount: subProvider.dataModelss!.subjects!.length,
                            itemBuilder: (context, index) {
                              final subject = subProvider.dataModelss!.subjects![index];
                              return Card(
                                color: theme.scaffoldBackgroundColor,
                                elevation: 3,
                                shadowColor: redcolor,
                                child: Stack(
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                      subject.name!,
                      style: const TextStyle(color: redcolor, fontSize: 20),
                                        ),
                                        const SizedBox(height: 7),
                                        Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(subProvider.dataModelss!.subjects![index].thumbnailUrl!),
                      ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
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