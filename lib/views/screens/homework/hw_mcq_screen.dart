// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/localization/app_localizations.dart';
import 'package:flutter_application_1/models/hw_questions_model.dart';
import 'package:audioplayers/audioplayers.dart';

class HomeworkMcqScreen extends StatefulWidget {
  final HomeworkResponse? homeworkResponse;

  const HomeworkMcqScreen({super.key, this.homeworkResponse});

  @override
  State<HomeworkMcqScreen> createState() => _HomeworkMcqScreenState();
}

class _HomeworkMcqScreenState extends State<HomeworkMcqScreen> {
  int _currentQuestionIndex = 0;
  String? _selectedOption;
  final AudioPlayer _audioPlayer = AudioPlayer();
  List<TextEditingController> _controllers = [];

  List<Question> correctQuestions = [];
  List<Question> incorrectQuestions = [];

  @override
  void dispose() {
    _audioPlayer.dispose();
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    bool isDarkMode = theme.brightness == Brightness.dark;
    final localizations = AppLocalizations.of(context);

    final questionGroup =
        widget.homeworkResponse?.homework?.questionGroups?.first;
    final question = questionGroup?.questions?[_currentQuestionIndex];
    final answers = question?.answers ?? [];

    if (question?.answerType == 'Essay' && _controllers.isEmpty) {
      _controllers = List.generate(
        question!.question!.split('.....').length - 1,
        (index) => TextEditingController(),
      );
    }

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
            children: [
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: redcolor,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Spacer(flex: 2),
                  Text(
                    localizations.translate('homework'),
                    style: const TextStyle(
                      color: redcolor,
                      fontSize: 28,
                    ),
                  ),
                  const Spacer(flex: 3),
                ],
              ),
              const SizedBox(height: 16),
              _buildQuestionContent(question),
              const SizedBox(height: 16),
              if (question?.answerType == 'Mcq')
                for (var answer in answers)
                  _buildRadioOption(
                      answer.answer ?? '', answer.answer ?? '', question)
              else if (question?.answerType == 'T/F')
                _buildTrueFalseOptions(question)
              else if (question?.answerType == 'Essay')
                _buildCompleteOptions(question),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: redcolor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: _nextQuestion,
                    child: Text(
                      localizations.translate('next'),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: redcolor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: _previousQuestion,
                    child: Text(
                      localizations.translate('past'),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionContent(Question? question) {
    if (question == null) return const SizedBox.shrink();

    // If there's an image, display it first
    if (question.imageLink != null && question.imageLink!.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16), // Add some space before the image
          Image.network(
            question.imageLink!,
            errorBuilder: (context, error, stackTrace) =>
                const Text('Error loading image'),
          ),
          const SizedBox(height: 8), // Space after the image
          if (question.question != null && question.question!.isNotEmpty)
            Text(
              question.question!,
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w600, color: greycolor),
            ),
        ],
      );
    }

    // Handle different types of content
    switch (question.questionType) {
      case 'image':
        return Image.network(
          question.imageLink ?? '',
          errorBuilder: (context, error, stackTrace) =>
              const Text('Error loading image'),
        );
      case 'audio':
        if (question.audioLink != null && question.audioLink!.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () => _playAudio(question.audioLink!),
                child: const Text('Play Audio'),
              ),
              const SizedBox(height: 8),
              const Text('Playing audio...'),
            ],
          );
        } else {
          return const Text('No audio available');
        }
      default:
        return const SizedBox.shrink();
    }
  }

  void _playAudio(String url) {
    _audioPlayer.play(UrlSource(url));
  }

  Widget _buildRadioOption(String text, String value, Question? question) {
    final theme = Theme.of(context);
    bool isDarkMode = theme.brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedOption = value;

          // Compare selected answer with trueAnswer
          if (question != null) {
            String? trueAnswer = question.answers
                ?.firstWhere(
                  (answer) => answer.trueAnswer != null,
                  orElse: () => question.answers!.first,
                )
                .trueAnswer;

            // Parse the trueAnswer to handle potential JSON list strings
            List<String>? parsedTrueAnswer;
            try {
              parsedTrueAnswer = jsonDecode(trueAnswer!);
            } catch (e) {
              parsedTrueAnswer = [trueAnswer!];
            }

            if (parsedTrueAnswer!.contains(_selectedOption)) {
              correctQuestions.add(question);
              log('Correct answer added');
            } else {
              incorrectQuestions.add(question);
              log('Incorrect answer added');
            }
          }
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Radio<String>(
            value: value,
            groupValue: _selectedOption,
            onChanged: (value) {
              setState(() {
                _selectedOption = value;

                // Compare selected answer with trueAnswer
                if (question != null) {
                  String? trueAnswer = question.answers
                      ?.firstWhere(
                        (answer) => answer.trueAnswer != null,
                        orElse: () => question.answers!.first,
                      )
                      .trueAnswer;

                  // Parse the trueAnswer to handle potential JSON list strings
                  List<String>? parsedTrueAnswer;
                  try {
                    parsedTrueAnswer = jsonDecode(trueAnswer!);
                  } catch (e) {
                    parsedTrueAnswer = [trueAnswer!];
                  }

                  if (parsedTrueAnswer!.contains(_selectedOption)) {
                    correctQuestions.add(question);
                    log('Correct answer added');
                  } else {
                    incorrectQuestions.add(question);
                    log('Incorrect answer added');
                  }
                }
              });
            },
            activeColor: redcolor,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
                fontSize: 16, color: isDarkMode ? Colors.white : Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildTrueFalseOptions(Question? question) {
    String? trueAnswer = question?.answers?.isNotEmpty == true
        ? question?.answers?.first.trueAnswer?.toLowerCase()
        : null;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                if (trueAnswer == 'false') {
                  correctQuestions.add(question!);
                  log('Correct answer');
                } else {
                  incorrectQuestions.add(question!);
                  log('Wrong answer');
                }
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.zero,
              minimumSize: const Size(0, 60),
              shadowColor: Colors.green,
              elevation: 4,
            ),
            child: const Center(
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                if (trueAnswer == 'true') {
                  correctQuestions.add(question!);
                  log('Correct answer');
                } else {
                  incorrectQuestions.add(question!);
                  log('Wrong answer');
                }
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.zero,
              minimumSize: const Size(0, 60),
              shadowColor: Colors.red,
              elevation: 4,
            ),
            child: const Center(
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCompleteOptions(Question? question) {
    if (question == null ||
        question.answers == null ||
        question.answers!.isEmpty) {
      return const Text('No data available');
    }

    bool isArabic = question.question != null &&
        RegExp(r'^[\u0600-\u06FF]').hasMatch(question.question!);

    // Decode the answer string into a List of Strings
    List<String>? answers;
    try {
      // Ensure the answer field is not null and decode the JSON string
      if (question.answers!.isNotEmpty) {
        String? answerString = question.answers!.first.answer;
        if (answerString != null) {
          answers = List<String>.from(jsonDecode(answerString));
          print('Parsed Answers: $answers'); // Debugging print statement
        }
      }
    } catch (e) {
      answers = [];
      print('Error parsing answers: $e'); // Debugging print statement
    }

    // Format the answers list into a string with square brackets
    String formattedAnswers =
        answers != null ? '[${answers.join(', ')}]' : '[]';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Display the formatted answers
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            formattedAnswers,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
            textAlign: TextAlign.center,
            textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          ),
        ),

        const SizedBox(height: 10),

        // Display the question text
        Text(
          ' ${question.question} ',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
          textAlign: TextAlign.center,
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        ),
      ],
    );
  }

  void _nextQuestion() {
    setState(() {
      if (_currentQuestionIndex <
          (widget.homeworkResponse?.homework?.questionGroups?.first.questions
                      ?.length ??
                  1) -
              1) {
        _currentQuestionIndex++;
        _selectedOption = null;
      }
    });
  }

  void _previousQuestion() {
    setState(() {
      if (_currentQuestionIndex > 0) {
        _currentQuestionIndex--;
        _selectedOption = null;
      }
    });
  }
}
