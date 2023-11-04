import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ct484_final_project/models/quiz.dart';

class QuizService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
        print('Quiz with ID $quizId not found.');
        return null;
      }
    } catch (error) {
      print('Error fetching quiz data: $error');
      return null;
    }
  }
}
