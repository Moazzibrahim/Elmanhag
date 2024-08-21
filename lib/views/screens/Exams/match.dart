import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/localization/app_localizations.dart';
import 'package:flutter_application_1/views/screens/Exams/complete.dart';

class ExamScreenMatch extends StatelessWidget {
  const ExamScreenMatch({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: isDarkMode
            ? const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Ellipse 198.png'),
                  fit: BoxFit.cover,
                ),
              )
            : null,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              const SizedBox(height: 25),
              _buildHeader(context),
              const SizedBox(height: 20),
              const Text(
                'صل عمود (أ) بعمود (ب)',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: greycolor,
                ),
              ),
              const SizedBox(height: 20),
              const Expanded(
                child: _MatchingColumns(),
              ),
              _buildNavigationButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: redcolor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        const Spacer(flex: 2),
        Text(
          localizations.translate('exam'),
          style: const TextStyle(
            color: redcolor,
            fontSize: 28,
          ),
        ),
        const Spacer(flex: 3),
      ],
    );
  }

  Widget _buildNavigationButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: redcolor,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Complete()),
            );
          },
          child: const Text(
            'التالي',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'السابق',
            style: TextStyle(
              color: Colors.red,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}

class _MatchingColumns extends StatelessWidget {
  const _MatchingColumns();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    bool isDarkMode = theme.brightness == Brightness.dark;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildColumn(
          title: '(ب)',
          items: const [
            'حيوانات ليس لها عمود فقري.',
            'حيوانات لها عمود فقري.',
            'حيوانات تأكل الحيوانات الأخرى.',
            'حيوانات تأكل النباتات.',
          ],
          textStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: isDarkMode ? Colors.white : Colors.black),
          highlightStyle: const TextStyle(fontSize: 18, color: redcolor),
        ),
        _buildColumn(
          title: '(أ)',
          items: const [
            'اللافقاريات',
            'الفقاريات',
            'اللوامح',
            'العواشب',
          ],
          textStyle: TextStyle(
              fontSize: 18, color: isDarkMode ? Colors.white : Colors.black),
          highlightStyle: const TextStyle(fontSize: 18, color: redcolor),
        ),
      ],
    );
  }

  Widget _buildColumn({
    required String title,
    required List<String> items,
    required TextStyle textStyle,
    required TextStyle highlightStyle,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            for (var item in items)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  item,
                  style: item.contains('النباتات') ? highlightStyle : textStyle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
