import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:myapp/Activities/Sherlock%20Holmes/questionpage.dart'
    as QuestionPage;

import 'package:myapp/Activities/Sherlock%20Holmes/quizsherdata.dart'
    as QuizData;

import 'quizsherdata.dart';

class PicturePage extends StatefulWidget {
  @override
  _PicturePageState createState() => _PicturePageState();
}

class _PicturePageState extends State<PicturePage> {
  int countdown = 30;
  late QuizData.QuizData selectedQuizData;

  @override
  void initState() {
    super.initState();

    // Initialize selectedQuizData with a default QuizData
    selectedQuizData = QuizData.quizDataList.first;

    // Add a delay to navigate after 30 seconds
    Future.delayed(Duration(seconds: 30), () {
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
        title: Text('Sherlock Holmes Module'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularCountDownTimer(
              duration: countdown,
              initialDuration: 0,
              controller: CountDownController(),
              width: 100.0,
              height: 100.0,
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
            SizedBox(height: 50),
            Container(
              width: 350.0,
              height: 350.0,
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
            SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Analyze this picture for 30 seconds and then we will give you 3 fun'
                ' questions related to the picture.',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
