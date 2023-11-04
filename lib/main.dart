import 'package:ct484_final_project/models/quiz.dart';
import 'package:ct484_final_project/services/quiz_service.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:ct484_final_project/services/firebase_service.dart';
import 'package:ct484_final_project/ui/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final firebaseService = FirebaseService();
  await firebaseService.initializeFirestore();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late QuizService _quizService;
  late QuizCourse _quizData;

  @override
  void initState() {
    super.initState();
    _quizService = QuizService();

    // Replace 'ct293' with your desired quiz ID
    _fetchQuizData('ct293');
  }

  Future<void> _fetchQuizData(String quizId) async {
    final quizData = await _quizService.fetchQuizData(quizId);

    if (quizData != null) {
      setState(() {
        _quizData = quizData;
      });

      print('Quiz Title: ${_quizData.title}');
      print('Description: ${_quizData.description}');
      print('Time (seconds): ${_quizData.timeSeconds}');

      // Print questions and answers
      for (final question in _quizData.questions ?? []) {
        print('Question: ${question.question}');
        for (final answer in question.answers ?? []) {
          print('Answer: ${answer.answer}');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const SplashScreen());
  }
}
