import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:ct484_final_project/ui/screen.dart';
import 'package:ct484_final_project/models/quiz.dart';
import 'package:ct484_final_project/utils/app_logger.dart';
import 'package:ct484_final_project/configs/themes/theme.dart';
import 'package:ct484_final_project/ui/quiz/edit_quiz_screen.dart';
import 'package:ct484_final_project/services/firebase_quiz_service.dart';

class UserQuizScreen extends StatefulWidget {
  static const routeName = 'user-quiz-screen';
  const UserQuizScreen({super.key});

  @override
  State<UserQuizScreen> createState() => _UserQuizScreenState();
}

class _UserQuizScreenState extends State<UserQuizScreen> {
  final FirebaseQuizService quizService = FirebaseQuizService();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your quizzes'),
        actions: <Widget>[
          buildAddButton(context),
        ],
        backgroundColor: softblueColor,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: RefreshIndicator(
        key: _refreshKey,
        onRefresh: () async {
          setState(() {});
        },
        child: FutureBuilder(
          future: quizService.fetchAllQuizzes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: LoadingIndicator(
                    indicatorType: Indicator.ballSpinFadeLoader,
                    colors: kDefaultRainbowColors,
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
                          colors: kDefaultRainbowColors,
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
                            buildEditButton(context, quiz),
                            buildDeleteButton(context, quiz),
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
      ),
    );
  }

  Widget buildAddButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.add),
      onPressed: () {
        Navigator.pushReplacementNamed(
          context,
          EditQuizScreen.routeName,
          arguments: null,
        );
      },
    );
  }

  Widget buildEditButton(BuildContext context, QuizCourse quiz) {
    return IconButton(
      icon: const Icon(Icons.edit),
      onPressed: () {
        Navigator.pushReplacementNamed(
          context,
          EditQuizScreen.routeName,
          arguments: quiz,
        );
      },
      color: Theme.of(context).primaryColor,
    );
  }

  Widget buildDeleteButton(BuildContext context, QuizCourse quiz) {
    return IconButton(
      icon: const Icon(Icons.delete),
      onPressed: () {
        showDeleteConfirmationDialog(context, quiz);
      },
      color: Theme.of(context).colorScheme.error,
    );
  }

  void showDeleteConfirmationDialog(BuildContext context, QuizCourse quiz) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Quiz'),
          content: const Text('Are you sure you want to delete this quiz?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await quizService.deleteQuiz(quiz.id);

                if (context.mounted) {
                  Navigator.of(context, rootNavigator: true).pop();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Quiz deleted',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
                _refreshKey.currentState?.show();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
