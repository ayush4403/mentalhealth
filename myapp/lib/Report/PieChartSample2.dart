// ignore_for_file: file_names
import 'package:MindFulMe/reusable_widgets/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartSample2 extends StatefulWidget {
  const PieChartSample2({super.key});

  @override
  State<StatefulWidget> createState() => PieChartSample2State();
}

class PieChartSample2State extends State<PieChartSample2> {
  int touchedIndex = -1;
  int correctAnswers = 0;
  int incorrectAnswers = 0;
  int indexday=1;
  int indexweek=1;

  @override
  void initState() {
    _fetchdata();
    //getPieData();
    super.initState();
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
            getPieData();
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
            getPieData();
      }
      // ignore: avoid_print
      print(
          'Current day and week index updated to: Day $indexday, Week $indexweek');
    } else {
      setState(() {
        indexday = 1;
        indexweek = 1;
      });
      _updateCurrentDayAndWeekIndex(indexday, indexweek,
          DateTime.now().day);
      // ignore: avoid_print
      print('Document does not exist');
    }
  }

  Future<void> _addMissingDay(
      String userId, int dayIndex, int weekIndex) async {
     // ignore: unused_local_variable
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
      // ignore: avoid_print
      print(
          'Current day and week index updated to: Day $indexday, Week $indexweek');
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
      // ignore: avoid_print
      print('New document created with day $indexday, Week $indexweek');
    }
  }
  Future<void> getPieData() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
        final userDoc = FirebaseFirestore.instance
          .collection('Users')
          .doc(user!.uid)
          .collection('SherlockHolmes')
          .doc('week$indexweek')
          .collection('day$indexday')
          .doc('data');
      final weekSnapshot = await userDoc.get();
      if (weekSnapshot.exists) {
        final weekData = weekSnapshot.data();
        setState(() {
          correctAnswers = weekData?['correctAnswers'] ?? 0;
          incorrectAnswers = weekData?['incorrectAnswers'] ?? 0;
        });
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: <Widget>[
          const SizedBox(
            height: 18,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: showingSections(),
                ),
              ),
            ),
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Indicator(
                color: Colors.green,
                text: 'Right Answer',
              ),
              SizedBox(
                height: 4,
              ),
              Indicator(
                color: Colors.red,
                text: 'Wrong Answer',
              ),
              SizedBox(
                height: 18,
              ),
            ],
          ),
          const SizedBox(
            width: 28,
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    List<PieChartSectionData> sections = [];

    // Calculate total answers
    int totalAnswers = correctAnswers + incorrectAnswers;

    // Add correct answers section
    // Add correct answers section
    sections.add(
      PieChartSectionData(
        color: Colors.green,
        value:
            correctAnswers.toDouble(), // Use correctAnswers from fetched data
        title: '${((correctAnswers / totalAnswers) * 100).toStringAsFixed(2)}%',
        radius: touchedIndex == 0 ? 60.0 : 50.0,
        titleStyle: TextStyle(
          fontSize: touchedIndex == 0 ? 25.0 : 16.0,
          fontWeight: FontWeight.bold,
          color: AppColors.mainTextColor1,
          shadows: const [Shadow(color: Colors.black, blurRadius: 2)],
        ),
      ),
    );

// Add incorrect answers section
    sections.add(
      PieChartSectionData(
        color: Colors.red,
        value: incorrectAnswers
            .toDouble(), // Use incorrectAnswers from fetched data
        title:
            '${((incorrectAnswers / totalAnswers) * 100).toStringAsFixed(2)}%',
        radius: touchedIndex == 1 ? 60.0 : 50.0,
        titleStyle: TextStyle(
          fontSize: touchedIndex == 1 ? 25.0 : 16.0,
          fontWeight: FontWeight.bold,
          color: AppColors.mainTextColor1,
          shadows: const [Shadow(color: Colors.black, blurRadius: 2)],
        ),
      ),
    );

    return sections;
  }
}

class Indicator extends StatelessWidget {
  final Color color;
  final String text;

  const Indicator({super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          color: color,
        ),
        const SizedBox(width: 8),
        Text(text),
      ],
    );
  }
}
