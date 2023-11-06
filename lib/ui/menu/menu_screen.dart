import 'package:ct484_final_project/ui/quiz/quiz_card.dart';
import 'package:flutter/material.dart';

import 'package:ct484_final_project/models/quiz.dart';
import 'package:ct484_final_project/widgets/slide.dart';
import 'package:ct484_final_project/utils/app_logger.dart';
import 'package:ct484_final_project/ui/quiz/quiz_screen.dart';
import 'package:ct484_final_project/configs/themes/theme.dart';
import 'package:ct484_final_project/services/quiz_service.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late QuizService _quizService;
  List<QuizCourse> _quizzesData = [];

  @override
  void initState() {
    super.initState();
    _quizService = QuizService();
    _fetchQuizzes();
  }

  Future<void> _fetchQuizzes() async {
    final quizzes = await _quizService.fetchAllQuizzes();

    if (quizzes != null) {

    //   AppLogger.info(quizzes);

      setState(() {
        _quizzesData = quizzes;
      });
    } else {
      AppLogger.info('Failed to fetch all quizzes, returning empty list');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: softpurpleColor,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Stack(
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            'assets/images/icon.png',
                            width: 42,
                          ),
                        ),
                        SizedBox(width: 5),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello, Phat',
                              style: boltwhiteTextStyle.copyWith(
                                  fontSize: 18, color: blackColor),
                            ),
                            Text(
                              'Let’s start your quiz now !',
                              style: regularTextStyle.copyWith(fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: edge),
                      child: Container(
                        height: 180,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            SlideCard(
                              image: 'assets/images/b1.png',
                              level: 'Level 2',
                              name: 'Bahasa',
                            ),
                            SlideCard(
                              image: 'assets/images/b2.png',
                              level: 'Level 2',
                              name: 'Bahasa',
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: softblueColor,
                        border: Border.all(color: Colors.black, width: 3.0),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(44.0),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: edge),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            Text(
                              "All Quiz",
                              style: mediaumTextStyle.copyWith(fontSize: 18),
                            ),
                            SizedBox(height: 20),
                            ListView.builder(
                              itemCount: _quizzesData.length,
                              shrinkWrap: true,
							  physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final quiz = _quizzesData[index];
                                return QuizCard(
                                  quiz: quiz,
                                );
                              },
                            ),
                            SizedBox(height: 33),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
