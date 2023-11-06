import 'dart:async';

import 'package:ct484_final_project/models/quiz.dart';
import 'package:ct484_final_project/ui/menu/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';

import 'package:ct484_final_project/ui/quiz/quiz_screen.dart';
import 'package:ct484_final_project/ui/result/result_screen.dart';
import 'package:ct484_final_project/configs/themes/theme.dart';
import 'package:ct484_final_project/utils/app_logger.dart';

class DetailScreen extends StatefulWidget {
  final List<Question> questions;
  final int timeCountdown;

  const DetailScreen({required this.questions, required this.timeCountdown});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int currentQuestionIndex = 0;
  int countdown = 0;
  String selectedAnswer = '';


  @override
  Widget build(BuildContext context) {
    for (var question in widget.questions) {
      AppLogger.info("${question.correctAnswer}");
    }
    // AppLogger.info(widget.timeCountdown);

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
                      '1. Your companny wants to purchase some network hardware to which they can plug the 30 PCs in your department. Which type of network device is appropriate?',
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
              left: 120, // Adjust the position of the countdown timer
              height: 150,
              width: 200,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  '00:10', // Replace with your countdown timer value
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
                      buttonLables: [
                        'A router',
                        'A firewall',
                        'A switch',
                        'A server',
                      ],
                      buttonValues: [
                        "A",
                        "B",
                        "C",
                        "D",
                      ],
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
                        AppLogger.info('Selected value: ${value}');
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => /*QuizScreen()*/
                                          MenuScreen()));
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ResultScreen()));
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

class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final int timeToAnswer;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    required this.timeToAnswer,
  });
}
