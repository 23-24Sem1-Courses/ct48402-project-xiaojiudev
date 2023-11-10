import 'package:flutter/material.dart';
import 'package:ct484_final_project/models/quiz.dart';

class QuizProvider with ChangeNotifier {
  QuizCourse? _currentQuiz;

  QuizCourse? get currentQuiz => _currentQuiz;

  void setQuiz(QuizCourse quiz) {
    _currentQuiz = quiz;
    notifyListeners();
  }
}
