import 'dart:math';
import 'package:flutter/material.dart';
import 'package:myapp/Activities/Mental_Marathon/QuizData.dart';
import 'package:myapp/Activities/Mental_Marathon/ReviewPage.dart';

class QuizModule extends StatefulWidget {
  @override
  _QuizModuleState createState() => _QuizModuleState();
}

class _QuizModuleState extends State<QuizModule> {
  List<String> selectedTopics = [];
  List<Map<String, dynamic>> quizQuestions = [];
  int currentQuestionIndex = 0;
  int correctAnswers = 0;
  String? selectedAnswer;
  List<String> selectedAnswers = [];

  @override
  void initState() {
    super.initState();
    // Select random topics
    selectedTopics = getRandomTopics();
    // Load questions for selected topics
    loadQuizQuestions();
  }

  List<String> getRandomTopics() {
    final random = Random();
    return List.generate(
        5, (index) => QuizData.topics[random.nextInt(QuizData.topics.length)]);
  }

  void loadQuizQuestions() {
    for (var topic in selectedTopics) {
      final randomQuestion = getRandomQuestionForTopic(topic);
      if (randomQuestion != null) {
        quizQuestions.add(randomQuestion);
      }
    }
  }

  Map<String, dynamic>? getRandomQuestionForTopic(String topic) {
    final questions = QuizData.topicQuestions[topic];
    final random = Random();

    if (questions != null && questions.isNotEmpty) {
      return questions[random.nextInt(questions.length)];
    }

    // Return null if questions are not available for the given topic
    return null;
  }

  void answerQuestion(String selectedOption) {
    // Check if an option is selected before processing
    if (selectedOption.isNotEmpty) {
      // Add selected answer to the list
      selectedAnswers.add(selectedOption);

      // Check if the selected option is the correct answer
      bool isAnswerCorrect = selectedOption ==
          quizQuestions[currentQuestionIndex]['correctAnswer'];

      if (isAnswerCorrect) {
        correctAnswers++;
      }

      // Move to the next question immediately after checking the answer
      moveToNextQuestion();
    }
  }

  void moveToNextQuestion() {
    setState(() {
      currentQuestionIndex++;
      selectedAnswer = null; // Reset selected answer
    });

    // Check if the quiz is completed
    if (currentQuestionIndex == selectedTopics.length) {
      // Navigate to the review page
      showResult();
    }
  }

  void showResult() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReviewPage(
          selectedAnswers: List.from(selectedAnswers),
          correctAnswers: quizQuestions
              .map((question) => question['correctAnswer'].toString())
              .toList(),
          totalScore: correctAnswers,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (currentQuestionIndex < selectedTopics.length) {
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 0, 111, 186),
        appBar: AppBar(
          title: Text('Quiz Module'),
        ),
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.95,
            height: MediaQuery.of(context).size.height * 0.55,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.65),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Question ${currentQuestionIndex + 1}:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    quizQuestions[currentQuestionIndex]['text'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: (quizQuestions[currentQuestionIndex]['options']
                            as List<String>)
                        .map((option) {
                      bool isSelected = selectedAnswer == option;
                      bool isCorrect = isSelected &&
                          selectedAnswer ==
                              quizQuestions[currentQuestionIndex]
                                  ['correctAnswer'];

                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: RadioListTile<String>(
                          title: Text(option),
                          value: option,
                          groupValue: selectedAnswer,
                          onChanged: (String? value) {
                            setState(() {
                              selectedAnswer = value;
                              answerQuestion(value!);
                            });
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      // No need to display anything here
      return SizedBox.shrink();
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: QuizModule(),
  ));
}
