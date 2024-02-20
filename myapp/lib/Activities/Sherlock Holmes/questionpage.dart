import 'package:flutter/material.dart';
import 'package:myapp/Activities/Sherlock%20Holmes/quizsherdata.dart'
    as QuizData;
import 'package:myapp/Activities/cardview.dart';

// Added 'as QuizData'

class QuestionPage extends StatefulWidget {
  final List<QuizData.Question> questions;

  QuestionPage({required this.questions});

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  int selectedOption = -1;
  int currentQuestionIndex = 0;
  bool showCorrectAnswer = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 111, 186),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop(CardView());
          },
        ),
        title: const Text(
          'Questions',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 111, 186),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.95,
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.65),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Choose the correct option:',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              buildOptionTile(widget.questions[currentQuestionIndex]),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    showCorrectAnswer = true;
                  });
                  Future.delayed(Duration(seconds: 3), () {
                    if (currentQuestionIndex < widget.questions.length - 1) {
                      setState(() {
                        currentQuestionIndex++;
                        selectedOption = -1;
                        showCorrectAnswer = false;
                      });
                    } else {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => CardView()));
                    }
                  });
                },
                child: Text('Submit Answer'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOptionTile(QuizData.Question question) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Text(
          question.question,
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16),
        for (int i = 0; i < question.options.length; i++)
          buildOption(question, i),
      ],
    );
  }

  Widget buildOption(QuizData.Question question, int optionIndex) {
    bool isCorrect = question.correctAnswerIndex == optionIndex;
    bool isSelected = selectedOption == optionIndex;
    bool isUserSelectedCorrect = showCorrectAnswer && isCorrect;
    bool isUserSelectedIncorrect =
        showCorrectAnswer && isSelected && !isCorrect;

    return IgnorePointer(
      ignoring: isSelected,
      child: Opacity(
        opacity: isSelected ? 0.5 : 1.0,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          margin: EdgeInsets.symmetric(vertical: 8.0),
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: isCorrect
                  ? (isUserSelectedCorrect ? Colors.green : Colors.black)
                  : Colors.black,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
            color: isUserSelectedIncorrect
                ? Colors.red.withOpacity(0.8)
                : (isUserSelectedCorrect
                    ? Colors.green.withOpacity(0.8)
                    : null),
          ),
          child: Theme(
            data: ThemeData(
              unselectedWidgetColor: Colors.transparent,
            ),
            child: RadioListTile<int>(
              title: Text(
                question.options[optionIndex],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              value: optionIndex,
              groupValue: selectedOption,
              onChanged: isSelected
                  ? null
                  : (value) {
                      setState(() {
                        selectedOption = value!;
                      });
                    },
              activeColor: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}
