import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:ct484_final_project/models/quiz.dart';
import 'package:ct484_final_project/utils/app_logger.dart';
import 'package:ct484_final_project/configs/themes/theme.dart';
import 'package:ct484_final_project/ui/quiz/user_quiz_screen.dart';
import 'package:ct484_final_project/services/firebase_quiz_service.dart';

class EditQuizScreen extends StatefulWidget {
  static const routeName = 'edit-quiz-screen';

  EditQuizScreen(
    QuizCourse? quizCourse, {
    super.key,
  }) {
    if (quizCourse == null) {
      this.quizCourse = QuizCourse(
        id: const Uuid().v4(),
        title: '',
        imageUrl: '',
        description: '',
        timeSeconds: 0,
        questions: [],
      );
    } else {
      this.quizCourse = quizCourse;
    }
  }

  late final QuizCourse quizCourse;

  @override
  State<EditQuizScreen> createState() => _EditQuizScreenState();
}

class _EditQuizScreenState extends State<EditQuizScreen> {
  final _formKey = GlobalKey<FormState>();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();

  var _isLoading = false;

  bool _isValidImageUrl(String value) {
    return (value.startsWith('http') || value.startsWith('https')) &&
        (value.endsWith('.png') ||
            value.endsWith('.jpg') ||
            value.endsWith('jpeg'));
  }

  @override
  void initState() {
    super.initState();
    _imageUrlController.text = widget.quizCourse.imageUrl ?? '';
    _imageUrlFocusNode.addListener(() {
      if (!_imageUrlFocusNode.hasFocus) {
        if (!_isValidImageUrl(_imageUrlController.text)) {
          return;
        }
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    _formKey.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    try {
      AppLogger.info('Form: ${widget.quizCourse}');

      await FirebaseQuizService().saveQuiz(widget.quizCourse);
    } catch (error) {
      if (mounted) {
        AppLogger.error('Something went wrong.');
      }
    }

    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      Navigator.pushReplacementNamed(
        context,
        UserQuizScreen.routeName,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Quiz'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: _saveForm,
            ),
          ],
          backgroundColor: softblueColor,
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      buildTitleField(),
                      buildDescriptionField(),
                      buildQuizPreview(),
                      buildTimeField(),
                      ...widget.quizCourse.questions!
                          .map((question) => buildQuestionWidget(question)),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            final newQuestion = Question(
                              id: const Uuid().v4(),
                              question: '',
                              answers: [],
                              correctAnswer: '',
                            );
                            widget.quizCourse.questions!.add(newQuestion);
                          });
                        },
                        child: const Text('Add Question'),
                      ),
                    ],
                  ),
                ),
              ));
  }

  TextFormField buildTitleField() {
    return TextFormField(
      initialValue: widget.quizCourse.title,
      decoration: const InputDecoration(labelText: 'Title'),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a value';
        }
        return null;
      },
      onSaved: (value) {
        AppLogger.info('Title is: ${value.toString()}');
        widget.quizCourse.title = value!;
      },
    );
  }

  TextFormField buildDescriptionField() {
    return TextFormField(
      initialValue: widget.quizCourse.description,
      decoration: const InputDecoration(labelText: 'Description'),
      maxLines: 3,
      keyboardType: TextInputType.multiline,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a description.';
        }
        if (value.length < 10) {
          return 'Should be at least 10 characters long.';
        }

        return null;
      },
      onSaved: (value) {
        widget.quizCourse.description = value!;
      },
    );
  }

// Image preview
  buildQuizPreview() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          width: 100,
          height: 100,
          margin: const EdgeInsets.only(
            top: 8,
            right: 10,
          ),
          decoration: BoxDecoration(
              border: Border.all(
                width: 0.2,
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(8)),
          child: _imageUrlController.text.isEmpty
              ? FittedBox(
                  child: Image.asset(
                    'assets/images/upload.png',
                    fit: BoxFit.cover,
                  ),
                )
              : FittedBox(
                  child: CachedNetworkImage(
                    imageUrl: _imageUrlController.text,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
        Expanded(
          child: buildImageURLField(),
        ),
      ],
    );
  }

  TextFormField buildTimeField() {
    return TextFormField(
      initialValue: widget.quizCourse.timeSeconds.toString(),
      decoration: const InputDecoration(labelText: 'Time (seconds)'),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a time in seconds.';
        }
        if (double.tryParse(value) == null) {
          return 'Please enter a valid number';
        }
        if (double.parse(value) <= 0) {
          return 'Please enter a number greater than zero';
        }
        return null;
      },
      onSaved: (value) {
        widget.quizCourse.timeSeconds = int.parse(value!);
      },
    );
  }

  TextFormField buildImageURLField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Image URL'),
      keyboardType: TextInputType.url,
      textInputAction: TextInputAction.done,
      controller: _imageUrlController,
      focusNode: _imageUrlFocusNode,
      onFieldSubmitted: (value) => _saveForm(),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter an image URL';
        }
        if (!_isValidImageUrl(value)) {
          return 'Please enter a valid image URL';
        }
        return null;
      },
      onSaved: (value) {
        widget.quizCourse.imageUrl = value;
      },
    );
  }

  Widget buildQuestionWidget(Question question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                initialValue: question.question,
                decoration: const InputDecoration(labelText: 'Question'),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please provide a question';
                  }
                  return null;
                },
                onSaved: (value) {
                  question.question = value!;
                },
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close),
              color: redColor,
              onPressed: () {
                AppLogger.info('deleteQuestion');
                setState(() {
                  widget.quizCourse.questions!.remove(question);
                });
              },
            ),
          ],
        ),
        ...question.answers!
            .map((answer) => buildAnswerWidget(question, answer)),
        ElevatedButton(
          onPressed: () {
            setState(() {
              final newAnswer = Answer(
                identifier: UniqueKey().toString(),
                text: '',
              );

              question.answers!.add(newAnswer);
              question.setCorrectAnswer(newAnswer.identifier);
            });
          },
          child: const Text('Add Answer'),
        ),
      ],
    );
  }

  Widget buildAnswerWidget(Question question, Answer answer) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            initialValue: answer.text,
            decoration: const InputDecoration(labelText: 'Answer'),
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please provide an answer';
              }
              return null;
            },
            onSaved: (value) {
              answer.text = value!;
            },
          ),
        ),
        Radio(
          value: answer.identifier,
          groupValue: question.correctAnswer,
          onChanged: (String? value) {
            setState(() {
              question.setCorrectAnswer(value!);
            });
          },
        ),
        IconButton(
          icon: const Icon(Icons.close),
          color: redColor,
          onPressed: () {
            setState(() {
              question.answers!.remove(answer);
            });
          },
        ),
      ],
    );
  }
}
