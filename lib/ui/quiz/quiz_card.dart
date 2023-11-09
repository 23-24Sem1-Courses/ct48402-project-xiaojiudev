import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:ct484_final_project/models/quiz.dart';
import 'package:ct484_final_project/ui/quiz/quiz_screen.dart';
import 'package:ct484_final_project/configs/themes/theme.dart';
import 'package:loading_indicator/loading_indicator.dart';

class QuizCard extends StatelessWidget {
  final QuizCourse quiz;

  const QuizCard({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => QuizScreen(quiz: quiz)));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
            side: const BorderSide(color: Colors.black, width: 2.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              leading: CachedNetworkImage(
                imageUrl: quiz.imageUrl!,
                placeholder: (context, url) => const LoadingIndicator(
                  indicatorType: Indicator.ballSpinFadeLoader,
                  strokeWidth: 1,
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                width: 65,
              ),
              title: Text(
                quiz.title,
                style: mediaumTextStyle.copyWith(fontSize: 15),
              ),
              subtitle: Text(
                quiz.description,
                textAlign: TextAlign.justify,
              ),
              trailing: Image.asset('assets/images/Play.png'),
            ),
          ),
        ),
      ),
    );
  }
}
