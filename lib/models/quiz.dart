class Answer {
  final String identifier;
  final String text;

  Answer({
    required this.identifier,
    required this.text,
  });

  Answer copyWith({
    String? identifier,
    String? text,
  }) {
    return Answer(
      identifier: identifier ?? this.identifier,
      text: text ?? this.text,
    );
  }
}

class Question {
  final String id;
  final String question;
  final List<Answer>? answers;
  final String correctAnswer;

  Question({
    required this.id,
    required this.question,
    this.answers,
    required this.correctAnswer,
  });

  Question copyWith({
    String? id,
    String? question,
    List<Answer>? answers,
    String? correctAnswer,
  }) {
    return Question(
      id: id ?? this.id,
      question: question ?? this.question,
      answers: answers ?? this.answers,
      correctAnswer: correctAnswer ?? this.correctAnswer,
    );
  }
}

class QuizCourse {
  final String id;
  final String title;
  final String? imageUrl;
  final String description;
  final int timeSeconds;
  final List<Question>? questions;

  QuizCourse({
    required this.id,
    required this.title,
    this.imageUrl,
    required this.description,
    required this.timeSeconds,
    this.questions,
  });

  QuizCourse copyWith({
    String? id,
    String? title,
    String? imageUrl,
    String? description,
    int? timeSeconds,
    List<Question>? questions,
  }) {
    return QuizCourse(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      timeSeconds: timeSeconds ?? this.timeSeconds,
      questions: questions ?? this.questions,
    );
  }
}