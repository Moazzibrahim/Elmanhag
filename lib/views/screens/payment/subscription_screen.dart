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
  int selectedCardIndex = -1;
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

    final combinedList = [
      ...bundles.map((bundle) => BundleSubjectItem(
            id: bundle.id,
            name: bundle.name,
            price: bundle.price.toString(),
            description: bundle.description,
            coverPhoto: bundle.coverPhoto,
            expiredDate: bundle.expiredDate,
            discount: bundle.discount,
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
                discount: subject.discounts?.isNotEmpty ?? false
                    ? subject.discounts!.first.amount
                    : 0, // Use the first discount amount if available
                type: 'subject',
              ))
          : filteredSubject.map((subject) => BundleSubjectItem(
                id: subject.id,
                name: subject.name,
                price: subject.price.toString(),
                description: subject.description,
                coverPhoto: subject.coverPhotoUrl,
                expiredDate: subject.expiredDate,
                discount: subject.discounts?.isNotEmpty ?? false
                    ? subject.discounts!.first.amount
                    : 0, // Use the first discount amount if available
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
                              ' ${localizations.translate('welcome')} ${user!.name} ${user.studentJob!.job}',
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
                  const SizedBox(height: 14),
                  if (combinedList.isNotEmpty)
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Two items per row
                        crossAxisSpacing: 20.0,
                        mainAxisSpacing: 20.0,
                        childAspectRatio: 0.52, // Adjust height-to-width ratio
                      ),
                      itemCount: combinedList.length,
                      itemBuilder: (context, index) {
                        if (index >= combinedList.length) {
                          // Return an empty container if the index is out of bounds
                          return Container();
                        }
                        final item = combinedList[index];
                        return buildSubscriptionCard(
                          context,
                          index: index,
                          title: item.name ?? 'No Name',
                          price: item.price ?? '0',
                          discount: item.discount!,
                          description: item.description ?? 'No Description',
                          coverPhoto: item.coverPhoto ?? '',
                          expiredDate: item.expiredDate ?? 'No Expiry Date',
                          color: theme.primaryColor,
                          isHighlighted: index == selectedCardIndex,
                        );
                      },
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
                          selectedItemPrice = selectedItem.price ?? '0';
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
                        }
                      : null,
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
    required double discount,
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
    List<Bundle> bundles = bundleDataProvider.getBundles() ?? [];
    List<Subject> subjects = bundleDataProvider.getSubjects() ?? [];
    List<Subject> filteredSubject = subjects
        .where(
          (element) => element.id.toString() == widget.subjectId,
        )
        .toList();

    final combinedList = [
      ...bundles.map((bundle) => BundleSubjectItem(
            id: bundle.id,
            name: bundle.name,
            price: bundle.price.toString(),
            description: bundle.description,
            coverPhoto: bundle.coverPhoto,
            expiredDate: bundle.expiredDate,
            discount: bundle.discount,
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
                discount: subject.discounts?.isNotEmpty ?? false
                    ? subject.discounts!.first.amount
                    : 0, // Use the first discount amount if available
                type: 'subject',
              ))
          : filteredSubject.map((subject) => BundleSubjectItem(
                id: subject.id,
                name: subject.name,
                price: subject.price.toString(),
                description: subject.description,
                coverPhoto: subject.coverPhotoUrl,
                expiredDate: subject.expiredDate,
                discount: subject.discounts?.isNotEmpty ?? false
                    ? subject.discounts!.first.amount
                    : 0, // Use the first discount amount if available
                type: 'subject',
              ))),
    ];

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCardIndex = index;
        });
      },
      child: Card(
        elevation: isSelected ? 12 : 4,
        color: isSelected ? Colors.red.shade100 : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: isSelected ? color : Colors.red.shade700),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: NetworkImage(coverPhoto),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.textTheme.bodyLarge?.color,
                ),
              ),
              const SizedBox(height: 8),
              if (discount > 0)
                Text(
                  '$discount', // Display discount percentage
                  style: const TextStyle(
                    color: redcolor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              const SizedBox(height: 8),
              Text(
                localizations.translate('instead_of'),
                style: const TextStyle(color: redcolor),
              ),
              const SizedBox(height: 8),
              Text(
                price,
                style: const TextStyle(
                  color: redcolor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              const SizedBox(height: 8),
              const Divider(
                color: redcolor,
                thickness: 2,
              ),
              SizedBox(
                height: 60,
                width: 700,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: redcolor),
                    onPressed: selectedCardIndex != -1
                        ? () {
                            final selectedItem =
                                combinedList[selectedCardIndex];
                            selectedItemPrice = selectedItem.price ?? '0';
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
                          }
                        : null,
                    child: Text(
                      localizations.translate('subscripe_now'),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    )),
              )
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
  final double? discount;

  BundleSubjectItem({
    this.id,
    this.name,
    this.price,
    this.description,
    this.coverPhoto,
    this.expiredDate,
    this.discount,
    required this.type,
  });
}
