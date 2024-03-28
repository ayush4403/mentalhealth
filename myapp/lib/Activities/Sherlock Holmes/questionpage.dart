//import 'package:MindFulMe/globalindex.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:MindFulMe/Activities/Sherlock%20Holmes/quizsherdata.dart'
    // ignore: library_prefixes
    as QuizData;
import 'package:MindFulMe/Activities/cardview.dart';

class QuestionPage extends StatefulWidget {
  final List<QuizData.Question> questions;

  const QuestionPage({super.key, required this.questions});

  @override
  // ignore: library_private_types_in_public_api
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  int selectedOption = -1;
  int currentQuestionIndex = 0;
  bool showCorrectAnswer = false;
  List<int> selectedAnswers = [];
  final User? user = FirebaseAuth.instance.currentUser;
 


  @override
  void initState() {
    super.initState();
    selectedAnswers = List.filled(widget.questions.length, -1);
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
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 16,
              ),
              buildOptionTile(widget.questions[currentQuestionIndex]),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    showCorrectAnswer = true;
                  });

                  Future.delayed(const Duration(seconds: 3), () {
                    if (currentQuestionIndex < widget.questions.length - 1) {
                      setState(() {
                        currentQuestionIndex++;
                        selectedOption = -1;
                        showCorrectAnswer = false;
                      });
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultPage(
                            totalQuestions: widget.questions.length,
                            selectedAnswers: selectedAnswers,
                            questions: widget.questions, indexweek: 1, indexday: 1,
                          ),
                        ),
                      );
                    }
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text('Submit Answer',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ),
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
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
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
          margin: const EdgeInsets.symmetric(vertical: 6.0),
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
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
                    : Colors.white),
          ),
          child: RadioListTile<int>(
            title: Text(
              question.options[optionIndex],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            value: optionIndex,
            groupValue: selectedOption,
            onChanged: isSelected
                ? null
                : (value) {
                    setState(
                      () {
                        selectedOption = value!;
                        selectedAnswers[currentQuestionIndex] = selectedOption;
                        // ignore: avoid_print
                        print(selectedAnswers);
                      },
                    );
                  },
            activeColor: Colors.white,
          ),
        ),
      ),
    );
  }
  
}

class ResultPage extends StatefulWidget {
  final int totalQuestions;
  final List<int> selectedAnswers;
  final List<QuizData.Question> questions;
  
 final  int indexweek;
  
 final int indexday;

  const ResultPage({
    Key? key,
    required this.totalQuestions,
    required this.selectedAnswers,
    required this.questions,
    required this.indexweek,
    required this.indexday,
  }) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  int indexweek = 1;
  int indexday = 1;

  @override
  void initState() {
    super.initState();
    _fetchdata();
    //_createNewWeekDocument();
  }

  Future<void> _fetchdata() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final userDoc = FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .collection('sherlockdata')
        .doc('currentweekandday');
    DocumentSnapshot<Map<String, dynamic>> docSnapshot = await userDoc.get();
    if (docSnapshot.exists) {
      int currentDay = docSnapshot.get('currentday');
      int currentWeek = docSnapshot.get('currentweek');
      int currentdaylatest = DateTime.now().day;
      int lastUpdatedDay = docSnapshot.get('lastupdatedday');
      if (currentdaylatest - lastUpdatedDay == 0) {
        setState(() {
          indexday = currentDay;
          indexweek = currentWeek;
        });
        _updateCurrentDayAndWeekIndex(
            indexday, indexweek, currentdaylatest);
      } else {
        // Calculate the missing days and add them with a value of 0
        int missingDays = currentdaylatest - lastUpdatedDay;
        for (int i = 1; i < missingDays; i++) {
          int missingDayIndex = currentDay + i;
          await _addMissingDay(user.uid, missingDayIndex, currentWeek);
        }
        setState(() {
          indexday = currentDay + missingDays;
          if (indexday % 7 == 1) {
            indexweek = currentWeek + 1;
          } else {
            indexweek = currentWeek;
          }
        });
        _updateCurrentDayAndWeekIndex(
            indexday, indexweek, currentdaylatest);
      }
      print(
          'Current day and week index updated to: Day $indexday, Week $indexweek');
    } else {
      setState(() {
        indexday = 1;
        indexweek = 1;
      });
      _updateCurrentDayAndWeekIndex(indexday, indexweek,
          DateTime.now().day);
      print('Document does not exist');
    }
  }

  Future<void> _addMissingDay(
      String userId, int dayIndex, int weekIndex) async {
     final User? user = FirebaseAuth.instance.currentUser;
    try {
        final userDoc = FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('SherlockHolmes')
          .doc('week$weekIndex}')
          .collection('day$dayIndex')
          .doc('data');
      await  userDoc.set({
        'correctAnswers': 0,
        'incorrectAnswers': 0,
      }, SetOptions(merge: true));
      print('Added missing day $dayIndex for Week $weekIndex with value 0');
    } catch (e) {
      print('Error adding missing day: $e');
    }
  }

  Future<void> _updateCurrentDayAndWeekIndex(
      int indexday1, int indexweek1, int currentday) async {
    final User? user = FirebaseAuth.instance.currentUser;
    String weekPath = 'week$indexweek';

    final userDoc = FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .collection('sherlockdata')
        .doc('currentweekandday');
    DocumentSnapshot<Map<String, dynamic>> docSnapshot =
        await userDoc.get();
    if (docSnapshot.exists) {
      await userDoc.update({
        'currentday': indexday1,
        'currentweek': indexweek1,
        'dayupdated': currentday,
        'lastupdatedday': Timestamp.now().toDate().day
      });
      setState(() {
        indexday = indexday1;
        indexweek = indexweek1;
      });
      print(
          'Current day and week index updated to: Day $indexday, Week $indexweek');
          _createNewWeekDocument();
    } else {
      await userDoc.set({
        'currentday': indexday1,
        'currentweek': indexweek1,
        'dayupdated': currentday,
        'lastupdatedday':Timestamp.now().toDate().day,
      });
      setState(() {
        indexday = indexday1;
        indexweek = indexweek1;
      });
      print('New document created with day $indexday, Week $indexweek');
      _createNewWeekDocument();
    }
  }

  Future<void> _createNewWeekDocument() async {
    try {
      int correctAnswers = 0;
      int incorrectAnswers = 0;

      // Calculate correct and incorrect answers
      for (int i = 0; i < widget.totalQuestions; i++) {
        if (widget.selectedAnswers[i] == widget.questions[i].correctAnswerIndex) {
          correctAnswers++;
        } else {
          incorrectAnswers++;
        }
      }

      final User? user = FirebaseAuth.instance.currentUser;
      final userDoc = FirebaseFirestore.instance
          .collection('Users')
          .doc(user!.uid)
          .collection('SherlockHolmes')
          .doc('week$indexweek')
          .collection('day$indexday')
          .doc('data');
     

      // Check if the document exists before updating
      DocumentSnapshot<Map<String, dynamic>> docSnapshot = await userDoc.get();
      if (docSnapshot.exists) {
        await  userDoc.set({
        'correctAnswers': correctAnswers,
        'incorrectAnswers': incorrectAnswers,
      },SetOptions(merge: true));
        print('Week document updated with timer data for Day $indexday');
      } else {
        await  userDoc.set({
        'correctAnswers': correctAnswers,
        'incorrectAnswers': incorrectAnswers,
      }, SetOptions(merge: true));
        print('New week document created with timer data for Day $indexday');
      }
    } catch (e) {
      print('Error creating/updating week document: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const CardView(); // Return an empty container since no UI is displayed
  }
}