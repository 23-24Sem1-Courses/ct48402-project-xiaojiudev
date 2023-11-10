import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ct484_final_project/models/quiz.dart';
import 'package:ct484_final_project/utils/app_logger.dart';

class FirebaseQuizService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ignore: constant_identifier_names
  static const String FIREBASE_QUIZ_COLLECTION = 'quizzes';

  Future<void> saveQuiz(QuizCourse quiz) async {
    try {
      final quizData = {
		'id': quiz.id,
        'title': quiz.title,
        'image_url': quiz.imageUrl,
        'Description': quiz.description,
        'time_seconds': quiz.timeSeconds,
        'questions': quiz.questions!.map((question) {
          return {
			'id': question.id,
            'question': question.question,
            'correct_answer': question.correctAnswer,
            'answers': question.answers!.map((answer) {
              return {
                'identifier': answer.identifier,
                'text': answer.text,
              };
            }).toList(),
          };
        }).toList(),
      };

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
                  text: answerData['text'],
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
}
