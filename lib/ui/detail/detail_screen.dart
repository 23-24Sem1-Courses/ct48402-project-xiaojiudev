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
  String selectedAnswer = '';

  int _countdown = 0;
  bool resultScreenShown = false;

  late Timer countdownTimer;

  @override
  void initState() {
    super.initState();

    quizQuestions = widget.questions.map((questionData) {
      return QuizQuestion(
        question: questionData.question,
        answerOptions: Map.fromIterable(
          questionData.answers!,
          key: (answer) => answer.identifier,
          value: (answer) => answer.text,
        ),
        correctAnswer: questionData.correctAnswer,
      );
    }).toList();

    _countdown = widget.timeCountdown;

    countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _countdown = _countdown - 1;
      });

      if (_countdown == 0 && !resultScreenShown) {
        resultScreenShown = true;

        timer.cancel();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const ResultScreen(),
          ),
        );
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
                dashPattern: [12, 8],
                strokeWidth: 2,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 270,
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    //border: Border.all(color: blackColor, width: 4.0),
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
              child: Container(
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
                decoration: BoxDecoration(
                  //border: Border.all(color: blackColor, width: 4.0),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomRadioButton(
                      elevation: 3,
                      absoluteZeroSpacing: false,
                      unSelectedColor: Theme.of(context).canvasColor,
                      buttonLables:
                          currentQuestion.answerOptions.values.toList(),
                      buttonValues: currentQuestion.answerOptions.keys.toList(),
                      padding: 10,
                      enableShape: true,
                      horizontal: true,
                      spacing: 0,
                      buttonTextStyle: ButtonTextStyle(
                        selectedColor: Colors.white,
                        unSelectedColor: Colors.black,
                        textStyle: TextStyle(fontSize: 16),
                      ),
                      radioButtonValue: (value) {
                        selectedAnswer = value;
                        AppLogger.info('Selected value: ${selectedAnswer}');
                      },
                      selectedColor: Color(0xff7C3CFF),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 120,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              // TODO: handle back
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MenuScreen()));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff7C3CFF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22),
                                side:
                                    BorderSide(color: Colors.white, width: 2.0),
                              ),
                            ),
                            child: Text(
                              'Back',
                              style: regularTextStyle.copyWith(
                                  fontSize: 18, color: whiteColor),
                            ),
                          ),
                        ),
                        Container(
                          width: 120,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if (currentQuestionIndex <
                                  quizQuestions.length - 1) {
                                setState(() {
                                  currentQuestionIndex++;
                                });
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ResultScreen()),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffFFC10F),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22),
                                side:
                                    BorderSide(color: Colors.black, width: 2.0),
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
