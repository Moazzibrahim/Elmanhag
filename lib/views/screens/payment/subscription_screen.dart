// ignore_for_file: library_private_types_in_public_api

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/bundle/get_bundle_data.dart';
import 'package:flutter_application_1/controller/profile/profile_provider.dart';
import 'package:flutter_application_1/localization/app_localizations.dart';
import 'package:flutter_application_1/models/bundle_model.dart';
import 'package:flutter_application_1/views/screens/payment/payment_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key, this.subjectId});
  final String? subjectId;

  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  int selectedBundleIndex = -1; // Track selected bundle index
  List<int> selectedSubjectsIndices = []; // Track selected subjects indices
  bool _isInitialized = false;
  String selectedItemPrice = '0';
  String service = '';
  int bundleid = 0;
  // List for selected subject IDs
  List<int> selectedSubjectIds = [];
  List<String> selectedSubjectPrices = [];
  List<double> selectedSubjectDiscounts = [];
  int selectedBundleId = 0;
  int selectedSubjectId = 0;

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
            coverPhoto: bundle.thumbnaillink,
            expiredDate: bundle.expiredDate,
            discount: (bundle.discounts?.isNotEmpty ?? false)
                ? bundle.discounts!.first.amount
                : 0,
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
                              ' ${localizations.translate('welcome')} ${user!.name} ${user.studentJob != null ? user.studentJob!.job : ''}',
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
                        backgroundImage: NetworkImage('${user.imageLink}'),
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
                        bool isBundle = item.type == 'bundle';
                        bool isHighlighted = isBundle
                            ? index == selectedBundleIndex
                            : selectedSubjectsIndices.contains(index);
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
                          isHighlighted: isHighlighted,
                          isBundle: isBundle,
                        );
                      },
                    ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: redcolor,
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 120)),
                      onPressed: () {
                        // Clear the lists before adding new selections
                        selectedSubjectIds.clear();
                        selectedSubjectPrices.clear();
                        selectedSubjectDiscounts.clear();

                        // Add selected bundles/subjects based on the selection
                        if (selectedBundleIndex != -1) {
                          // A bundle is selected
                          final bundle = combinedList[selectedBundleIndex];
                          selectedSubjectIds.add(bundle.id!);
                          selectedSubjectPrices.add(bundle.price!);
                          selectedSubjectDiscounts.add(bundle.discount!);
                        } else {
                          // Subjects are selected
                          for (var index in selectedSubjectsIndices) {
                            final subject = combinedList[index];
                            selectedSubjectIds.add(subject.id!);
                            selectedSubjectPrices.add(subject.price!);
                            selectedSubjectDiscounts.add(subject.discount!);
                          }
                        }

                        // Log the selected data for debugging
                        log('Selected Subject IDs: $selectedSubjectIds');
                        log('Selected Subject Prices: $selectedSubjectPrices');
                        log('Selected Subject Discounts: $selectedSubjectDiscounts');
                        log('service:$service');

                        // Navigate to PaymentScreen and pass the selected data
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentScreen(
                              selectedSubjectIds: selectedSubjectIds,
                              selectedPrices: selectedSubjectPrices,
                              selectedDiscounts: selectedSubjectDiscounts,
                              itemservice: service,
                              itemidbundle: selectedBundleId,
                              itemidsubject: selectedSubjectId,
                              itemdiscount: 0,
                              itemprice: '',
                            ),
                          ),
                        );
                      },
                      child: Text(
                        localizations.translate('next'),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 22),
                      ))
                ],
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
    required bool isHighlighted,
    required bool isBundle,
  }) {
    final int priceAsInt = double.tryParse(price)?.toInt() ?? 0;
    final int discountAsInt = discount.toInt();
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
            coverPhoto: bundle.coverphotolink,
            expiredDate: bundle.expiredDate,
            discount: (bundle.discounts?.isNotEmpty ?? false)
                ? bundle.discounts!.first.amount
                : 0,
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
                    : 0,
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
                    : 0,
                type: 'subject',
              ))),
    ];

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isBundle) {
            // Only one bundle can be selected, so deselect subjects
            selectedBundleIndex = selectedBundleIndex == index ? -1 : index;
            selectedSubjectsIndices.clear(); // Deselect all subjects
            service = 'Bundle';
          } else {
            // Allow multiple subjects but deselect bundle
            if (selectedBundleIndex != -1) {
              selectedBundleIndex = -1; // Deselect the bundle
            }
            if (selectedSubjectsIndices.contains(index)) {
              selectedSubjectsIndices.remove(index); // Deselect subject
            } else {
              selectedSubjectsIndices.add(index); // Select subject
              service = 'Subject';
            }
          }
        });
      },
      child: Card(
        elevation: isHighlighted ? 12 : 4,
        color: isHighlighted ? Colors.red.shade100 : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: isHighlighted ? color : Colors.red.shade700),
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
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 13)),
              const SizedBox(height: 5),

              // Check if discount exists, otherwise show only the price
              if (discountAsInt > 0) ...[
                Text(
                  '${priceAsInt - discountAsInt} EGP', // Display discount percentage
                  style: const TextStyle(
                    color: redcolor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  localizations.translate('instead_of'),
                  style: const TextStyle(color: redcolor),
                ),
                SizedBox(height: 5.h),
                Text(
                  '$priceAsInt EGP',
                  style: TextStyle(
                    color: redcolor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ] else ...[
                // Show the price only
                Text(
                  '$priceAsInt EGP',
                  style: TextStyle(
                    color: redcolor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
              const SizedBox(height: 5),
              const Divider(
                color: redcolor,
                thickness: 2,
              ),
              SizedBox(
                height: 45.h,
                width: 680.w,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: redcolor,
                      padding: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 24.w),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    onPressed: selectedBundleIndex != -1 ||
                            selectedSubjectsIndices.isNotEmpty
                        ? () {
                            if (selectedBundleIndex != -1) {
                              final selectedBundle =
                                  combinedList[selectedBundleIndex];
                              selectedItemPrice = selectedBundle.price ?? '0';
                              service = 'Bundle';
                            } else if (selectedSubjectsIndices.isNotEmpty) {
                              // Handle selected subjects logic
                              final selectedSubject =
                                  combinedList[selectedSubjectsIndices.first];
                              selectedItemPrice = selectedSubject.price ?? '0';
                              service = 'Subject';
                            }
                            log('bundle id: $bundleid');
                            log('service: $service');
                            log('price: $selectedItemPrice');
                            log("discount: $discountAsInt");
                            // Clear the lists before adding new selections
                            selectedSubjectIds.clear();
                            selectedSubjectPrices.clear();
                            selectedSubjectDiscounts.clear();

                            // Add selected bundles/subjects based on the selection
                            if (selectedBundleIndex != -1) {
                              // A bundle is selected
                              final bundle = combinedList[selectedBundleIndex];
                              selectedBundleId = bundle.id!;
                              selectedSubjectIds.add(bundle.id!);
                              selectedSubjectPrices.add(bundle.price!);
                              selectedSubjectDiscounts.add(bundle.discount!);
                            } else {
                              // Subjects are selected
                              for (var index in selectedSubjectsIndices) {
                                final subject = combinedList[index];
                                selectedSubjectId = subject.id!;
                                selectedSubjectIds.add(subject.id!);
                                selectedSubjectPrices.add(subject.price!);
                                selectedSubjectDiscounts.add(subject.discount!);
                              }
                            }

                            // Log the selected data for debugging
                            log('Selected Subject IDs: $selectedSubjectIds');
                            log('Selected Subject Prices: $selectedSubjectPrices');
                            log('Selected Subject Discounts: $selectedSubjectDiscounts');
                            log('service: $service');
                            log("sub id: $selectedSubjectId");
                            log('bundle id: $selectedBundleId');

                            // Navigate to PaymentScreen and pass the selected data
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaymentScreen(
                                  selectedSubjectIds: selectedSubjectIds,
                                  selectedPrices: selectedSubjectPrices,
                                  selectedDiscounts: selectedSubjectDiscounts,
                                  itemservice: service,
                                  itemdiscount: discountAsInt,
                                  itemidbundle: selectedBundleId,
                                  itemidsubject: selectedSubjectId,
                                  itemprice: '',
                                ),
                              ),
                            );
                          }
                        : null,
                    child: Text(
                      localizations.translate('subscripe_now'),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17.sp,
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
