// ignore_for_file: unused_element, deprecated_member_use

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/localization/app_localizations.dart';
import 'package:flutter_application_1/models/hw_questions_model.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_application_1/views/screens/home_screen.dart';

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
    _disposeTextControllers();
    super.dispose();
  }

  void _disposeTextControllers() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    _controllers.clear();
  }

  void _initializeTextControllers(Question question) {
    _disposeTextControllers();
    if (question.answerType == 'Essay') {
      _controllers = List.generate(
        question.question!.split('.....').length - 1,
        (index) => TextEditingController(),
      );
    }
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

    if (question != null && _controllers.isEmpty) {
      _initializeTextControllers(question);
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
                _buildShuffledAnswers(
                    _getShuffledAnswers(answers)), // Display shuffled answers
              const SizedBox(height: 16),
              _buildCompleteOptions(question!),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentQuestionIndex <
                      (widget.homeworkResponse?.homework?.questionGroups?.first
                                  .questions?.length ??
                              0) -
                          1)
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
                    )
                  else
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: redcolor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: _submitQuiz, // Replace with your submit logic
                      child: Text(
                        localizations.translate('submit'),
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
              )
            ],
          ),
        ),
      ),
    );
  }

  void _submitQuiz() {
    correctQuestions.clear();
    incorrectQuestions.clear();

    final questionGroup =
        widget.homeworkResponse?.homework?.questionGroups?.first;

    // Iterate through each question in the group
    for (var question in questionGroup?.questions ?? []) {
      if (question.answerType == 'Essay') {
        // For Essay type, compare the text fields with the true_answers
        final trueAnswers = question.answers
            ?.firstWhere((answer) => answer.trueAnswer != null)
            .trueAnswer;

        List<String>? parsedTrueAnswers;
        try {
          parsedTrueAnswers = List<String>.from(jsonDecode(trueAnswers!));
        } catch (e) {
          parsedTrueAnswers = [];
          log('Error parsing true answers: $e');
        }

        bool isCorrect = true;

        // Compare user answers with true answers
        for (int i = 0; i < _controllers.length; i++) {
          if (i >= parsedTrueAnswers.length ||
              _controllers[i].text.trim() != parsedTrueAnswers[i].trim()) {
            isCorrect = false;
            break;
          }
        }

        if (isCorrect) {
          correctQuestions.add(question);
          log('Correct essay answer');
        } else {
          incorrectQuestions.add(question);
          log('Incorrect essay answer');
        }
            }
    }

    int correctAnswersCount = correctQuestions.length;
    int totalQuestions = questionGroup?.questions?.length ?? 0;
    log('H.W submitted with $correctAnswersCount correct answers and ${totalQuestions - correctAnswersCount} incorrect answers.');

    // Show result dialog
    showResultDialog(context, correctAnswersCount, totalQuestions);
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
      case 'Essay':
        return Column(
          children: [
            _buildShuffledAnswers(_getShuffledAnswers(question.answers ?? [])),
            const SizedBox(height: 16),
            _buildCompleteOptions(question),
          ],
        );
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
        ? question?.answers?.first.trueAnswer
        : null;
    final parsedTrueAnswer = trueAnswer == 'true';

    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                if (parsedTrueAnswer == false) {
                  correctQuestions.add(question!);
                  log('Correct T/F answer added');
                } else {
                  incorrectQuestions.add(question!);
                  log('Incorrect T/F answer added');
                }
              });
            },
            child: Container(
              color: Colors.red,
              height: 50,
              child: const Center(
                child: Icon(Icons.close, color: Colors.white),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                if (parsedTrueAnswer == true) {
                  correctQuestions.add(question!);
                  log('Correct T/F answer added');
                } else {
                  incorrectQuestions.add(question!);
                  log('Incorrect T/F answer added');
                }
              });
            },
            child: Container(
              color: Colors.green,
              height: 50,
              child: const Center(
                child: Icon(Icons.check, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCompleteOptions(Question question) {
    final parts = question.question!.split('.....');
    final children = <Widget>[];

    for (var i = 0; i < parts.length; i++) {
      children.add(Text(
        parts[i],
        style: const TextStyle(fontSize: 16),
      ));

      if (i < _controllers.length) {
        children.add(
          SizedBox(
            width: 100,
            child: DragTarget<String>(
              onAccept: (receivedAnswer) {
                setState(() {
                  _controllers[i].text = receivedAnswer;
                });
              },
              builder: (context, candidateData, rejectedData) {
                return TextField(
                  controller: _controllers[i],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: ".......",
                  ),
                  onChanged: (value) {
                    final trueAnswer = question.answers
                        ?.firstWhere((answer) => answer.trueAnswer != null)
                        .trueAnswer;

                    if (trueAnswer != null &&
                        value.trim() == trueAnswer.trim()) {
                      if (!correctQuestions.contains(question)) {
                        correctQuestions.add(question);
                        log('Correct essay answer added');
                      }
                    } else {
                      if (!incorrectQuestions.contains(question)) {
                        incorrectQuestions.add(question);
                        log('Incorrect essay answer added');
                      }
                    }
                  },
                );
              },
            ),
          ),
        );
      }
    }

    return Wrap(
      alignment: WrapAlignment.center,
      children: children,
    );
  }

  List<Answer> _getShuffledAnswers(List<Answer> answers) {
    final shuffledAnswers = List<Answer>.from(answers)..shuffle();
    return shuffledAnswers;
  }

  Widget _buildShuffledAnswers(List<Answer> shuffledAnswers) {
    return Wrap(
      spacing: 10.0,
      children: shuffledAnswers.map((answer) {
        return Draggable<String>(
          data: answer.answer ?? '',
          feedback: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                answer.answer ?? '',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          childWhenDragging: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.blueGrey.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              answer.answer ?? '',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              answer.answer ?? '',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  void _verifyEssayAnswer(Question question) {
    List<String>? trueAnswers;
    try {
      trueAnswers =
          List<String>.from(jsonDecode(question.answers!.first.trueAnswer!));
    } catch (e) {
      trueAnswers = [];
      log('Error parsing true answers: $e');
    }

    bool isCorrect = true;
    for (int i = 0; i < _controllers.length; i++) {
      if (i >= trueAnswers.length ||
          _controllers[i].text.trim() != trueAnswers[i].trim()) {
        isCorrect = false;
        break;
      }
    }

    if (isCorrect) {
      correctQuestions.add(question);
      log('Correct essay answer added');
    } else {
      incorrectQuestions.add(question);
      log('Incorrect essay answer added');
    }
  }

  void _nextQuestion() {
    setState(() {
      if (_currentQuestionIndex <
          widget.homeworkResponse!.homework!.questionGroups!.first.questions!
                  .length -
              1) {
        _currentQuestionIndex++;
        _initializeTextControllers(widget.homeworkResponse!.homework!
            .questionGroups!.first.questions![_currentQuestionIndex]);
      }
    });
  }

  void _previousQuestion() {
    setState(() {
      if (_currentQuestionIndex > 0) {
        _currentQuestionIndex--;
        _initializeTextControllers(widget.homeworkResponse!.homework!
            .questionGroups!.first.questions![_currentQuestionIndex]);
      }
    });
  }

  void showResultDialog(
      BuildContext context, int correctAnswers, int totalQuestions) {
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
                Text(
                  '$correctAnswers/$totalQuestions',
                  style: const TextStyle(
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
}

class _ResultMessage extends StatelessWidget {
  const _ResultMessage();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          },
          style: ElevatedButton.styleFrom(backgroundColor: redcolor),
          child: const Text(
            "ok",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ],
    );
  }
}
