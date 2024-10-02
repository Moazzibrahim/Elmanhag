// ignore_for_file: unnecessary_string_interpolations, use_build_context_synchronously, unused_element, deprecated_member_use, avoid_print
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/services.dart';
import 'package:flutter_application_1/affiliate/views/affiliate_home_screen.dart';
import 'package:flutter_application_1/controller/Auth/login_provider.dart';
import 'package:flutter_application_1/controller/Auth/logout_provider.dart';
import 'package:flutter_application_1/controller/Locale_Provider.dart';
import 'package:flutter_application_1/controller/live/purshased_live_controller.dart';
import 'package:flutter_application_1/controller/profile/profile_provider.dart';
import 'package:flutter_application_1/controller/theme/theme_provider.dart';
import 'package:flutter_application_1/views/screens/curriculum/allcurriculum/filter_curriclums_screen.dart';
import 'package:flutter_application_1/views/screens/subscriptions/my_subscriptions.dart';
import 'package:flutter_application_1/views/screens/suggestions_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/localization/app_localizations.dart';
import 'package:flutter_application_1/views/screens/profile/profile_screen.dart';
import 'package:flutter_application_1/views/widgets/home_grid.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isInitialized = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isInitialized) {
        Provider.of<UserProfileProvider>(context, listen: false)
            .fetchUserProfile(context);
        _isInitialized = true;
      }
    });
    super.initState();
  }

  Future<void> becomeAffiliate(BuildContext context) async {
    final url = Uri.parse("https://bdev.elmanhag.shop/api/createAffilate");
    final token = Provider.of<TokenModel>(context, listen: false).token;
    final userId = Provider.of<LoginModel>(context, listen: false).id;

    // Log the user ID for debugging purposes
    log("User ID: $userId");

    // Check if the userId is null before proceeding
    if (userId == null) {
      _showSnackbar(context, 'User ID is not available. Please log in again.');
      return; // Exit the method if the user ID is null
    }

    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "user_id": userId,
        }),
      );

      // Dismiss loading indicator
      Navigator.of(context).pop();

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final affiliateCode = data['affilate_code'];
        log('Affiliate Code: $affiliateCode');
        // Navigate to AffiliateHomeScreen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const AffiliateHomeScreen(),
          ),
        );
      } else {
        _showSnackbar(context,
            'failed due to internet connection: ${response.statusCode}');
      }
    } catch (e) {
      // Dismiss loading indicator on error
      Navigator.of(context).pop();
      log('Error occurred: $e'); // Log error for debugging
      _showSnackbar(context, 'Error: $e');
    }
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final localizations = AppLocalizations.of(context);
    final userProfileProvider = Provider.of<UserProfileProvider>(context);
    final user = userProfileProvider.user;
    final theme = Theme.of(context);

    return WillPopScope(
      onWillPop: () async {
        return Future.value(false); // Prevent back navigation
      },
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: redcolor,
                ),
                child: user == null
                    ? const CircularProgressIndicator()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundImage: user.imageLink != null
                                ? NetworkImage(user.imageLink!)
                                : null,
                            radius: 40,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '${localizations.translate('welcome')} ${user.name ?? ''}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: Text(localizations.translate('profile')),
                onTap: () {
                  Navigator.pop(context); // Close the drawer first
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => const CustomProfileScreen()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.language),
                title: Text(localizations.translate('change_language')),
                onTap: () {
                  if (localeProvider.locale.languageCode == 'ar') {
                    localeProvider.setLocale(const Locale('en'));
                  } else {
                    localeProvider.setLocale(const Locale('ar'));
                  }
                  Navigator.pop(context); // Close the drawer
                },
              ),
              Consumer<ThemeProvider>(
                builder: (context, themeProvider, child) {
                  final isDarkMode = themeProvider.isDarkMode;
                  final themeText = isDarkMode
                      ? localizations.translate(
                          'light_mode') // Show 'Light Mode' if currently dark mode
                      : localizations.translate(
                          'dark_mode'); // Show 'Dark Mode' if currently light mode

                  return ListTile(
                    leading:
                        Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
                    title: Text(themeText),
                    onTap: () {
                      themeProvider.toggleTheme();
                      Navigator.pop(context); // Close the drawer
                    },
                  );
                },
              ),

              ListTile(
                leading: const Icon(Icons.subscriptions),
                title: Text(localizations.translate('my_subscriptions')),
                onTap: () {
                  Navigator.pop(context); // Close the drawer first
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (ctx) => const MySubscriptions()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.book),
                title: Text(
                    AppLocalizations.of(context).translate('all_curriculums')),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FilterCurriculumsScreen()),
                  );
                },
              ),
              ListTile(
                leading: SizedBox(
                  height: 30,
                  width: 30,
                  child: Image.asset('assets/images/dollar.png'),
                ),
                title: Text(
                    AppLocalizations.of(context).translate('become_affilate')),
                onTap: () {
                  becomeAffiliate(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.feedback),
                title: Text(
                    '${localizations.translate('Complaints and suggestions')}'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (ctx) => const ComplaintsSuggestionsScreen()),
                  );
                },
              ),
              Consumer<LogoutModel>(
                builder: (context, logoutModel, child) {
                  return ListTile(
                    leading: const Icon(Icons.logout),
                    title: Text(
                      localizations.translate('logOut'),
                    ),
                    onTap: () async {
                      await logoutModel.logout(context);
                    },
                  );
                },
              ),
              // Remove or comment out this ListTile to exclude account deletion
              // ListTile(
              //   leading: const Icon(Icons.delete),
              //   title: Text(localizations.translate('delete_account')),
              //   onTap: () {
              //     // Get token
              //     showDeleteConfirmationDialog(context);
              //   },
              // ),
            ],
          ),
        ),
        body: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return themeProvider.isDarkMode
                ? Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/Ellipse 198.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 25),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                const CustomProfileScreen()));
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundImage: user?.imageLink !=
                                                    null
                                                ? NetworkImage(user!.imageLink!)
                                                : null,
                                            radius: 20,
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            '${localizations.translate('welcome')} ${user?.name ?? ''}',
                                            style: const TextStyle(
                                              color: redcolor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15),
                                        child: Text(
                                          '${user?.category?.name ?? ''}', // Safe access with null checks
                                          style: const TextStyle(
                                            color: redcolor,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.menu),
                                onPressed: () {
                                  Scaffold.of(context).openDrawer();
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Expanded(child: HomeGrid()),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.all(6),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.scaffoldBackgroundColor,
                                shadowColor: redcolor,
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              onPressed: () async {
                                await Provider.of<PurshasedLiveController>(
                                        context,
                                        listen: false)
                                    .getLiveDatapurshased(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MySubscriptions()));
                              },
                              child: Center(
                                child: Text(
                                  localizations.translate('my_subscriptions'),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: redcolor,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 25),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) =>
                                          const CustomProfileScreen()));
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: user?.imageLink !=
                                                  null
                                              ? NetworkImage(user!.imageLink!)
                                              : null,
                                          radius: 20,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          '${localizations.translate('welcome')} ${user?.studentJob?.job ?? ''} ${user?.name ?? ''}',
                                          style: const TextStyle(
                                            color: redcolor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        right: 15,
                                      ),
                                      child: Text(
                                        '${user?.category?.name ?? ''}', // Safe access with null checks
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.menu),
                              onPressed: () {
                                Scaffold.of(context).openDrawer();
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Expanded(child: HomeGrid()),
                        Container(
                          padding: const EdgeInsets.all(6),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.scaffoldBackgroundColor,
                              shadowColor: redcolor,
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: () async {
                              await Provider.of<PurshasedLiveController>(
                                      context,
                                      listen: false)
                                  .getLiveDatapurshased(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MySubscriptions()));
                            },
                            child: Center(
                              child: Text(
                                localizations.translate('my_subscriptions'),
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: redcolor,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
