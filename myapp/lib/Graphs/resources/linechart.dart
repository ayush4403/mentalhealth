

import 'package:MindFulMe/reusable_widgets/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartSample2 extends StatefulWidget {
  const LineChartSample2({super.key});

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  int touchedIndex = -1;
  int correctAnswers = 0;
  int incorrectAnswers = 0;
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
          .collection('SherlockHolmes')
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
        .collection('sherlockdata')
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
    }
  }
Future<void> getPieData() async {
  try {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    // Initialize a list to hold all the data for each day in all weeks
    List<double> allWeekData = [];

    // Loop through each week (assuming 4 weeks)
    for (int weekIndex = 1; weekIndex <= indexweek; weekIndex++) {
      int startDayIndex = (weekIndex - 1) * 7 + 1; // Calculate the starting day index for each week

      // Loop through each day in the week (assuming each week has 7 days)
      for (int dayIndex = startDayIndex; dayIndex < startDayIndex + 7; dayIndex++) {
        // Construct the document path for the current day
        final userDoc = FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .collection('SherlockHolmes')
            .doc('week$weekIndex')
            .collection('day$dayIndex')
            .doc('data');

        // Get the data for the current day
        final daySnapshot = await userDoc.get();
        if (daySnapshot.exists) {
          final dayData = daySnapshot.data();
          int totalQuestions =
              (dayData?['correctAnswers'] ?? 0) + (dayData?['incorrectAnswers'] ?? 0);
          double percentage = totalQuestions == 0
              ? 0
              : (dayData?['correctAnswers'] ?? 0) / totalQuestions * 100;

          // Add the percentage data to the list for this day
          allWeekData.add(percentage);
        }
      }
    }

    // Update the state's percentageData list with all the data for all weeks
    setState(() {
      percentageData = allWeekData;
      dataFetched = true;
    });

    // Assuming the percentage data list is available in the state
    mainData(percentageData);
  } catch (e) {
    // ignore: avoid_print
    print('Error fetching data: $e');
  }
}



  List<Color> gradientColors = [
    AppColors.contentColorCyan,
    AppColors.contentColorBlue,
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: MediaQuery.of(context).size.width *
              2.5 /
              MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 18,
              left: 12,
              top: 24,
              bottom: 12,
            ),
             child: dataFetched
                ? LineChart(
                    mainData(percentageData),
                  )
                : const SizedBox(width: 20,height: 20, child: CircularProgressIndicator()),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
  Widget text;
  int intValue = value.toInt();
  if (intValue >= 1 && intValue < 30) {
    text = Text('$intValue', style: style);
  } else {
    text = const Text('', style: style);
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: text,
  );
}


  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 10:
        text = '${value.toInt()}';
        break;
      case 20:
        text = '${value.toInt()}';
        break;
      case 100:
        text = '100';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData(List<double> percentageData) {
    return LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: false,
        horizontalInterval: 1,
        verticalInterval: 10, // Adjust vertical interval as per your data range
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: AppColors.mainGridLineColor,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: AppColors.mainGridLineColor,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 10, // Adjust interval as per your data range
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: percentageData.length.toDouble() -
          1, // Set max X based on data length
      minY: 0,
      maxY: 100, // Assuming percentage range is from 0 to 100
      lineBarsData: [
        LineChartBarData(
          spots: List.generate(percentageData.length, (index) {
            return FlSpot(index.toDouble(), percentageData[index]);
          }),
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: const LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
            interval: 1,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
