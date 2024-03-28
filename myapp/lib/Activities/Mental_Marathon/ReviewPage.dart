// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:MindFulMe/Activities/cardview.dart';

class ReviewPage extends StatefulWidget {
  final List<String> selectedAnswers;
  final List<String> correctAnswers;
  final int totalScore;

  const ReviewPage({
    super.key,
    required this.selectedAnswers,
    required this.correctAnswers,
    required this.totalScore,
  });
  @override
  // ignore: library_private_types_in_public_api
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final User? user = FirebaseAuth.instance.currentUser;
   int indexday = 1;
  int indexweek = 1;
  List<double> percentageData = [];
  bool dataFetched = false;
  @override
  void initState() {
    _fetchdata();

    super.initState();
    // ignore: avoid_print
    print("list: $percentageData");
  }

  Future<void> _fetchdata() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final userDoc = FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .collection('mentalmarathondata')
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
        _updateCurrentDayAndWeekIndex(indexday, indexweek, currentdaylatest);
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
        _updateCurrentDayAndWeekIndex(indexday, indexweek, currentdaylatest);
      }
      // ignore: avoid_print
      print(
          'Current day and week index updated to: Day $indexday, Week $indexweek');
    } else {
      setState(() {
        indexday = 1;
        indexweek = 1;
      });
      _updateCurrentDayAndWeekIndex(indexday, indexweek, DateTime.now().day);
      // ignore: avoid_print
      print('Document does not exist');
    }
    await getPieData();
    setState(() {
      dataFetched = true;
    });
  }

  Future<void> _addMissingDay(
      String userId, int dayIndex, int weekIndex) async {
    // ignore: unused_local_variable
    final User? user = FirebaseAuth.instance.currentUser;
    try {
      final userDoc = FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('mentalmarathon')
          .doc('week$weekIndex')
          .collection('day$dayIndex')
          .doc('data');
      await userDoc.set({
        'correctAnswers': 0,
        'incorrectAnswers': 0,
      }, SetOptions(merge: true));
      // ignore: avoid_print
      print('Added missing day $dayIndex for Week $weekIndex with value 0');
    } catch (e) {
      // ignore: avoid_print
      print('Error adding missing day: $e');
    }
  }

  Future<void> _updateCurrentDayAndWeekIndex(
      int indexday1, int indexweek1, int currentday) async {
    final User? user = FirebaseAuth.instance.currentUser;
    // ignore: unused_local_variable
    String weekPath = 'week$indexweek';

    final userDoc = FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .collection('mentalmarathondata')
        .doc('currentweekandday');
    DocumentSnapshot<Map<String, dynamic>> docSnapshot = await userDoc.get();
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
      // ignore: avoid_print
      print(
          'Current day and week index updated to: Day $indexday, Week $indexweek');
          _createNewWeekDocument();
    } else {
      await userDoc.set({
        'currentday': indexday1,
        'currentweek': indexweek1,
        'dayupdated': currentday,
        'lastupdatedday': Timestamp.now().toDate().day,
      });
      setState(() {
        indexday = indexday1;
        indexweek = indexweek1;
      });
      // ignore: avoid_print
      print('New document created with day $indexday, Week $indexweek');
      _createNewWeekDocument();
    }
  }
   Future<void> _createNewWeekDocument() async {
    try {
      

     
      final User? user = FirebaseAuth.instance.currentUser;
    final weekDoc = FirebaseFirestore.instance
        .collection('Users')
          .doc(user!.uid)
          .collection('mentalmarathon')
          .doc('week$indexweek')
          .collection('day$indexday')
          .doc('data');

      // Check if the document exists before updating
      DocumentSnapshot<Map<String, dynamic>> docSnapshot = await weekDoc.get();
      if (docSnapshot.exists) {
         weekDoc.set({
                          'correctAnswers': widget.totalScore,
                          'incorrectAnswers': 5 - widget.totalScore
                        },SetOptions(merge: true));
        // ignore: avoid_print
        print('Week document updated with timer data for Day $indexday');
        
      } else {
              weekDoc.set({
                          'correctAnswers': widget.totalScore,
                          'incorrectAnswers': 5 - widget.totalScore
                        },SetOptions(merge: true));
        // ignore: avoid_print
        print('New week document created with timer data for Day $indexday');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error creating/updating week document: $e');
    }
  }
Future<void> getPieData() async {
  try {
    final User? user = FirebaseAuth.instance.currentUser;

    // Initialize a list to hold all the data for each day in a week
    List<double> allWeekData = [];

    // Loop through each day in the week (assuming you want data for day1 and day2)
    for (int dayIndex = 1; dayIndex <= 30; dayIndex++) {
      // Construct the document path for the current day
      final userDoc = FirebaseFirestore.instance
          .collection('Users')
          .doc(user!.uid)
          .collection('mentalmarathon')
          .doc('week$indexweek')
          .collection('day$dayIndex')
          .doc('data');

      // Get the data for the current day
      final daySnapshot = await userDoc.get();
      if (daySnapshot.exists) {
        final dayData = daySnapshot.data();
        int totalQuestions = (dayData?['correctAnswers'] ?? 0) +
            (dayData?['incorrectAnswers'] ?? 0);
        double percentage = totalQuestions == 0
            ? 0
            : (dayData?['correctAnswers'] ?? 0) / totalQuestions * 100;

        // Add the percentage data to the list for this day
        allWeekData.add(percentage);
      }
    }

    // Update the state's percentageData list with all the week's data
    setState(() {
      percentageData = allWeekData;
    });

    // Assuming the percentage data list is available in the state
    
  } catch (e) {
    // ignore: avoid_print
    print('Error fetching data: $e');
  }
}


  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final weekDoc = FirebaseFirestore.instance
        .collection('Users')
          .doc(user!.uid)
          .collection('mentalmarathon')
          .doc('week$indexweek')
          .collection('day$indexday')
          .doc('data');

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        // Navigate to a particular screen when the back button is pressed
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const CardView()),
        );
        // Return false to prevent the default back button behavior
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 0, 111, 186),
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.95,
            height: MediaQuery.of(context).size.height * 0.85,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.65),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Review your quiz:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 20),
                  for (int i = 0; i < widget.selectedAnswers.length; i++)
                    ReviewItem(
                      questionNumber: i + 1,
                      selectedAnswer: widget.selectedAnswers[i],
                      correctAnswer: widget.correctAnswers[i],
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      'Total Score: ${widget.totalScore}/5',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                      _createNewWeekDocument();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CardView(),
                          ),
                        );
                      },
                      child: Column(

                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CardView(),
                                ),
                              );
                            },
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(
                                const Size(
                                  200,
                                  50,
                                ),
                              ),
                            ),
                            child: const Text(
                              'Activity Done',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ReviewItem extends StatelessWidget {
  final int questionNumber;
  final String selectedAnswer;
  final String correctAnswer;

  const ReviewItem({
    super.key,
    required this.questionNumber,
    required this.selectedAnswer,
    required this.correctAnswer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Question $questionNumber:',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          Text(
            'Your Answer: $selectedAnswer',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          Text(
            'Correct Answer: $correctAnswer',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const Divider(), // Add a divider for separation
        ],
      ),
    );
  }
}

class YourParticularScreen extends StatelessWidget {
  const YourParticularScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Replace this with your particular screen UI
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Particular Screen'),
      ),
      body: const Center(
        child: Text('Your particular screen content goes here'),
      ),
    );
  }
}
