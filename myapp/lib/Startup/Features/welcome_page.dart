import 'package:MindFulMe/Graphs/resources/app_resources.dart';
import 'package:flutter/material.dart';
import 'package:MindFulMe/Startup/Features/onbording.dart';
import 'package:lottie/lottie.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  bool isButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              'assets/GIF/Features/getStarted.json',
              height: MediaQuery.of(context).size.height * 0.38,
              width: MediaQuery.of(context).size.width * 0.9,
              fit: BoxFit.fill,
            ),
            const SizedBox(height: 20),
            Text(
              'Hey Welcome!',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 350,
              child: Text(
                'Your mindful mental health companion for everyone, anywhere 🍃',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OnboardingScreen(),
                  ),
                );
              },
              onTapDown: (_) {
                setState(() {
                  isButtonPressed = true;
                });
              },
              onTapUp: (_) {
                setState(() {
                  isButtonPressed = false;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 15,
                ),
                decoration: BoxDecoration(
                  color: isButtonPressed
                      ? Colors.white
                      : const Color.fromARGB(255, 47, 207, 255),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isButtonPressed
                            ? Colors.white
                            : Colors.white,
                      ),
                    ),
                    const SizedBox(
                        width: 9), // Adjust the spacing between text and icon
                    Icon(
                      Icons.add_reaction_rounded,
                      color: isButtonPressed
                          ? const Color.fromARGB(255, 47, 207, 255)
                          : Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}