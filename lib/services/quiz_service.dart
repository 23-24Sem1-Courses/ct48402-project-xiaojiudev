import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ct484_final_project/models/quiz.dart';
import 'package:ct484_final_project/utils/app_logger.dart';

class QuizService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<QuizCourse>> fetchAllQuizzes() async {
    try {
      final querySnapshot = await _firestore.collection('quizzes').get();

      final quizzes = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;

		// AppLogger.info(data);

        return QuizCourse(
          id: data['id'],
          title: data['title'],
          imageUrl: data['image_url'],
          description: data['Description'],
          timeSeconds: data['time_seconds'],
          questions: (data['questions'] as List).map((questionData) {
            return Question(
              id: questionData['id'],
              question: questionData['question'],
              correctAnswer: questionData['correct_answer'],
              answers: (questionData['answers'] as List).map((answerData) {
                return Answer(
                  identifier: answerData['identifier'],
                  answer: answerData['Answer'],
                );
              }).toList(),
            );
          }).toList(),
        );
      }).toList();

      return quizzes;
    } catch (e) {
      AppLogger.error(e);
      return [];
    }
  }

  Future<QuizCourse?> fetchQuizData(String quizId) async {
    try {
      final DocumentSnapshot doc =
          await _firestore.collection('quizzes').doc(quizId).get();

      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;

        return QuizCourse(
          id: data['id'],
          title: data['title'],
          imageUrl: data['image_url'],
          description: data['Description'],
          timeSeconds: data['time_seconds'],
          questions: (data['questions'] as List).map((questionData) {
            return Question(
              id: questionData['id'],
              question: questionData['question'],
              correctAnswer: questionData['correct_answer'],
              answers: (questionData['answers'] as List).map((answerData) {
                return Answer(
                  identifier: answerData['identifier'],
                  answer: answerData['Answer'],
                );
              }).toList(),
            );
          }).toList(),
        );
      } else {
		AppLogger.warning('Quiz with ID $quizId not found.');
        return null;
      }
    } catch (error) {
	  AppLogger.error('Error fetching quiz data: $error');
      return null;
    }
  }
}
