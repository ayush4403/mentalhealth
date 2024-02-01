import 'package:flutter/material.dart';
import 'package:myapp/Features/onbording.dart';
import 'package:lottie/lottie.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  bool isButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 111, 186),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              'assets/GIF/getStarted.json',
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
                      color: Theme.of(context).colorScheme.onBackground,
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
                            ? const Color.fromARGB(255, 47, 207, 255)
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
