// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/services.dart';
import 'package:flutter_application_1/controller/Auth/logout_provider.dart';
import 'package:flutter_application_1/controller/Locale_Provider.dart';
import 'package:flutter_application_1/controller/profile/profile_provider.dart';
import 'package:flutter_application_1/controller/theme/theme_provider.dart';
import 'package:flutter_application_1/views/screens/subscriptions/my_subscriptions.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/localization/app_localizations.dart';
import 'package:flutter_application_1/views/screens/profile/profile_screen.dart';
import 'package:flutter_application_1/views/widgets/home_grid.dart';

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

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final localizations = AppLocalizations.of(context);
    final userProfileProvider = Provider.of<UserProfileProvider>(context);
    final user = userProfileProvider.user;
    final theme = Theme.of(context);

    return Scaffold(
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
                          backgroundImage: user.image != null
                              ? NetworkImage(user.image!)
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
                return ListTile(
                  leading: Icon(themeProvider.isDarkMode
                      ? Icons.light_mode
                      : Icons.dark_mode),
                  title: Text(localizations.translate("change_theme")),
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
                  MaterialPageRoute(builder: (ctx) => const MySubscriptions()),
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
                                          backgroundImage: user?.image != null
                                              ? NetworkImage(user!.image!)
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
                                      padding: const EdgeInsets.only(right: 15),
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
                            onPressed: () {
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
                                        backgroundImage: user?.image != null
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
                          onPressed: () {
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
    );
  }
}
