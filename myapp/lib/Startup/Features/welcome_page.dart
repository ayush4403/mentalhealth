import 'package:MindFulMe/Startup/Features/content_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.indigo.shade800,
                  Colors.indigoAccent.shade200,
                  Colors.indigoAccent.shade200,
                ],
              ),
            ),
          ),
          const Positioned(
            top: 250,
            left: 0,
            right: 0,
            child: Text(
              "Hey Welcome!",
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.w900,
                height: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const Positioned(
            top: 300,
            left: 5,
            right: 5,
            child: Text(
              "Your Mental Health Companion   is here🍃",
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.w900,
                height: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(),
          Positioned(
            bottom: 0,
            left: -10,
            right: -10,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.9),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(
                    2000,
                  ),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 300),
                  FractionallySizedBox(
                    widthFactor: .6,
                    child: FilledButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const OnbordingContent(),
                            ),
                          );
                        },
                        child: const Text("GET STARTED")),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 120,
            left: 10,
            right: 10,
            child: Lottie.asset('assets/lottie/yoga2.json'),
          ),
        ],
      ),
    );
  }
}
