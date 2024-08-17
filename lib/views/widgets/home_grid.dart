import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/subjects_services.dart';
import 'package:flutter_application_1/localization/app_localizations.dart';
import 'package:flutter_application_1/views/screens/curriculum/my_curriculum_screen.dart';
import 'package:flutter_application_1/views/screens/homework/home_work_screen.dart';
import 'package:flutter_application_1/views/screens/live/live_screen.dart';
import 'package:flutter_application_1/views/screens/Exams/levels_screen.dart';

class HomeGrid extends StatelessWidget {
  const HomeGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final theme = Theme.of(context);

    List<String> texts = [
      localizations.translate('tasks'),
      localizations.translate('curriculum'),
      localizations.translate('live_classes'),
      localizations.translate('monthly_reviews'),
      localizations.translate('exam_solutions'),
      localizations.translate('final_review'),
    ];
    List<String> images = [
      'assets/images/Frame.png',
      'assets/images/Frame (1).png',
      'assets/images/ICON.png',
      'assets/images/Frame (2).png',
      'assets/images/Layer_1.png',
      'assets/images/Group.png'
    ];
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
      ),
      itemCount: texts.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            if (texts[index] == localizations.translate('curriculum')) {
              Provider.of<SubjectProvider>(context, listen: false)
                  .getSubjects(context);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => const MyCurriculumScreen()));
            }
            if (texts[index] == localizations.translate('tasks')) {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const HomeWorkScreen()));
            }
            if (texts[index] == localizations.translate('exam_solutions')) {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const LevelsScreen()));
            }
            if (texts[index] == localizations.translate('live_classes')) {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const LiveScreen()));
            }
          },
          child: Card(
            color: theme.scaffoldBackgroundColor,
            elevation: 3,
            shadowColor: redcolor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  texts[index],
                  style: TextStyle(
                      color: theme.textTheme.bodyLarge?.color, fontSize: 20),
                ),
                const SizedBox(height: 7),
                Image.asset(images[index]),
              ],
            ),
          ),
        );
      },
    );
  }
}
