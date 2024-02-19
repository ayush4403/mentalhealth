import 'package:flutter/material.dart';
import 'package:myapp/Activities/cardview.dart';

class ReviewPage extends StatelessWidget {
  final List<String> selectedAnswers;
  final List<String> correctAnswers;
  final int totalScore;

  ReviewPage({
    required this.selectedAnswers,
    required this.correctAnswers,
    required this.totalScore,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Navigate to a particular screen when the back button is pressed
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CardView()),
        );
        // Return false to prevent the default back button behavior
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 0, 111, 186),
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
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      'Total Score: $totalScore/5',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
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

  ReviewItem({
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
  @override
  Widget build(BuildContext context) {
    // Replace this with your particular screen UI
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Particular Screen'),
      ),
      body: Center(
        child: Text('Your particular screen content goes here'),
      ),
    );
  }
}
