import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/services.dart';
import 'package:flutter_application_1/controller/Auth/logout_provider.dart';
import 'package:flutter_application_1/controller/Locale_Provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/localization/app_localizations.dart';
import 'package:flutter_application_1/views/screens/profile/profile_screen.dart';
import 'package:flutter_application_1/views/widgets/home_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: redcolor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/tefl.png'),
                    radius: 40,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    localizations.translate('welcome Yousef'),
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
            // Add more ListTiles for additional drawer items here
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const SizedBox(height: 25),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => const CustomProfileScreen()));
                  },
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/tefl.png'),
                        radius: 20,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        localizations.translate('welcome Yousef'),
                        style: const TextStyle(
                          color: redcolor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Builder(
                  builder: (context) => IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Expanded(child: HomeGrid()),
          ],
        ),
      ),
    );
  }
}
