import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:MindFulMe/Activities/Sherlock%20Holmes/quizsherdata.dart'
    // ignore: library_prefixes
    as QuizData;
import 'package:MindFulMe/Activities/cardview.dart';

class QuestionPage extends StatefulWidget {
  final List<QuizData.Question> questions;

  const QuestionPage({super.key, required this.questions});

  @override
  // ignore: library_private_types_in_public_api
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  int selectedOption = -1;
  int currentQuestionIndex = 0;
  bool showCorrectAnswer = false;
  List<int> selectedAnswers = [];
   final User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    selectedAnswers = List.filled(widget.questions.length, -1);
    
  }

  @override
  Widget build(BuildContext context) {
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
          'Questions',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 111, 186),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.95,
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.65),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Choose the correct option:',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 16,
              ),
              buildOptionTile(widget.questions[currentQuestionIndex]),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    showCorrectAnswer = true;
                  });

                  Future.delayed(const Duration(seconds: 3), () {
                    if (currentQuestionIndex < widget.questions.length - 1) {
                      setState(() {
                        currentQuestionIndex++;
                        selectedOption = -1;
                        showCorrectAnswer = false;
                      });
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultPage(
                            totalQuestions: widget.questions.length,
                            selectedAnswers: selectedAnswers,
                            questions: widget.questions,
                          ),
                        ),
                      );

                    }
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text('Submit Answer',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOptionTile(QuizData.Question question) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Text(
          question.question,
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        for (int i = 0; i < question.options.length; i++)
          buildOption(question, i),
      ],
    );
  }

  Widget buildOption(QuizData.Question question, int optionIndex) {
    bool isCorrect = question.correctAnswerIndex == optionIndex;
    bool isSelected = selectedOption == optionIndex;
    bool isUserSelectedCorrect = showCorrectAnswer && isCorrect;
    bool isUserSelectedIncorrect =
        showCorrectAnswer && isSelected && !isCorrect;

    return IgnorePointer(
      ignoring: isSelected,
      child: Opacity(
        opacity: isSelected ? 0.5 : 1.0,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          margin: const EdgeInsets.symmetric(vertical: 6.0),
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              color: isCorrect
                  ? (isUserSelectedCorrect ? Colors.green : Colors.black)
                  : Colors.black,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
            color: isUserSelectedIncorrect
                ? Colors.red.withOpacity(0.8)
                : (isUserSelectedCorrect
                    ? Colors.green.withOpacity(0.8)
                    : Colors.white),
          ),
          child: RadioListTile<int>(
            title: Text(
              question.options[optionIndex],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            value: optionIndex,
            groupValue: selectedOption,
            onChanged: isSelected
                ? null
                : (value) {
                    setState(() {
                      selectedOption = value!;
                      selectedAnswers[currentQuestionIndex] = selectedOption;
                      print(selectedAnswers);
                    });
                  },
            activeColor: Colors.white,
          ),
        ),
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  final int totalQuestions;
  final List<int> selectedAnswers;
  final List<QuizData.Question> questions;

  const ResultPage({
    Key? key,
    required this.totalQuestions,
    required this.selectedAnswers,
    required this.questions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int correctAnswers = 0;
    int incorrectAnswers = 0;

    // Calculate correct and incorrect answers
    for (int i = 0; i < totalQuestions; i++) {
      if (selectedAnswers[i] == questions[i].correctAnswerIndex) {
        correctAnswers++;
      } else {
        incorrectAnswers++;
      }
    }
      final User? user = FirebaseAuth.instance.currentUser;
  final userDoc = FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .collection('SherlockHolmes')
        .doc('data1');

      final userData =  userDoc.get();
     userDoc.set({'correctAnswers':'$correctAnswers','incorrectAnswer':'$incorrectAnswers' }, SetOptions(merge: true));
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Correct Answers: $correctAnswers',
              style: TextStyle(fontSize: 24),
              
            ),
            SizedBox(height: 16),
            Text(
              'Incorrect Answers: $incorrectAnswers',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
