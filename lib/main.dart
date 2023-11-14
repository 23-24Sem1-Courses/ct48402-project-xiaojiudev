import 'package:ct484_final_project/ui/quiz/quiz_provider.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:ct484_final_project/ui/screen.dart';
import 'package:ct484_final_project/models/quiz.dart';
import 'package:ct484_final_project/services/firebase_init_quiz_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final initQuizService = InitQuizService();
  await initQuizService.initializeFirestore();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => QuizProvider()),
      ],
      child: MaterialApp(
        title: 'Study Quiz Application',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const SplashScreen(),
        routes: {
          MenuScreen.routeName: (ctx) => MenuScreen(),
          UserQuizScreen.routeName: (ctx) => const UserQuizScreen(),
          EditQuizScreen.routeName: (ctx) {
            final quiz = ModalRoute.of(ctx)!.settings.arguments as QuizCourse?;
            return EditQuizScreen(quiz);
          },
        },
        onGenerateRoute: (settings) {
          if (settings.name == QuizScreen.routeName) {
            final quiz = settings.arguments as QuizCourse;
            return MaterialPageRoute(
              builder: (context) => QuizScreen(quiz: quiz),
            );
          }

          if (settings.name == DetailScreen.routeName) {
            final arguments = settings.arguments as Map<String, dynamic>;
            final questions = arguments['questions'] as List<Question>;
            final timeCountdown = arguments['timeCountdown'] as int;

            return MaterialPageRoute(
              builder: (context) => DetailScreen(
                questions: questions,
                timeCountdown: timeCountdown,
              ),
            );
          }

          if (settings.name == ResultScreen.routeName) {
            final arguments = settings.arguments as Map<String, dynamic>;
            final correctQuestion = arguments['correctQuestion'] as int;
            final totalQuestions = arguments['totalQuestions'] as int;

            return MaterialPageRoute(
              builder: (context) => ResultScreen(
                correctQuestion: correctQuestion,
                totalQuestions: totalQuestions,
              ),
            );
          }
        },
      ),
    );
  }
}
