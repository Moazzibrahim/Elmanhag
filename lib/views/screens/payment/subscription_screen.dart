// ignore_for_file: unused_local_variable, library_private_types_in_public_api

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/bundle/get_bundle_data.dart';
import 'package:flutter_application_1/controller/profile/profile_provider.dart';
import 'package:flutter_application_1/localization/app_localizations.dart';
import 'package:flutter_application_1/models/bundle_model.dart';
import 'package:flutter_application_1/views/screens/payment/payment_screen.dart';
import 'package:provider/provider.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key, this.subjectId});
  final String? subjectId;

  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  int selectedCardIndex = -1; // Track selected card index
  bool _isInitialized = false;
  String selectedItemPrice = '0';
  String service = '';
  int bundleid = 0;
  int subid = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isInitialized) {
        Provider.of<UserProfileProvider>(context, listen: false)
            .fetchUserProfile(context);
        _isInitialized = true;
        Provider.of<GetBundleData>(context, listen: false)
            .fetchMainModel(context);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final userProfileProvider = Provider.of<UserProfileProvider>(context);
    final user = userProfileProvider.user;
    final localizations = AppLocalizations.of(context);
    final bundleDataProvider = Provider.of<GetBundleData>(context);
    List<Bundle> bundles = bundleDataProvider.getBundles() ?? [];
    List<Subject> subjects = bundleDataProvider.getSubjects() ?? [];
    List<Subject> filteredSubject = subjects
        .where(
          (element) => element.id.toString() == widget.subjectId,
        )
        .toList();

    // Combine bundles and subjects into a single list
    final combinedList = [
      ...bundles.map((bundle) => BundleSubjectItem(
            id: bundle.id,
            name: bundle.name,
            price: bundle.price.toString(),
            description: bundle.description,
            coverPhoto: bundle.coverPhoto,
            expiredDate: bundle.expiredDate,
            type: 'bundle',
          )),
      ...(widget.subjectId == null
          ? subjects.map((subject) => BundleSubjectItem(
                id: subject.id,
                name: subject.name,
                price: subject.price.toString(),
                description: subject.description,
                coverPhoto: subject.coverPhotoUrl,
                expiredDate: subject.expiredDate,
                type: 'subject',
              ))
          : filteredSubject.map((subject) => BundleSubjectItem(
                id: subject.id,
                name: subject.name,
                price: subject.price.toString(),
                description: subject.description,
                coverPhoto: subject.coverPhotoUrl,
                expiredDate: subject.expiredDate,
                type: 'subject',
              ))),
    ];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          if (isDarkMode)
            Positioned.fill(
              child: Image.asset(
                'assets/images/Ellipse 198.png',
                fit: BoxFit.cover,
              ),
            ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 35),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios, color: redcolor),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ' ${localizations.translate('welcome')} ${user!.name}',
                              style: const TextStyle(
                                color: redcolor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              ' ${user.category!.name} ',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.textTheme.bodyMedium?.color
                                    ?.withOpacity(0.6),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage('${user.image}'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'اشتراك واحد يفتح لك باباً واسعاً من المعرفة',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.textTheme.bodyLarge?.color?.withOpacity(0.7),
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 30),
                  if (combinedList.isNotEmpty)
                    SizedBox(
                      height: 350, // Adjust the height as needed
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: combinedList.length,
                        itemBuilder: (context, index) {
                          final item = combinedList[index];
                          return Container(
                            width: 250, // Fixed width for horizontal scrolling
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: buildSubscriptionCard(
                              context,
                              index: index,
                              title: item.name ?? 'No Name',
                              price: item.price ?? '0',
                              description: item.description ?? 'No Description',
                              coverPhoto: item.coverPhoto ?? '',
                              expiredDate: item.expiredDate ?? 'No Expiry Date',
                              color: theme.primaryColor,
                              isHighlighted: index == selectedCardIndex,
                            ),
                          );
                        },
                      ),
                    ),
                  const SizedBox(height: 57),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'استمتع بتجربة تعليمية شاملة: فيديوهات، واجبات، مراجعات، وحصص لايف لكل الدروس',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color:
                            theme.textTheme.bodyLarge?.color?.withOpacity(0.7),
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
                  onPressed: selectedCardIndex != -1
                      ? () {
                          final selectedItem = combinedList[selectedCardIndex];

                          // Set selected item price
                          selectedItemPrice = selectedItem.price ?? '0';

                          // Determine service type based on the selected item type (bundle or subject)
                          service = selectedItem.type == 'bundle'
                              ? 'Bundle'
                              : 'Subject';
                          if (selectedItem.type == 'bundle') {
                            bundleid = selectedItem.id!;
                            subid = 0;
                          } else {
                            subid = selectedItem.id!;
                            bundleid = 0;
                          }
                          log('bundle id: $bundleid');
                          log('subid:$subid');
                          log('service: $service');
                          log('price: $selectedItemPrice');

                          // Navigate to PaymentScreen, passing itemid, price, and service
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaymentScreen(
                                itemidbundle: bundleid,
                                itemidsubject: subid,
                                itemprice: selectedItemPrice, // Pass price
                                itemservice: service, // Pass service type
                              ),
                            ),
                          );
                        }
                      : null, // Disable button if no card is selected
                  style: ElevatedButton.styleFrom(
                    backgroundColor: redcolor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    localizations.translate('next'),
                    style: const TextStyle(
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
    );
  }

  Widget buildSubscriptionCard(
    BuildContext context, {
    required int index,
    required String title,
    required String price,
    required String description,
    required String coverPhoto,
    required String expiredDate,
    required Color color,
    bool isHighlighted = false,
  }) {
    final theme = Theme.of(context);
    bool isSelected = index == selectedCardIndex;
    final localizations = AppLocalizations.of(context);
    final bundleDataProvider = Provider.of<GetBundleData>(context);
    final bundles = bundleDataProvider.getBundles() ?? [];
    final subjects = bundleDataProvider.getSubjects() ?? [];

    // Combine bundles and subjects into a single list
    final combinedList = [
      ...bundles.map((bundle) => BundleSubjectItem(
            id: bundle.id,
            name: bundle.name,
            price: bundle.price.toString(),
            description: bundle.description,
            coverPhoto: bundle.coverPhoto,
            expiredDate: bundle.expiredDate,
            type: 'bundle',
          )),
      ...subjects.map((subject) => BundleSubjectItem(
            id: subject.id,
            name: subject.name,
            price: subject.price.toString(),
            description: subject.description,
            coverPhoto: subject.coverPhotoUrl,
            expiredDate: subject.expiredDate,
            type: 'subject',
          )),
    ];

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCardIndex = index; // Set selected card
        });
      },
      child: Card(
        elevation: isSelected ? 12 : 4,
        color: isSelected ? Colors.red.shade100 : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: isSelected ? color : Colors.red.shade700),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(coverPhoto),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isSelected ? redcolor : theme.primaryColor,
                    fontSize: 15),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'السعر: $price جنيه',
                style: theme.textTheme.bodyMedium
                    ?.copyWith(color: Colors.black, fontSize: 15),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.textTheme.bodySmall?.color?.withOpacity(0.8),
                    fontSize: 13),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'تاريخ الانتهاء: $expiredDate',
                style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.textTheme.bodySmall?.color?.withOpacity(0.8),
                    fontSize: 15),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: redcolor),
                onPressed: () {
                  final selectedItem = combinedList[index];
                  selectedItemPrice = selectedItem.price!;
                  service =
                      selectedItem.type == 'bundle' ? 'Bundle' : 'Subject';
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentScreen(
                        itemidbundle: bundleid,
                        itemidsubject: subid,
                        itemprice: selectedItemPrice,
                        itemservice: service,
                      ),
                    ),
                  );
                },
                child: Text(
                  localizations.translate('subscripe_now'),
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BundleSubjectItem {
  final int? id;
  final String? name;
  final String? price;
  final String? description;
  final String? coverPhoto;
  final String? expiredDate;
  final String type;

  BundleSubjectItem({
    this.id,
    this.name,
    this.price,
    this.description,
    this.coverPhoto,
    this.expiredDate,
    required this.type,
  });
}
