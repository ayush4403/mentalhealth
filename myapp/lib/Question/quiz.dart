import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:myapp/home.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  double sliderValue = 5.0;
  List<Map<String, dynamic>> questions = [
    {
      'question': 'On a scale of 1 to 10, how would you rate your overall well-being today?',
      'image': 'assets/GIF/Qgif1.json',
      'isSlider': true,
    },
    {
      'question': 'Are you often very critical of yourself?',
      'image': 'assets/GIF/Qgif2.json',
      'options': ['Extremely', 'Frequently', 'Rarely', 'Not at all'],
    },
    {
      'question': 'How satisfied are you with your current social interaction and connections?',
      'image': 'assets/GIF/Qgif3.json',
      'options': ['Very Well', 'Moderately', 'Struggling', 'Not at all'],
    },
    {
      'question': 'Are you currently experiencing stress related to work or academic responsibilities?',
      'image': 'assets/GIF/Qgif4.json',
      'options': ['Occasionally', 'Moderately', 'Frequently', 'Not at all'],
    },
    {
      'question': 'How much are you currently coping up with stress or difficult emotions?',
      'image': 'assets/GIF/Qgif5.json',
      'options': ['Very Well', 'Moderately', 'Struggling', 'Not at all'],
    },
  ];

  int currentQuestionIndex = 0;
  List<Map<String, dynamic>> userSelectedOptions = [];
  bool isNextButtonEnabled() {
    if (questions[currentQuestionIndex]['isSlider'] == true) {
      return true;
    } else {
      return userSelectedOptions.isNotEmpty;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 42, 164, 225),
                Color.fromARGB(255, 42, 164, 225)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 15.0),
              if (questions[currentQuestionIndex]['image'] != null)
                Lottie.asset(
                  questions[currentQuestionIndex]['image'],
                  height: 250.0,
                  width: 220,
                  fit: BoxFit.fill,
                ),
              const SizedBox(height: 10.0),
              Text(
                questions[currentQuestionIndex]['question'],
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 60.0),
              // Options
              if (currentQuestionIndex == 0 && questions[0]['isSlider'] == true)
                Column(
                  children: [
                    Slider(
                      value: sliderValue,
                      onChanged: (newValue) {
                        setState(() {
                          sliderValue = newValue;
                        });
                      },
                      min: 1.0,
                      max: 10.0,
                      divisions: 9,
                      label: sliderValue.round().toString(),
                      activeColor: const Color.fromARGB(255, 58, 143, 131),
                    ),
                  ],
                ),

              if (currentQuestionIndex != 0)
                ...List.generate(
                  questions[currentQuestionIndex]['options'].length,
                      (index) => ElevatedButton(
                    onPressed: () => checkAnswer(index),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      textStyle: const TextStyle(fontSize: 18.0),
                    ),
                    child: Text(questions[currentQuestionIndex]['options'][index]),
                  ),
                ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: isNextButtonEnabled() ? nextQuestion : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isNextButtonEnabled() ? const Color.fromARGB(255, 58, 143, 131) : Colors.white,
                ),
                child: const Text('Next'),
              ),

            ],
          ),
        ),
      ),
    );
  }

  void checkAnswer(int selectedOptionIndex) {
    Map<String, dynamic> selectedOption;

    if (questions[currentQuestionIndex]['isSlider'] == true) {
      // For questions with a slider
      selectedOption = {
        'index': null, // No specific option index for the slider
        'value': sliderValue,
      };
    } else {
      // For questions with options
      selectedOption = {
        'index': selectedOptionIndex,
        'value': questions[currentQuestionIndex]['options'][selectedOptionIndex],
      };
    }

    userSelectedOptions.add(selectedOption);
    setState(() {}); // Trigger a rebuild to update the state of the "Next" button
  }


  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
      userSelectedOptions = []; // Clear selected options for the next question
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
      if (kDebugMode) {
        print('User Selected Options: $userSelectedOptions');
      }

      // Reset the quiz for the next attempt
      setState(() {
        currentQuestionIndex = 0;
        userSelectedOptions = [];
      });
    }
  }
}
