import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/Auth/login_provider.dart';
import 'package:flutter_application_1/controller/Auth/logout_provider.dart';
import 'package:flutter_application_1/localization/app_localizations.dart';
import 'package:flutter_application_1/views/parent%20screens/notfications_parent_screen.dart';
import 'package:flutter_application_1/views/parent%20screens/profile/profile_parent_screen.dart';
import 'package:flutter_application_1/views/parent%20widgets/home_parent_grid.dart';
import 'package:provider/provider.dart'; // Import Provider
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeParentScreen extends StatelessWidget {
  final String? childname;
  final String? childcategory;
  final String? imagelnk;
  final String? phonechild;
  final String? emailchild;
  final String? childeducation;
  final String? childcountry;
  final String? childcity;
  final String? parentname;
  final int? childid;

  const HomeParentScreen(
      {super.key,
      this.childcategory,
      this.childname,
      this.imagelnk,
      this.childcity,
      this.childcountry,
      this.childeducation,
      this.emailchild,
      this.phonechild,
      this.parentname,
      this.childid});

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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CustomProfileParentScreen(
                                      childcategory: childcategory,
                                      childcity: childcity,
                                      childcountry: childcountry,
                                      childeducation: childeducation,
                                      childname: childname,
                                      emailchild: emailchild,
                                      imagelnk: imagelnk,
                                      phonechild: phonechild,
                                      parentname: parentname,
                                    )));
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
                    FutureBuilder<int>(
                      future: _fetchNotificationCount(context),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Icon(Icons.notifications_outlined,
                              color: redcolor);
                        } else if (snapshot.hasError) {
                          return const Icon(Icons.notifications_outlined,
                              color: redcolor);
                        } else if (snapshot.hasData && snapshot.data! > 0) {
                          return Stack(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) =>
                                          NotificationsParentScreen(
                                            childId: childid,
                                          )));
                                },
                                icon: const Icon(
                                  Icons.notifications_outlined,
                                  color: redcolor,
                                ),
                              ),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  constraints: const BoxConstraints(
                                    minWidth: 18,
                                    minHeight: 18,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${snapshot.data}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => NotificationsParentScreen(
                                        childId: childid,
                                      )));
                            },
                            icon: const Icon(
                              Icons.notifications_outlined,
                              color: redcolor,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
                Consumer<LoginModel>(
                  builder: (context, loginProvider, child) {
                    return Row(
                      children: [
                        Text(
                          ' ${localizations.translate('welcome')} $childname ',
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
            Expanded(
                child: HomeParentGrid(
              selchid: childid,
            )),
          ],
        ),
      ),
    );
  }

  Future<int> _fetchNotificationCount(BuildContext context) async {
    final String url =
        'https://bdev.elmanhag.shop/parent/notification?student_id=$childid';
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final String? token = tokenProvider.token;

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        int oldHomeworkCount = data['old_homework']?.length ?? 0;
        int dueHomeworkCount = data['due_homework']?.length ?? 0;
        return oldHomeworkCount + dueHomeworkCount;
      } else {
        throw Exception(
            'Failed to load subjects. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching subjects: $e');
    }
  }
}
