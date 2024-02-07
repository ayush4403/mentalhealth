import 'package:flutter/material.dart';
import 'package:myapp/Features/content_model.dart';
import 'package:lottie/lottie.dart';
import 'package:myapp/Registration/signin.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentPage = 0; // Variable to keep track of the current slide index
  bool isButtonPressed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 111, 186),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: PageView.builder(
                  itemCount: contents.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                  itemBuilder: (_, i) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(30, 140, 30, 40),
                      child: Column(
                        children: [
                          Lottie.asset(
                            'assets/GIF/Features/gif${i + 1}.json',
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.width * 0.75,
                            fit: BoxFit.fill,
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Text(
                            contents[i].title,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            contents[i].discription,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.052,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            top: 50,
            right: 25,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignInScreen(),
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
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: isButtonPressed
                      ? Colors.white
                      : const Color.fromARGB(255, 47, 207, 255),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Skip',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.normal,
                        color: isButtonPressed
                            ? const Color.fromARGB(255, 47, 207, 255)
                            : Colors.white,
                      ),
                    ),
                    const SizedBox(
                        width: 2), // Adjust the spacing between text and icon
                    Icon(
                      Icons.skip_next,
                      color: isButtonPressed
                          ? const Color.fromARGB(255, 47, 207, 255)
                          : Colors.white,
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                contents.length,
                (index) => buildDot(index),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDot(int index) {
    return Container(
      margin: const EdgeInsets.all(4),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: currentPage == index
            ? const Color.fromARGB(255, 47, 207, 255)
            : Colors.white,
      ),
    );
  }
}
