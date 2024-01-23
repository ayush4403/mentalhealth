import 'package:flutter/material.dart';
import 'package:myapp/onbording.dart';
import 'package:lottie/lottie.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Wrap your content with Scaffold
      backgroundColor: const Color.fromARGB(
          255, 89, 201, 253), // Set the background color of the Scaffold
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              'assets/getStarted.json',
              height: 350,
              width: 350,
              fit: BoxFit.fill,
            ),
            const SizedBox(height: 50),
            const Text(
              'Hey Welcome!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            Container(
              width: 350,
              child: const Text(
                'Your mindful mental health companion for everyone, anywhere 🍃',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const OnboardingScreen()),
                );
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                      width: 5), // Adjust the spacing between text and icon
                  Icon(Icons.add_reaction_rounded),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
