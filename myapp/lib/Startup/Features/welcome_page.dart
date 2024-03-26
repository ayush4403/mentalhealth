<<<<<<< HEAD
import 'package:MindFulMe/Startup/Features/content_model.dart';
=======
import 'package:MindFulMe/Graphs/resources/app_resources.dart';
>>>>>>> 7ce2e9795b4ca207b96ad9981a06d88be17140d3
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
<<<<<<< HEAD
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
=======
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
>>>>>>> 7ce2e9795b4ca207b96ad9981a06d88be17140d3
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
<<<<<<< HEAD
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
=======
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
>>>>>>> 7ce2e9795b4ca207b96ad9981a06d88be17140d3
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
            left: 0,
            right: 0,
            child: Lottie.asset('assets/GIF/Welcome/Welcome.json'),
          ),
        ],
      ),
    );
  }
}