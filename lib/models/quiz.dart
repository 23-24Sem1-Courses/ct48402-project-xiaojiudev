class Answer {
  String identifier;
  String text;

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

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      identifier: json['identifier'],
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'identifier': identifier,
      'text': text,
    };
  }
}

class Question {
  String id;
  late String question;
  List<Answer>? answers;
  String correctAnswer;

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

  void setCorrectAnswer(String newCorrectAnswer) {
    correctAnswer = newCorrectAnswer;
  }

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      question: json['question'],
      correctAnswer: json['correct_answer'],
      answers: (json['answers'] as List<dynamic>?)
          ?.map((answerJson) => Answer.fromJson(answerJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'correct_answer': correctAnswer,
      'answers': answers?.map((answer) => answer.toJson()).toList(),
    };
  }
}

class QuizCourse {
  String id;
  String title;
  String? imageUrl;
  String description;
  int timeSeconds;
  List<Question>? questions;

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

  factory QuizCourse.fromJson(Map<String, dynamic> json) {
    return QuizCourse(
      id: json['id'],
      title: json['title'],
      imageUrl: json['image_url'],
      description: json['Description'],
      timeSeconds: json['time_seconds'],
      questions: (json['questions'] as List<dynamic>?)
          ?.map((questionJson) => Question.fromJson(questionJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image_url': imageUrl,
      'Description': description,
      'time_seconds': timeSeconds,
      'questions': questions?.map((question) => question.toJson()).toList(),
    };
  }
}
