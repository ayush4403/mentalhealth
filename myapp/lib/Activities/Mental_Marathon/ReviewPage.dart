// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:MindFulMe/Activities/cardview.dart';
import 'package:lottie/lottie.dart';

class ReviewPage extends StatelessWidget {
  final List<String> selectedAnswers;
  final List<String> correctAnswers;
  final int totalScore;

  ReviewPage({
    super.key,
    required this.selectedAnswers,
    required this.correctAnswers,
    required this.totalScore,
  });
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final weekDoc = FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .collection('mentalmarathon')
        .doc('data1');

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
            height: MediaQuery.of(context).size.height * 0.85,
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
                    height: 30,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        // ignore: unused_local_variable
                        final userData = weekDoc.get();
                        weekDoc.set({
                          'correctAnswers': totalScore,
                          'incorrectAnswers': 5 - totalScore
                        }, SetOptions(merge: true));
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CardView(),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _openAnimatedDialog(context); // Show the dialog
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CardView(),
                                ),
                              );
                            },
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(
                                const Size(
                                  200,
                                  50,
                                ),
                              ),
                            ),
                            child: const Text(
                              'Activity Done',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
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

  void _openAnimatedDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return Container();
      },
      transitionBuilder: (context, a1, a2, widget) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.5, end: 1).animate(a1),
          child: AlertDialog(
            backgroundColor: Colors.transparent,
            content: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 100, // Adjust height as needed
                        color: Colors.red, // Upper part background color
                      ),
                      SizedBox(
                        height:
                            2, // Adjust the thickness of the horizontal line
                        child: Container(
                          color: Colors.grey, // Color of the horizontal line
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            const Text(
                              'Great Job!',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'You have successfully completed today\'s activity. You have earned 50 coins for it. Come back tomorrow for more.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context); // Close the dialog box
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors
                                    .blue, // Change button color if needed
                              ),
                              child: const Text(
                                'OK',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 40, // Adjust positioning as needed
                    left: MediaQuery.of(context).size.width / 2 - 125,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white, // Circular background color
                        border: Border.all(
                          color: Colors.black, // Border color
                          width: 2, // Adjust the border width as needed
                        ),
                      ),
                      child: Lottie.asset(
                        'assets/GIF/ShowDialog/trophy.json',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
