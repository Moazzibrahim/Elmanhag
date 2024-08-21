import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/localization/app_localizations.dart';

class Complete extends StatelessWidget {
  const Complete({super.key});

  void showResultDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDialogHeader(context),
                const SizedBox(height: 20),
                const Text(
                  '20/15',
                  style: TextStyle(
                    color: redcolor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const _ResultMessage(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDialogHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/starts.png",
          width: 65,
          height: 65,
        ),
        const SizedBox(width: 6),
        const Expanded(
          child: Center(
            child: Text(
              'النتيجة',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Align(
            alignment: Alignment.topRight,
            child: Icon(
              Icons.close,
              color: redcolor,
              size: 25,
            ),
          ),
        ),
      ],
    );
  }

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
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 25),
              _buildHeader(context),
              const SizedBox(height: 20),
              const _ExamInstructions(),
              const SizedBox(height: 30),
              const _ExamQuestions(),
              const Spacer(),
              _buildNavigationButtons(context),
              const SizedBox(height: 20),
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
          icon: const Icon(Icons.arrow_back_ios, color: redcolor),
          onPressed: () => Navigator.pop(context),
        ),
        const Spacer(flex: 2),
        Text(
          localizations.translate('exam'),
          style: const TextStyle(
            color: redcolor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
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
          onPressed: () => showResultDialog(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: redcolor,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text(
            'تسليم',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'السابق',
            style: TextStyle(
              color: redcolor,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}

class _ResultMessage extends StatelessWidget {
  const _ResultMessage();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Text(
          "لقد اجتزت الامتحان",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          'تهانينا لك ',
          style: TextStyle(
            color: redcolor,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _ExamInstructions extends StatelessWidget {
  const _ExamInstructions();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    bool isDarkMode = theme.brightness == Brightness.dark;
    return Column(
      children: [
        Text(
          'اختر الاجابه الصحيحه من بين',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: isDarkMode ? Colors.white : Colors.black),
          textAlign: TextAlign.center,
        ),
        Text(
          ':الكلمات التاليه',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: isDarkMode ? Colors.white : Colors.black),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Text(
          '(الارنــــب _ الفيــــل _ الفأر_ السلحفاء)',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: isDarkMode ? Colors.white : Colors.black),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _ExamQuestions extends StatelessWidget {
  const _ExamQuestions();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    bool isDarkMode = theme.brightness == Brightness.dark;
    return Column(
      children: [
        Text(
          'حيوان الـــــــ _________ اسرع من _______',
          style: TextStyle(
              fontSize: 18, color: isDarkMode ? Colors.white : Colors.black),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Text(
          'يخاف حيوان _______ من حيوان _______',
          style: TextStyle(
              fontSize: 18, color: isDarkMode ? Colors.white : Colors.black),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
