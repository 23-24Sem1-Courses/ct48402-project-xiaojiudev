import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';

import 'package:ct484_final_project/models/quiz.dart';
import 'package:ct484_final_project/utils/app_logger.dart';
import 'package:ct484_final_project/ui/menu/menu_screen.dart';
import 'package:ct484_final_project/configs/themes/theme.dart';
import 'package:ct484_final_project/ui/result/result_screen.dart';

class DetailScreen extends StatefulWidget {
  static const routeName = 'detail-screen';

  final List<Question> questions;
  final int timeCountdown;

  const DetailScreen(
      {super.key, required this.questions, required this.timeCountdown});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  List<QuizQuestion> quizQuestions = [];
  int currentQuestionIndex = 0;

  int score = 0;
  bool answered = false;
  String selectedAnswer = '';
  int selectedButtonIndex = -1;

  int _countdown = 0;
  bool resultScreenShown = false;

  late Timer countdownTimer;

  @override
  void initState() {
    super.initState();

    quizQuestions = widget.questions.map((questionData) {
      return QuizQuestion(
        question: questionData.question,
        answerOptions: { for (var answer in questionData.answers!) answer.identifier : answer.text },
        correctAnswer: questionData.correctAnswer,
      );
    }).toList();

    _countdown = widget.timeCountdown;

    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _countdown = _countdown - 1;
      });

      if (_countdown == 0 && !resultScreenShown) {
        resultScreenShown = true;

        timer.cancel();

        Navigator.pushReplacementNamed(context, ResultScreen.routeName,
            arguments: {
              'correctQuestion': score,
              'totalQuestions': quizQuestions.length,
            }
            ).then((_) => countdownTimer.cancel());
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    countdownTimer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = quizQuestions[currentQuestionIndex];
    AppLogger.info('Your score is: ${score}');

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: softpurpleColor,
        ),
        child: Stack(
          children: [
            Positioned(
              top: 180,
              left: 20,
              right: 20,
              bottom: 450,
              child: DottedBorder(
                color: Colors.black,
                dashPattern: const [12, 8],
                strokeWidth: 2,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 270,
                  padding: const EdgeInsets.all(12.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  child: Center(
                    child: Text(
                      '${currentQuestionIndex + 1}. ${currentQuestion.question}',
                      style: mediaumTextStyle.copyWith(fontSize: 20),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 40,
              left: 0,
              height: 150,
              width: 100,
              child: SizedBox(
                width: 120,
                height: 120,
                child: Image.asset(
                  'assets/images/q2.png',
                  width: 20,
                ),
              ),
            ),
            Positioned(
              top: 40,
              left: 120,
              height: 150,
              width: 200,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  '${formartTime(_countdown)}',
                  style: mediaumTextStyle.copyWith(fontSize: 24),
                ),
              ),
            ),
            Positioned(
              top: 350,
              left: 20,
              right: 20,
              bottom: 20,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          const SizedBox(height: 10),
                          CustomRadioButton(
                            elevation: 3,
                            absoluteZeroSpacing: false,
                            unSelectedColor: Theme.of(context).canvasColor,
                            buttonLables:
                                currentQuestion.answerOptions.values.toList(),
                            buttonValues:
                                currentQuestion.answerOptions.keys.toList(),
                            padding: calculatePadding(
                                currentQuestion.answerOptions.length),
                            enableShape: true,
                            horizontal: true,
                            spacing: 5,
                            height: 50,
                            buttonTextStyle: ButtonTextStyle(
                              selectedColor: selectedButtonIndex == -1
                                  ? Colors.black
                                  : Colors.white,
                              textStyle: const TextStyle(fontSize: 16),
                            ),
                            radioButtonValue: (value) {
                              if (!answered) {
                                setState(() {
                                  selectedAnswer = value;
                                  selectedButtonIndex = currentQuestion
                                      .answerOptions.keys
                                      .toList()
                                      .indexOf(value);
                                });
                                AppLogger.info(
                                    'Selected value: $selectedAnswer');
                              }
                            },
                            selectedColor: selectedButtonIndex != -1
                                ? const Color(0xff7C3CFF)
                                : Theme.of(context).canvasColor,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 150,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                context,
                                MenuScreen.routeName,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff7C3CFF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22),
                                side: const BorderSide(
                                    color: Colors.white, width: 2.0),
                              ),
                            ),
                            child: Text(
                              'Back',
                              style: regularTextStyle.copyWith(
                                  fontSize: 18, color: whiteColor),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if (!answered) {
                                if (selectedAnswer ==
                                    currentQuestion.correctAnswer) {
                                  score++;
                                }

                                if (currentQuestionIndex <
                                    quizQuestions.length - 1) {
                                  setState(() {
                                    currentQuestionIndex++;
                                    selectedAnswer = '';
                                    answered = false;
                                    selectedButtonIndex = -1;
                                  });
                                } else {
                                  Navigator.pushReplacementNamed(
                                      context, ResultScreen.routeName,
                                      arguments: {
                                        'correctQuestion': score,
                                        'totalQuestions': quizQuestions.length,
                                      }
                                      );
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffFFC10F),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22),
                                side: const BorderSide(
                                    color: Colors.black, width: 2.0),
                              ),
                            ),
                            child: Text(
                              'Next',
                              style: regularTextStyle.copyWith(fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

double calculatePadding(int length) {
  double maxPadding = 20.0;
  double minPadding = 0.0;

  int maxAnswers = 5;
  int minAnswers = 1;

  length = length.clamp(minAnswers, maxAnswers);

  double padding = maxPadding -
      ((maxPadding - minPadding) / (maxAnswers - minAnswers)) *
          (length - minAnswers);

  return padding.clamp(minPadding, maxPadding);
}

formartTime(int timeInSeconds) {
  Duration duration = Duration(seconds: timeInSeconds);
  String formattedTime;

  if (duration.inHours > 0) {
    formattedTime = duration.toString().split('.').first.padLeft(8, "0");
  } else {
    formattedTime = duration.toString().substring(2, 7);
  }

  return formattedTime;
}

class QuizQuestion {
  final String question;
  final Map<String, String> answerOptions;
  final String correctAnswer;

  QuizQuestion({
    required this.question,
    required this.answerOptions,
    required this.correctAnswer,
  });
}
