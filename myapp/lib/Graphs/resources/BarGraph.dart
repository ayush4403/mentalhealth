// ignore_for_file: file_names
import 'dart:async';
import 'package:MindFulMe/Graphs/resources/app_resources.dart';
import 'package:MindFulMe/Graphs/resources/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartSample2 extends StatefulWidget {
  final Color leftBarColor = AppColors.contentColorYellow;
  final Color rightBarColor = AppColors.contentColorRed;
  final Color avgColor =
      AppColors.contentColorOrange.avg(AppColors.contentColorRed);

  BarChartSample2({super.key});

  @override
  State<StatefulWidget> createState() => BarChartSample2State();
}

class BarChartSample2State extends State<BarChartSample2> {
  final double width = 7;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;
  List<int> defaulttime = [5, 7, 9, 13, 15, 20, 5];

  int touchedGroupIndex = -1;

  int indexweek = 1;
  int indexday = 1;
  late List<int> _sessionData = [];

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(days: 1), (timer) {
      DateTime now = DateTime.now();
      if (now.hour == 0 && now.minute == 0 && now.second == 0) {
        setState(() {
          indexday++;
          if (indexday > 7) {
            indexday = 1;
            indexweek++;
          }
        });
      }
    });
    _getGraphData();
  }

  Future<void> _getGraphData() async {
    final User? user = FirebaseAuth.instance.currentUser;

    final weekDoc = FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .collection('MeditationData')
        .doc('week$indexweek');
    final weekSnapshot = await weekDoc.get();
    if (weekSnapshot.exists) {
      final weekData = weekSnapshot.data();

      final List<int> defaultData = List.filled(7, 0);
      final List<int> dayDataList = [];

      for (int i = 1; i <= 7; i++) {
        final dynamic dayData = weekData?['day$i'];
        if (dayData is int) {
          dayDataList.add(dayData);
        } else if (dayData is List) {
          dayDataList.addAll(List<int>.from(dayData));
        } else {
          dayDataList.add(0); // Fill in zero if day data is missing
        }
      }

      _sessionData = List<int>.from(defaultData);
      _sessionData.setAll(0, dayDataList);

      // ignore: division_optimization
      _sessionData =
          // ignore: division_optimization
          _sessionData.map((seconds) => (seconds / 60).toInt()).toList();

      setState(() {
        final items = List.generate(_sessionData.length, (index) {
          return makeGroupData(index, defaulttime[index].toDouble(),
              _sessionData[index].toDouble());
        });
        rawBarGroups = items;
        showingBarGroups = rawBarGroups;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildColorIndicator('Total Meditation', widget.leftBarColor),
            const SizedBox(width: 20),
            _buildColorIndicator('Performed Meditation', widget.avgColor),
          ],
        ),
        const SizedBox(height: 20),
        Expanded(
          child: _sessionData.isEmpty
              ? const Center(
                  child: Text(
                    'No meditation has been performed yet.',
                    style: TextStyle(fontSize: 16),
                  ),
                )
              : BarChart(
                  BarChartData(
                    maxY: 30,
                    backgroundColor: const Color.fromARGB(255, 170, 196, 241),
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
                          if (touchedGroupIndex != -1) {
                            var sum = 0.0;
                            for (final rod
                                in showingBarGroups[touchedGroupIndex]
                                    .barRods) {
                              sum += rod.toY;
                            }
                            final avg = sum /
                                showingBarGroups[touchedGroupIndex]
                                    .barRods
                                    .length;

                            showingBarGroups[touchedGroupIndex] =
                                showingBarGroups[touchedGroupIndex].copyWith(
                              barRods: showingBarGroups[touchedGroupIndex]
                                  .barRods
                                  .map((rod) {
                                return rod.copyWith(
                                    toY: avg, color: widget.avgColor);
                              }).toList(),
                            );
                          }
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
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildColorIndicator(String text, Color color) {
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

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text = '';

    if (value == 5) {
      text = '5';
    } else if (value == 10) {
      text = '10';
    } else if (value == 15) {
      text = '15';
    } else if (value == 20) {
      text = '30';
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = ['Day1', 'Day2', 'Day3', 'Day4', 'Day5', 'Day6', 'Day7'];

    final Widget text = Text(
      titles[value.toInt()],
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

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: widget.leftBarColor,
          width: width,
        ),
        BarChartRodData(
          toY: y2,
          color: widget.rightBarColor,
          width: width,
        ),
      ],
    );
  }
}
