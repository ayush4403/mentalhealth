// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:MindFulMe/Activities/cardview.dart';

class ReviewPage extends StatelessWidget {
  final List<String> selectedAnswers;
  final List<String> correctAnswers;
  final int totalScore;

  const ReviewPage({
    super.key,
    required this.selectedAnswers,
    required this.correctAnswers,
    required this.totalScore,
  });

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        // Navigate to a particular screen when the back button is pressed
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const CardView()),
        );
        // Return false to prevent the default back button behavior
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 0, 111, 186),
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.95,
            height: MediaQuery.of(context).size.height * 0.80,
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
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Review your quiz:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 20),
                  for (int i = 0; i < selectedAnswers.length; i++)
                    ReviewItem(
                      questionNumber: i + 1,
                      selectedAnswer: selectedAnswers[i],
                      correctAnswer: correctAnswers[i],
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      'Total Score: $totalScore/5',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CardView()));
                      },
                      child: Container(
                        //width: 250,
                        //height: 60,
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Column(
                          children: [
                            Text(
                              'Activity Done',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ReviewItem extends StatelessWidget {
  final int questionNumber;
  final String selectedAnswer;
  final String correctAnswer;

  const ReviewItem({
    super.key,
    required this.questionNumber,
    required this.selectedAnswer,
    required this.correctAnswer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Question $questionNumber:',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          Text(
            'Your Answer: $selectedAnswer',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          Text(
            'Correct Answer: $correctAnswer',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const Divider(), // Add a divider for separation
        ],
      ),
    );
  }
}

class YourParticularScreen extends StatelessWidget {
  const YourParticularScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Replace this with your particular screen UI
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Particular Screen'),
      ),
      body: const Center(
        child: Text('Your particular screen content goes here'),
      ),
    );
  }
}
