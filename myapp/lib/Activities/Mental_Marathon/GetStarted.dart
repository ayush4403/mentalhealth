// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:MindFulMe/Activities/Mental_Marathon/QuizModule.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 111, 186),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/Images/Mental Mararthon/Baloon.png', // Replace with the actual image path
              width: 400, // Adjust the width as needed
              height: 400, // Adjust the height as needed
            ),
            const SizedBox(height: 20),
            const Text(
              'Welcome to our Mental Marathon',
              style: TextStyle(
                color: Colors.white, // Set your desired text color
                fontSize: 24, // Adjust the font size as needed
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Do you feel confident? Here you will face our most difficult questions! Get Ready',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const QuizModule()));
                },
                child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(16),
                    width: 250,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Get Started',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: GetStartedPage(),
  ));
}
