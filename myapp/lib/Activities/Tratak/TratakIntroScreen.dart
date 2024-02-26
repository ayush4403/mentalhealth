import 'package:MindFulMe/Activities/Tratak/TratakPage.dart';
import 'package:MindFulMe/Activities/cardview.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TratakaIntroScreen extends StatelessWidget {
  const TratakaIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 111, 186),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop(const CardView());
          },
        ),
        title: const Text(
          'Tratak',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 111, 186),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment:
              CrossAxisAlignment.center, // Align text in the center
          children: [
            Lottie.asset(
              'assets/GIF/Card_view/12_Tratak.json',
              width: 300,
              height: 300,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            const Text(
              'Welcome to Tratak',
              style: TextStyle(
                color: Colors.white, // Set your desired text color
                fontSize: 24, // Adjust the font size as needed
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            const SizedBox(
              height: 10,
            ),
            const Text(
              'Instructions:',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            // Wrap each instruction in a Container for better control
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: const Text(
                '1. Find a quiet and comfortable place to sit.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: const Text(
                '2. Look at the candle\'s flame.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: const Text(
                '3. Focus your gaze on the flame without blinking.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: const Text(
                '4. Try to maintain your focus for the entire duration of the activity.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TratakaActivity(),
                    ),
                  );
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
                    'Start Tratak',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
