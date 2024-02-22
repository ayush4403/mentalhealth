import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:MindFulMe/Startup/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  double sliderValue = 5.0;
  bool isButtonPressed = false;
  List<Map<String, dynamic>> questions = [
    {
      'question':
          'On a scale of 1 to 10, how would you rate your overall well-being today?',
      'image': 'assets/GIF/Questions/Qgif1.json',
      'isSlider': true,
    },
    {
      'question': 'Are you often very critical of yourself?',
      'image': 'assets/GIF/Questions/Qgif2.json',
      'options': ['Extremely', 'Frequently', 'Rarely', 'Not at all'],
    },
    {
      'question':
          'How satisfied are you with your current social interaction and connections?',
      'image': 'assets/GIF/Questions/Qgif3.json',
      'options': ['Very Well', 'Moderately', 'Struggling', 'Not at all'],
    },
    {
      'question':
          'Are you currently experiencing stress related to work or academic responsibilities?',
      'image': 'assets/GIF/Questions/Qgif4.json',
      'options': ['Occasionally', 'Moderately', 'Frequently', 'Not at all'],
    },
    {
      'question':
          'How much are you currently coping up with stress or difficult emotions?',
      'image': 'assets/GIF/Questions/Qgif5.json',
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
                Color.fromARGB(255, 0, 111, 186),
                Color.fromARGB(255, 0, 111, 186),
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
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: MediaQuery.of(context).size.width * 0.3,
                  fit: BoxFit.fill,
                ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                questions[currentQuestionIndex]['question'],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
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
                      activeColor: Colors.cyan,
                    ),
                  ],
                ),

              if (currentQuestionIndex != 0)
                ...List.generate(
                  questions[currentQuestionIndex]['options'].length,
                  (index) => ElevatedButton(
                    onPressed: () => checkAnswer(index),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          (selectedOptionIndexes[currentQuestionIndex] == index)
                              ? const Color.fromARGB(255, 7, 110, 255)
                              : const Color.fromARGB(255, 0, 86, 97),
                      textStyle: const TextStyle(fontSize: 18.0),
                    ),
                    child: Text(
                      questions[currentQuestionIndex]['options'][index],
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              ElevatedButton(
                onPressed: isNextButtonEnabled() ? nextQuestion : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isNextButtonEnabled() ? Colors.cyan : Colors.white,
                ),
                child: const Text(
                  'Next',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<int> selectedOptionIndexes = List.filled(5, -1);
  void checkAnswer(int selectedOptionIndex) {
    selectedOptionIndexes[currentQuestionIndex] = selectedOptionIndex;

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
        'value': questions[currentQuestionIndex]['options']
            [selectedOptionIndex],
      };
    }

    userSelectedOptions.add(selectedOption);
    setState(
        () {}); // Trigger a rebuild to update the state of the "Next" button
  }

  Future<void> nextQuestion() async {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });

      // Add selected option only once per question
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
          'index': selectedOptionIndexes[currentQuestionIndex],
          'value': questions[currentQuestionIndex]['options']
              [selectedOptionIndexes[currentQuestionIndex]],
        };
      }

      userSelectedOptions.add(selectedOption);

      setState(() {
        // Trigger a rebuild to update the state of the "Next" button
      });
    } else {
      // Set flag to true in Firestore
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .update({'flag': true});
        await FirebaseFirestore.instance.collection('Users').doc(user.uid).set(
            {'Well being': sliderValue, 'answers': userSelectedOptions},
            SetOptions(merge: true));
      }
      await setHasCompletedQuiz();

      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );

      // Reset the quiz for the next attempt
      setState(() {
        currentQuestionIndex = 0;
      });
    }
  }

  Future<void> setHasCompletedQuiz() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasCompletedQuiz', true);
  }
}
