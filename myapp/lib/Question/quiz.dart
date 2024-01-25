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
      'image': 'assets/GIF/gif1.json',
      'isSlider': true,
    },
    {
      'question': 'Are you often very critical of your self?',
      'image': 'assets/GIF/gif5.json',
      'options': ['Extremely', 'Frequently', 'Rarely', 'Not at all'],
    },
    {
      'question': 'How satisfied are you with your current social interaction and connections?',
      'image': 'assets/GIF/gif2.json',
      'options': ['Very Well', 'Moderately', 'Struggling','Not at all'],
    },
    {
      'question': 'Are you currently experiencing stress related to work or academic responsibilities?',
      'image': 'assets/GIF/gif3.json',
      'options': ['Occasionally', 'Moderately', 'Frequently', 'Not at all'],
    },
    {
      'question': 'How much are you currently coping up with stress or difficult emotions?',
      'image': 'assets/GIF/gif4.json',
      'options': ['Very Well', 'Moderately', 'Struggling','Not at all'],
    },
  ];

  int currentQuestionIndex = 0;
  List<Map<String, dynamic>> userSelectedOptions = [];

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
              // Top Bar with Back and Skip buttons
              Padding(
                padding: const EdgeInsets.fromLTRB(1, 1, 1, 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Back button
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => navigateBack(),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width*0.6), // Add space between buttons
                    // Skip button
                    IconButton(
                      icon: const Icon(Icons.skip_next, color: Colors.white),
                      onPressed: () => nextQuestion(),
                    ),
                  ],
                ),
              ),
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
                    color: Colors.white),
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
                      activeColor: Colors.amberAccent,
                    ),
                  ],
                ),

              if (currentQuestionIndex != 0)
              ...List.generate(
                questions[currentQuestionIndex]['options'].length,
                    (index) => ElevatedButton(
                  onPressed: () => checkAnswer(index),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black, backgroundColor: Colors.white,
                    textStyle: const TextStyle(fontSize: 18.0),
                  ),
                  child:
                  Text(questions[currentQuestionIndex]['options'][index]),
                ),
              ),
              const SizedBox(height: 20.0),
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
    nextQuestion();
  }

  void updateSliderValue(double newValue) {
    setState(() {
      sliderValue = newValue;
    });
  }

  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
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

  void navigateBack() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
      });
    }
  }
}
