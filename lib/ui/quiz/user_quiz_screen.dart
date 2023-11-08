import 'package:ct484_final_project/ui/menu/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:ct484_final_project/utils/app_logger.dart';
import 'package:ct484_final_project/configs/themes/theme.dart';
import 'package:ct484_final_project/services/quiz_service.dart';
import 'package:ct484_final_project/ui/quiz/edit_quiz_screen.dart';

class UserQuizScreen extends StatefulWidget {
  const UserQuizScreen({super.key});

  @override
  State<UserQuizScreen> createState() => _UserQuizScreenState();
}

class _UserQuizScreenState extends State<UserQuizScreen> {
  final FirebaseQuizService quizService = FirebaseQuizService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your quizzes'),
        actions: <Widget>[
          buildAddButton(context),
        ],
        backgroundColor: softblueColor,
      ),
      body: FutureBuilder(
        future: quizService.fetchAllQuizzes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SizedBox(
                width: 60,
                height: 60,
                child: LoadingIndicator(
                  indicatorType: Indicator.ballSpinFadeLoader,
                  strokeWidth: 1,
                ),
              ),
            );
          } else if (snapshot.hasError) {
            AppLogger.info('${snapshot.error}');

            return const Center(child: Text('Something went wrong'));
          } else {
            final quizzes = snapshot.data;

            return ListView.builder(
              itemCount: quizzes!.length,
              itemBuilder: (context, index) {
                final quiz = quizzes[index];

                return Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ListTile(
                    leading: CachedNetworkImage(
                      imageUrl: quiz.imageUrl!,
                      placeholder: (context, url) => const LoadingIndicator(
                        indicatorType: Indicator.ballSpinFadeLoader,
                        strokeWidth: 1,
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      width: 65,
                    ),
                    title: Text(quiz.title),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: <Widget>[
                          buildEditButton(context),
                          buildDeleteButton(context),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget buildAddButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.add),
      onPressed: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => EditQuizScreen()));
      },
    );
  }

  Widget buildEditButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.edit),
      onPressed: () {
        AppLogger.info('Go to edit page');
      },
      color: Theme.of(context).primaryColor,
    );
  }

  Widget buildDeleteButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete),
      onPressed: () {
        AppLogger.info('Delete quiz');

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text(
                'Quiz deleted',
                textAlign: TextAlign.center,
              ),
            ),
          );
      },
      color: Theme.of(context).colorScheme.error,
    );
  }
}
