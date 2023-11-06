import 'package:ct484_final_project/configs/themes/theme.dart';
import 'package:ct484_final_project/models/quiz.dart';
import 'package:ct484_final_project/ui/quiz/quiz_screen.dart';
import 'package:ct484_final_project/utils/app_logger.dart';
import 'package:flutter/material.dart';

class QuizCard extends StatelessWidget {
  final QuizCourse quiz;

  const QuizCard({required this.quiz});

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => QuizScreen(quiz: quiz)));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
            side: BorderSide(color: Colors.black, width: 2.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              leading: Image.network(
                quiz.imageUrl ??
                    'https://res.cloudinary.com/de8xbko8y/image/upload/v1699278557/flutter/science_hyaj8u.png',
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
