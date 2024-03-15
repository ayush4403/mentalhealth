// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:MindFulMe/Activities/Sherlock%20Holmes/questionpage.dart'
    // ignore: library_prefixes
    as QuestionPage;
import 'package:MindFulMe/Activities/Sherlock%20Holmes/quizsherdata.dart'
    // ignore: library_prefixes
    as QuizData;
import 'package:MindFulMe/Activities/cardview.dart';

class PicturePage extends StatefulWidget {
  const PicturePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PicturePageState createState() => _PicturePageState();
}

class _PicturePageState extends State<PicturePage> {
  int countdown = 30;
  late QuizData.QuizData selectedQuizData;

  @override
  void initState() {
    super.initState();

    // Initialize selectedQuizData based on the current day
    selectedQuizData = selectQuizDataForDay();

    // Add a delay to navigate after 30 seconds
    Future.delayed(const Duration(seconds: 30), () {
      List<QuizData.Question> selectedQuestions = selectQuestionsForDay();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              QuestionPage.QuestionPage(questions: selectedQuestions),
        ),
      );
    });
  }

  // Define the selectQuizDataForDay method here
  QuizData.QuizData selectQuizDataForDay() {
    int currentDay = DateTime.now().day;
    int index = currentDay % QuizData.quizDataList.length;
    return QuizData.quizDataList[index];
  }

  // Define the selectQuestionsForDay method here
  List<QuizData.Question> selectQuestionsForDay() {
    // Shuffle the questions for the selected image
    selectedQuizData.questions.shuffle();

    // Return the first 5 questions for the day
    return selectedQuizData.questions.take(5).toList();
  }

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
          'Sherlock Holmes',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 111, 186),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              CircularCountDownTimer(
                duration: countdown,
                initialDuration: 0,
                controller: CountDownController(),
                width: 70.0,
                height: 70.0,
                ringColor: Colors.grey[300]!,
                ringGradient: null,
                fillColor: Colors.greenAccent,
                fillGradient: null,
                backgroundColor: Colors.pink,
                backgroundGradient: null,
                strokeWidth: 10.0,
                strokeCap: StrokeCap.round,
                textStyle: const TextStyle(
                  fontSize: 30.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textFormat: CountdownTextFormat.S,
                isReverse: true,
                isReverseAnimation: false,
                isTimerTextShown: true,
                autoStart: true,
                onStart: () {},
                onComplete: () {
                  List<QuizData.Question> selectedQuestions =
                      selectedQuizData.questions;
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          QuestionPage.QuestionPage(questions: selectedQuestions),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2.0,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    selectedQuizData.imagePath,
                    fit: BoxFit.cover,
                  ),
                  // ignore: avoid_print
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Analyze this picture for 30 seconds and then we will give you 5 fun'
                  ' questions related to the picture.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
