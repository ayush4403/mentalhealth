// ignore_for_file: file_names
import 'dart:math';
import 'package:MindFulMe/Graphs/resources/app_resources.dart';
import 'package:flutter/material.dart';
import 'package:MindFulMe/Activities/Mental_Marathon/QuizData.dart';
import 'package:MindFulMe/Activities/Mental_Marathon/ReviewPage.dart';
import 'package:MindFulMe/Activities/cardview.dart';

class QuizModule extends StatefulWidget {
  const QuizModule({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
    selectedTopics = getRandomTopics();
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

    return null;
  }

  void answerQuestion(String selectedOption) {
    if (selectedOption.isNotEmpty) {
      selectedAnswers.add(selectedOption);
      bool isAnswerCorrect = selectedOption ==
          quizQuestions[currentQuestionIndex]['correctAnswer'];

      if (isAnswerCorrect) {
        correctAnswers++;
      }

      moveToNextQuestion();
    }
  }

  void moveToNextQuestion() {
    setState(() {
      currentQuestionIndex++;
      selectedAnswer = null;
    });

    if (currentQuestionIndex == selectedTopics.length) {
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
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pop(const CardView());
            },
          ),
          title: const Text(
            'Mental Marathon',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 0, 111, 186),
        ),
        // ignore: deprecated_member_use
        body: WillPopScope(
          onWillPop: () async {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const CardView()));
            return true;
          },
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.indigo.shade800,
                        Colors.indigoAccent.shade200,
                        Colors.indigoAccent.shade200,
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 50,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Question ${currentQuestionIndex + 1}:',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        quizQuestions[currentQuestionIndex]['text'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 250,
                left: 10,
                right: 10,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.9),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(
                        100,
                      ),
                      bottom: Radius.circular(
                        100,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      for (var option in quizQuestions[currentQuestionIndex]
                          ['options'])
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                selectedAnswer = option;
                                answerQuestion(option);
                              });
                            },
                            child: Text(
                              option,
                              style: TextStyle(
                                  fontSize: 18, color: AppColors.primaryColor),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

void main() {
  runApp(const MaterialApp(
    home: QuizModule(),
  ));
}
