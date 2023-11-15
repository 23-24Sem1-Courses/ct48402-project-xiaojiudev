import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ct484_final_project/models/quiz.dart';
import 'package:ct484_final_project/utils/app_logger.dart';

class FirebaseQuizService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ignore: constant_identifier_names
  static const String FIREBASE_QUIZ_COLLECTION = 'quizzes';

  Future<void> saveQuiz(QuizCourse quiz) async {
    try {
      final quizData = quiz.toJson();

      await _firestore
          .collection(FIREBASE_QUIZ_COLLECTION)
          .doc(quiz.id)
          .set(quizData);
    } catch (e) {
      AppLogger.error(e);
    }
  }

  Future<void> deleteQuiz(String quizId) async {
    try {
      await _firestore
          .collection(FIREBASE_QUIZ_COLLECTION)
          .doc(quizId)
          .delete();
    } catch (e) {
      AppLogger.error(e);
    }
  }

  Future<List<QuizCourse>> fetchAllQuizzes() async {
    try {
      final querySnapshot =
          await _firestore.collection(FIREBASE_QUIZ_COLLECTION).get();

      final quizzes = querySnapshot.docs.map((doc) {
        final data = doc.data();

        return QuizCourse.fromJson(data);
      }).toList();

      return quizzes;
    } catch (e) {
      AppLogger.error(e);
      return [];
    }
  }
}
