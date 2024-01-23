import 'package:myapp/onbording.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});
  
  @override
  Widget build(context) {
    return Center(
        child: Column(     
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          'assets/welcome.svg', // Replace with the path to your SVG image
          width: 300,
          height: 300,
        ),
        const SizedBox(
          height: 50,
        ),
        const Text(
          'Hey Welcome!',
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          width: 350,
          child: const Text(
            'Your mindful mental health companion for everyone, anywhere 🍃',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const OnboardingScreen()),
            );
          },
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Get Started'),
              SizedBox(width: 8), // Adjust the spacing between text and icon
              Icon(Icons.add_reaction_rounded),
            ],
          ),
        ),
      ],
    ));
  }
}
