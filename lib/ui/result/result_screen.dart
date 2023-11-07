import 'package:flutter/material.dart';

import 'package:ct484_final_project/configs/themes/theme.dart';
import 'package:ct484_final_project/ui/menu/menu_screen.dart';

class ResultScreen extends StatelessWidget {
  final int correctQuestion;
  final int totalQuestions;
  const ResultScreen(
      {super.key, required this.correctQuestion, required this.totalQuestions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: softpurpleColor,
        ),
        child: Stack(
          children: [
            Positioned(
              top: 100,
              left: 20,
              right: 20,
              bottom: 150,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 270,
                decoration: BoxDecoration(
                  color: softblueColor,
                  border: Border.all(color: blackColor, width: 4.0),
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                ),
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        width: 220.0,
                        height: 220.0,
                        margin: const EdgeInsets.all(60.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: whiteColor, width: 4.0),
                          color: redColor,
                          shape: BoxShape.circle,
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "${(correctQuestion / totalQuestions * 100).toInt()}",
                                style: mediaumTextStyle.copyWith(
                                  fontSize: 72,
                                  color: whiteColor,
                                ),
                              ),
                              Text(
                                "Your score",
                                style: mediaumTextStyle.copyWith(
                                  fontSize: 18,
                                  color: whiteColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        'Total questions: $totalQuestions',
                        style: mediaumTextStyle.copyWith(
                          fontSize: 22,
                          color: blackColor,
                        ),
                      ),
                      Text(
                        'Correct questions: $correctQuestion',
                        style: mediaumTextStyle.copyWith(
                          fontSize: 22,
                          color: blackColor,
                        ),
                      ),
                      Text(
                        'Wrong questions: ${totalQuestions - correctQuestion}',
                        style: mediaumTextStyle.copyWith(
                          fontSize: 22,
                          color: blackColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 40,
              left: 100,
              height: 150,
              width: 206,
              child: SizedBox(
                width: 120,
                height: 120,
                child: Image.asset(
                  'assets/images/u1.png',
                  width: 20,
                ),
              ),
            ),
            Positioned(
              top: 770,
              left: 100,
              height: 50,
              width: 206,
              child: SizedBox(
                width: 220,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MenuScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: blueColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                      side: const BorderSide(color: Colors.white, width: 2.0),
                    ),
                  ),
                  child: Text(
                    'Try Again',
                    style: regularTextStyle.copyWith(
                        fontSize: 18, color: whiteColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

