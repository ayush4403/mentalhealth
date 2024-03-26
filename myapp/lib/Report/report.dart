import 'dart:async';
import 'package:MindFulMe/Graphs/resources/app_resources.dart';
import 'package:MindFulMe/Graphs/resources/linechart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:MindFulMe/Graphs/resources/BarGraph.dart';
import 'package:MindFulMe/Report/Monthly.dart';
import 'package:MindFulMe/Report/Night_Report.dart';
import 'package:MindFulMe/Report/PieChartSample2.dart';
import 'package:MindFulMe/Report/PieChartSample3.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shimmer/shimmer.dart';

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
    'assets/Images/Report/1_morning_meditation.jpg',
    'assets/Images/Report/2_mental_marathon.jpg',
    'assets/Images/Report/3_shelock_holmes.jpg',
    'assets/Images/Report/4_night_music.jpg',
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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 8,
              ),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('EEEE d\'th\', MMM yyyy')
                          .format(DateTime.now()),
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
                    setState(
                      () {
                        _currentPage = index;
                        _graphPageController.jumpToPage(index);
                      },
                    );
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
                        child: Stack(
                          children: [
                            // Image
                            Positioned.fill(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  activityImages[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            // Percentage Circle
                            Positioned(
                              top: 25,
                              right: 10,
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primaryColor,
                                ),
                                child: Text(
                                  '${(index + 1) * 10}%', // Change this to your percentage value
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            // Card Name
                            Positioned(
                              bottom: 10,
                              left: 10,
                              child: Container(
                                // color: AppColors.bgColor,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: AppColors.bgColor,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                ),
                                child: Text(
                                  Activities[index],
                                  style: TextStyle(
                                    fontSize: 14,
                                    backgroundColor: AppColors.bgColor,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: Colors.grey,
                child: Container(
                  height: 1,
                  width: 500,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.bgColor,
                      borderRadius: BorderRadius.circular(20.0),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                selectedTimeframe == Timeframe.Weekly
                                    ? AppColors.primaryColor
                                    : Colors.grey[300],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            minimumSize: const Size(
                              150,
                              40,
                            ),
                          ),
                          onPressed: () {
                            setState(
                              () {
                                selectedTimeframe = Timeframe.Weekly;
                              },
                            );
                          },
                          child: Text(
                            'Weekly',
                            style: TextStyle(
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                selectedTimeframe == Timeframe.Monthly
                                    ? AppColors.primaryColor
                                    : Colors.grey[300],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            minimumSize: const Size(
                              150,
                              40,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              selectedTimeframe = Timeframe.Monthly;
                            });
                          },
                          child: Text(
                            'Monthly',
                            style: TextStyle(
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
                          children:   [
                            MonthlyMeditation(),
                            LineChartSample2(),
                            MonthlyMeditation(),
                            MonthlyMeditation(),
                          ],
                        ),
                      ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: Colors.grey,
                child: Container(
                  height: 1,
                  width: 500,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              const Column(
                children: [ActivityCardRow()],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ActivityCardRow extends StatelessWidget {
  const ActivityCardRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ActivityCard(
          image: 'assets/Images/Report/1_morning_meditation.jpg',
          name: 'Morning Meditation',
          progress: 40,
        ),
        ActivityCard(
          image: 'assets/Images/Report/2_mental_marathon.jpg',
          name: 'Mental Marathon',
          progress: 70,
        ),
        ActivityCard(
          image: 'assets/Images/Report/3_shelock_holmes.jpg',
          name: 'Sherlock Holmes',
          progress: 20,
        ),
        ActivityCard(
          image: 'assets/Images/Report/4_night_music.jpg',
          name: 'Night Music',
          progress: 90,
        ),
      ],
    );
  }
}

class ActivityCard extends StatelessWidget {
  final String image;
  final String name;
  final int progress;

  const ActivityCard({
    super.key,
    required this.image,
    required this.name,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(8),
      child: Card(
        elevation: 14.0,
        color: Colors.cyan[100],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  image,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 25.0),
                Row(
                  children: List.generate(
                    7,
                    (dayIndex) {
                      // Replace the condition with your actual logic
                      bool isDayDone = dayIndex % 2 == 0;
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          width: 20,
                          height: 20,
                          margin: const EdgeInsets.symmetric(horizontal: 2.0),
                          decoration: BoxDecoration(
                            color: isDayDone ? Colors.green : Colors.red,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            // Column(
            //   children: [
            //     const SizedBox(
            //       height: 20,
            //     ),
            //     Container(
            //       decoration: BoxDecoration(
            //         color: Colors.yellow,
            //         borderRadius: BorderRadius.circular(25),
            //       ),
            //       child: CircularPercentIndicator(
            //         radius: 25,
            //         percent: 0.4,
            //         lineWidth: 3,
            //         backgroundColor: Colors.blueAccent,
            //         center: const Text(
            //           '40%',
            //           style: TextStyle(
            //             fontSize: 13.0,
            //             color: Color.fromARGB(255, 239, 16, 16),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
