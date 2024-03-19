import 'dart:async';
import 'package:MindFulMe/Graphs/resources/app_resources.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:MindFulMe/Graphs/resources/BarGraph.dart';
import 'package:MindFulMe/Report/Monthly.dart';
import 'package:MindFulMe/Report/Night_Report.dart';
import 'package:MindFulMe/Report/PieChartSample2.dart';
import 'package:MindFulMe/Report/PieChartSample3.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: constant_identifier_names
enum Timeframe { Weekly, Monthly }

class ChartReportTemplate extends StatefulWidget {
  const ChartReportTemplate({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChartReportTemplateState createState() => _ChartReportTemplateState();
}

class _ChartReportTemplateState extends State<ChartReportTemplate> {
  final PageController _activityPageController = PageController();
  final PageController _graphPageController = PageController();

  int _currentPage = 0;
  late Timer _timer;

  Timeframe selectedTimeframe = Timeframe.Weekly; // Default to Weekly
  int indexweek = 1;
  int indexday = 1;

  // ignore: unused_field
  late List<int> _sessionData = [];

  // ignore: non_constant_identifier_names
  List<dynamic> Activities = [
    'Morning Meditation',
    'Mental Marathon',
    'Sherlock Holmes',
    'Night Music',
  ];

  final List<String> activityImages = [
    'assets/Images/Report/1_Meditation.jpg',
    'assets/Images/Report/2_Marathon.jpg',
    'assets/Images/Report/3_Sherlock.jpg',
    'assets/Images/Report/4_Music.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
      const Duration(seconds: 15),
      (Timer timer) {
        if (_currentPage < Activities.length - 1) {
          _activityPageController.animateToPage(
            _currentPage + 1,
            duration: const Duration(milliseconds: 1500),
            curve: Curves.easeInOut,
          );
        } else {
          _activityPageController.jumpToPage(0);
        }
      },
    );
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
      setState(() {
        _sessionData = dayDataList;
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: AppBar(
          title: const Text(
            'My performance report',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: AppColors.primaryColor,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 12, right: 12, top: 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.primaryColor, AppColors.primaryColor],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('EEEE d\'th\', MMM yyyy').format(DateTime.now()),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.whiteColor,
                    ),
                  ),
                  Text(
                    DateFormat('hh:mm a').format(DateTime.now()),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 117,
              child: PageView.builder(
                controller: _activityPageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                    _graphPageController.jumpToPage(index);
                  });
                },
                itemCount: Activities.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                      elevation: 12.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          activityImages[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.02),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: DropdownButton<Timeframe>(
                value: selectedTimeframe,
                onChanged: (Timeframe? newValue) {
                  setState(
                    () {
                      selectedTimeframe = newValue!;
                    },
                  );
                },
                items: Timeframe.values.map<DropdownMenuItem<Timeframe>>(
                  (Timeframe value) {
                    return DropdownMenuItem<Timeframe>(
                      value: value,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          value == Timeframe.Weekly ? 'Weekly' : 'Monthly',
                          style: TextStyle(
                            color: AppColors.blackColor,
                          ),
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.whiteColor, AppColors.whiteColor],
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: selectedTimeframe == Timeframe.Weekly
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: PageView(
                        controller: _graphPageController,
                        children: [
                          BarChartSample2(),
                          const PieChartSample3(),
                          const PieChartSample2(),
                          const BarChartSample3(),
                        ],
                      ),
                    )
                  : SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: PageView(
                        controller: _graphPageController,
                        children: const [
                          MonthlyMeditation(),
                          MonthlyMeditation(),
                          MonthlyMeditation(),
                          MonthlyMeditation(),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
