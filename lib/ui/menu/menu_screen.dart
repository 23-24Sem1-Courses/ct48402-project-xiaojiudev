import 'package:flutter/material.dart';

import 'package:ct484_final_project/models/quiz.dart';
import 'package:ct484_final_project/utils/app_logger.dart';
import 'package:ct484_final_project/ui/quiz/quiz_card.dart';
import 'package:ct484_final_project/ui/shared/app_drawer.dart';
import 'package:ct484_final_project/configs/themes/theme.dart';
import 'package:ct484_final_project/services/quiz_service.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      backgroundColor: softpurpleColor,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Row(
                      children: [
                        // Avatar
                        ClipOval(
                          child: GestureDetector(
                            onTap: () {
								_scaffoldKey.currentState!.openDrawer();
							},
                            child: Image.asset(
                              'assets/images/icon.png',
                              width: 42,
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
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
                  ),
                  const SizedBox(height: 30),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: softblueColor,
                      border: Border.all(color: Colors.black, width: 3.0),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(44.0),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: edge),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            "All Quizzes",
                            style: mediaumTextStyle.copyWith(fontSize: 32),
                          ),
                          const SizedBox(height: 20),
                          ListView.builder(
                            itemCount: _quizzesData.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final quiz = _quizzesData[index];

                              return QuizCard(
                                quiz: quiz,
                              );
                            },
                          ),
                          const SizedBox(height: 33),
                        ],
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
}
