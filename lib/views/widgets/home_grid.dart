import 'package:flutter/material.dart';
// import 'package:flutter_application_1/affiliate/views/affiliate_home_screen.dart';
import 'package:flutter_application_1/views/screens/curriculum/mycurriculum/my_curriculum_screen.dart';
import 'package:flutter_application_1/views/screens/homework/hw_my_cirriculam.dart';
// import 'package:flutter_application_1/views/screens/live/live_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/subjects_services.dart';
import 'package:flutter_application_1/localization/app_localizations.dart';

class HomeGrid extends StatelessWidget {
  const HomeGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final theme = Theme.of(context);

    List<String> texts = [
      localizations.translate('curriculum'),
      localizations.translate('tasks'),
      localizations.translate('live_classes'),
      localizations.translate('monthly_reviews'),
      localizations.translate('exam_solutions'),
      localizations.translate('final_review'),
    ];
    List<String> images = [
      'assets/images/Frame (1).png',
      'assets/images/Frame.png',
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
            }else{
              null;
            }
            if (texts[index] == localizations.translate('tasks')) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => const HomeworkMyCirriculam()));
            }
            // if (texts[index] == localizations.translate('exam_solutions')) {
            //   Navigator.of(context).push(MaterialPageRoute(
            //       builder: (ctx) => const AffiliateHomeScreen()));
            // }
            // if (texts[index] == localizations.translate('live_classes')) {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => const LiveScreen(),
            //     ),
            //   );
            // }
          },
          child: Card(
  color: theme.scaffoldBackgroundColor,
  elevation: 3,
  shadowColor: redcolor,
  child: Stack(
    children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            texts[index],
            style: const TextStyle(color: redcolor, fontSize: 20),
          ),
          const SizedBox(height: 7),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(images[index]),
            ],
          ),
        ],
      ),
      texts[index] != localizations.translate('curriculum') && texts[index] != localizations.translate('tasks')? Positioned.fill(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            color: Colors.black.withOpacity(0.6), // Semi-transparent overlay
          ),
          child: const Center(
            child: Text(
              'Coming Soon',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ) : const SizedBox()
    ],
  ),
),

        );
      },
    );
  }
}
