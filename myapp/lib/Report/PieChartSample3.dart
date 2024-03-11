// ignore_for_file: file_names

import 'package:MindFulMe/Graphs/resources/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PieChartSample3 extends StatefulWidget {
  const PieChartSample3({super.key});

  @override
  State<StatefulWidget> createState() => PieChartSample3State();
}

class PieChartSample3State extends State {
  int touchedIndex = -1;
  int correctAnswers = 0;
  int incorrectAnswers = 0;
  @override
  void initState() {
    getPieData();
    super.initState();
  }
  @override
void dispose(){
  super.dispose();
}
  Future<void> getPieData() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      final weekDoc = FirebaseFirestore.instance
          .collection('Users')
          .doc(user!.uid)
          .collection('mentalmarathon')
          .doc('data1');
      final weekSnapshot = await weekDoc.get();
      if (weekSnapshot.exists) {
        final weekData = weekSnapshot.data();
        setState(() {
          correctAnswers = weekData?['correctAnswers'] ?? 0;
          incorrectAnswers = weekData?['incorrectAnswers'] ?? 0;
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1.3,
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
                      touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                    });
                  },
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 2,
                centerSpaceRadius: 2,
                sections: showingSections(),
              ),
            ),
          ),
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Indicator(
              color: Colors.green,
              text: 'Right Answer',
            ),
            SizedBox(width: 20),
            Indicator(
              color: Colors.red,
              text: 'Wrong Answer',
            ),
          ],
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    List<PieChartSectionData> sections = [];

    double totalAnswers =
        correctAnswers.toDouble() + incorrectAnswers.toDouble();
    print('Total Answers: $totalAnswers');

    double correctPercentage = (correctAnswers.toDouble() / totalAnswers) * 100;
    double incorrectPercentage =
        (incorrectAnswers.toDouble() / totalAnswers) * 100;
    print('Total Answers: $correctPercentage');
    print('Total Answers: $incorrectPercentage');

    sections.add(
      PieChartSectionData(
        color: Colors.green,
        value: correctPercentage,
        title: correctPercentage.toString(),
        radius: touchedIndex == 0 ? 120.0 : 100.00,
        titleStyle: TextStyle(
          fontSize: touchedIndex == 0 ? 25.0 : 16.0,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
          shadows: [Shadow(color: Colors.black, blurRadius: 5)],
        ),
        badgeWidget: _Badge(
          'assets/Images/Report/Mental_Report/right.svg',
          size: touchedIndex == 0 ? 45.0 : 55.0,
          borderColor: AppColors.contentColorBlack,
        ),
        badgePositionPercentageOffset: .98,
      ),
    );

    sections.add(
      PieChartSectionData(
        color: Colors.red,
        value: incorrectPercentage,
        title: incorrectPercentage.toString(),
        radius: touchedIndex == 1 ? 120.0 : 100.00,
        titleStyle: TextStyle(
          fontSize: touchedIndex == 1 ? 25.0 : 16.0,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
          shadows: [Shadow(color: Colors.black, blurRadius: 5)],
        ),
        badgeWidget: _Badge(
          'assets/Images/Report/Mental_Report/wrong.svg',
          size: touchedIndex == 1 ? 45.0 : 55.0,
          borderColor: AppColors.contentColorBlack,
        ),
        badgePositionPercentageOffset: .98,
      ),
    );

    return sections;
  }
}

class _Badge extends StatelessWidget {
  const _Badge(
    this.svgAsset, {
    required this.size,
    required this.borderColor,
  });
  final String svgAsset;
  final double size;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 1,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(
        child: SvgPicture.asset(
          svgAsset,
        ),
      ),
    );
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
