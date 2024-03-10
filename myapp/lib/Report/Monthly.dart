// ignore_for_file: file_names
import 'dart:async';
import 'package:MindFulMe/Graphs/resources/app_resources.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MonthlyMeditation extends StatefulWidget {
  MonthlyMeditation({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MonthlyMeditationState();
}

class MonthlyMeditationState extends State<MonthlyMeditation> {
  final double width = 7;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;
  List<int> defaulttime = [5, 7, 9, 13, 15, 20, 5];

  int touchedGroupIndex = -1;

  int indexweek = 1;
  int indexday = 1;
  late List<int> _sessionData = [];
// Add a parameter for weekIndex
  Future<void> _getGraphData(int currentWeek) async {
    final User? user = FirebaseAuth.instance.currentUser;

    // Initialize session data with zeros for each day
    _sessionData = List<int>.filled(30, 0);

    // Loop through weeks from 1 to currentWeek
    for (int weekIndex = 1; weekIndex <= currentWeek; weekIndex++) {
      final weekDoc = FirebaseFirestore.instance
          .collection('Users')
          .doc(user!.uid)
          .collection('MeditationData')
          .doc('week$weekIndex');

      final weekSnapshot = await weekDoc.get();
      if (weekSnapshot.exists) {
        final weekData = weekSnapshot.data();

        for (int i = 1; i <= 30; i++) {
          final dynamic dayData = weekData?['day$i'];
          if (dayData is int) {
            _sessionData[i - 1] += dayData; // Aggregate data for each day
          }
        }
      }
    }

    // Convert seconds to minutes
    _sessionData =
        _sessionData.map((seconds) => (seconds / 60).toInt()).toList();

    setState(() {
      final items = List.generate(_sessionData.length, (index) {
        return makeGroupData(index, _sessionData[index].toDouble());
      });
      rawBarGroups = items;
      showingBarGroups = rawBarGroups;
    });
  }

  @override
  void initState() {
    super.initState();
    _getGraphData(indexweek); // Fetch data for initial week
    Timer.periodic(Duration(days: 1), (timer) {
      // Get the current time
      DateTime now = DateTime.now();
      // Check if it's midnight
      if (now.hour == 0 && now.minute == 0 && now.second == 0) {
        // Increment day
        setState(() {
          indexday++;
          if (indexday > 7) {
            indexday = 1;
            indexweek++;
            _getGraphData(indexweek); // Fetch data for new week
          } 
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(
              height: 38,
            ),
            Expanded(
              child: BarChart(
                BarChartData(
                  maxY: 20,
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      tooltipBgColor: Colors.grey,
                      getTooltipItem: (a, b, c, d) => null,
                    ),
                    touchCallback: (FlTouchEvent event, response) {
                      if (response == null || response.spot == null) {
                        setState(() {
                          touchedGroupIndex = -1;
                          showingBarGroups = List.of(rawBarGroups);
                        });
                        return;
                      }

                      touchedGroupIndex = response.spot!.touchedBarGroupIndex;

                      setState(() {
                        if (!event.isInterestedForInteractions) {
                          touchedGroupIndex = -1;
                          showingBarGroups = List.of(rawBarGroups);
                          return;
                        }
                        showingBarGroups = List.of(rawBarGroups);
                      });
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
                        getTitlesWidget: bottomTitles,
                        reservedSize: 42,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        interval: 1,
                        getTitlesWidget: leftTitles,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  barGroups: showingBarGroups,
                  gridData: const FlGridData(show: false),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    if (value == 5) {
      text = '5';
    } else if (value == 10) {
      text = '10';
    } else if (value == 15) {
      text = '15';
    } else if (value == 20) {
      text = '30';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    String data = '';
    final List<String> titles =
        List.generate(30, (index) => (index + 1).toString());
    if (titles[value.toInt()] == '5') {
      data = '5';
    } else if (titles[value.toInt()] == '10') {
      data = '10';
    } else if (titles[value.toInt()] == '15') {
      data = '15';
    } else if (titles[value.toInt()] == '20') {
      data = '20';
    } else if (titles[value.toInt()] == '25') {
      data = '25';
    } else if (titles[value.toInt()] == '30') {
      data = '30';
    }
    final Widget text = Text(
      data,
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }

  BarChartGroupData makeGroupData(int x, double y) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: AppColors.contentColorRed,
          width: width,
        ),
      ],
    );
  }
}
