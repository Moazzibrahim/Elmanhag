import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/sessions_controller.dart';
import 'package:flutter_application_1/teacher/screens/lives_teacher_screen.dart';
import 'package:provider/provider.dart';

class HomeTeacherScreen extends StatefulWidget {
  const HomeTeacherScreen({super.key});

  @override
  State<HomeTeacherScreen> createState() => _HomeTeacherScreenState();
}

class _HomeTeacherScreenState extends State<HomeTeacherScreen> {
  @override
  void initState() {
    Provider.of<SessionsController>(context, listen: false)
        .fetchSessionsData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<SessionsController>(
          builder: (context, sessionsProvider, _) {
            if (sessionsProvider.sessionsData.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/boy.png',
                          width: 40,
                          height: 40,
                        ),
                        const Text(
                          'اهلا بك استاذ احمد',
                          style: TextStyle(
                            color: redcolor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: sessionsProvider.sessionsData.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => LivesTeacherScreen(
                                      title: sessionsProvider.sessionsData[index].name,
                                      lives: sessionsProvider.sessionsData[index].lives,
                                      image: sessionsProvider.sessionsData[index].image,
                                          ),));
                            },
                            child: Card(
                              shadowColor: redcolor,
                              color: Colors.white,
                              elevation: 3,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 50),
                                child: Center(
                                  child: Text(
                                    sessionsProvider.sessionsData[index].name,
                                    style: const TextStyle(
                                        color: redcolor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
