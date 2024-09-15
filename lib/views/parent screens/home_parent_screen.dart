import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/Auth/login_provider.dart';
import 'package:flutter_application_1/controller/Auth/logout_provider.dart';
import 'package:flutter_application_1/localization/app_localizations.dart';
import 'package:flutter_application_1/views/parent%20screens/notfications_parent_screen.dart';
import 'package:flutter_application_1/views/parent%20widgets/home_parent_grid.dart';
import 'package:flutter_application_1/views/screens/profile/profile_screen.dart';
import 'package:provider/provider.dart'; // Import Provider

class HomeParentScreen extends StatelessWidget {
  final String? childname;
  final String? childcategory;
  final String? imagelnk;
  const HomeParentScreen(
      {super.key, this.childcategory, this.childname, this.imagelnk});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        // Invoke the logout function
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const CustomProfileScreen()));
                      },
                      child: const Icon(
                        Icons.person, // Replace with logout icon
                        color: redcolor,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () async {
                        // Invoke the logout function
                        await Provider.of<LogoutModel>(context, listen: false)
                            .logout(context);
                      },
                      child: const Icon(
                        Icons.logout, // Replace with logout icon
                        color: redcolor,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) =>
                                const NotficationsParentScreen()));
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: const Icon(
                        Icons.notifications_outlined,
                        color: redcolor,
                      ),
                    )
                  ],
                ),
                Consumer<LoginModel>(
                  builder: (context, loginProvider, child) {
                    return Row(
                      children: [
                        Text(
                          ' ${localizations.translate('welcome')} $childname ${loginProvider.name}',
                          style: const TextStyle(
                              color: redcolor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              '$imagelnk'), // Replace with actual image asset or network image
                          radius: 20,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 7,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('$childcategory'),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Expanded(child: HomeParentGrid()),
          ],
        ),
      ),
    );
  }
}
