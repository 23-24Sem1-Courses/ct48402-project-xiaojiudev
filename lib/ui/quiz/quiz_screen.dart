import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:ct484_final_project/models/quiz.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:ct484_final_project/utils/time_utils..dart';
import 'package:ct484_final_project/configs/themes/theme.dart';
import 'package:ct484_final_project/ui/detail/detail_screen.dart';

class QuizScreen extends StatelessWidget {
  final QuizCourse quiz;
  const QuizScreen({required this.quiz, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: softpurpleColor,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: edge),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: blackColor, width: 4.0),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                width: MediaQuery.of(context).size.width,
                height: 393,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      quiz.title,
                      style: mediaumTextStyle.copyWith(fontSize: 32),
                      textAlign: TextAlign.center,
                    ),
                    CachedNetworkImage(
                      imageUrl: quiz.imageUrl!,
                      placeholder: (context, url) => const LoadingIndicator(
                        indicatorType: Indicator.ballSpinFadeLoader,
                        strokeWidth: 1,
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      width: 200,
                    ),
                    Text(
                      'Time: ${TimeUtils.formatTime(quiz.timeSeconds)}',
                      style: mediaumTextStyle.copyWith(fontSize: 24),
                    )
                  ],
                ),
              ),
              Container(
                width: 220,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailScreen(
                                questions: quiz.questions!,
                                timeCountdown: quiz.timeSeconds)));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffFFC10F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                      side: BorderSide(color: Colors.black, width: 2.0),
                    ),
                  ),
                  child: Text(
                    'Start',
                    style: regularTextStyle.copyWith(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
