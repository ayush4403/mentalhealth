// ignore_for_file: constant_identifier_names
import 'dart:async';
import 'package:MindFulMe/Graphs/PieChartSample2.dart';
import 'package:MindFulMe/Graphs/PieChartSample3.dart';
import 'package:MindFulMe/Graphs/resources/BarGraph.dart';
import 'package:MindFulMe/Report/Linechart.dart';
import 'package:MindFulMe/Report/Monthly.dart';
import 'package:MindFulMe/Report/Night_Report.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

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

  final List<Color> activityColors = [
    Colors.purple[200]!,
    Colors.lime[200]!,
    Colors.deepOrange[200]!,
    Colors.teal[200]!,
  ];

  String formattedDate =
      DateFormat('EEEE d\'th\', MMM yyyy hh:mm:ss a').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    // Start automatic sliding using a timer
    _timer = Timer.periodic(const Duration(seconds: 15), (Timer timer) {
      if (_currentPage < Activities.length - 1) {
        _activityPageController.animateToPage(
          _currentPage + 1,
          duration: const Duration(milliseconds: 1500),
          curve: Curves.easeInOut,
        );
      } else {
        _activityPageController.jumpToPage(0);
      }
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'My performance report',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 0, 111, 186),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                formattedDate,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
                  return Card(
                    elevation: 12.0,
                    color: activityColors[index],
                    margin: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        _activityPageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 1500),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            activityImages[index],
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Text(
                                  Activities[index],
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
                                    return Container(
                                      width: 20,
                                      height: 20,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 2.0),
                                      decoration: BoxDecoration(
                                        color: isDayDone
                                            ? Colors.green
                                            : Colors.red,
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: CircularPercentIndicator(
                                  radius: 25,
                                  percent: 0.4,
                                  lineWidth: 3,
                                  backgroundColor: Colors.blueAccent,
                                  center: const Text(
                                    '40%',
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      color: Color.fromARGB(255, 239, 16, 16),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            DropdownButton<Timeframe>(
              value: selectedTimeframe,
              onChanged: (Timeframe? newValue) {
                setState(() {
                  selectedTimeframe = newValue!;
                });
              },
              items: Timeframe.values.map<DropdownMenuItem<Timeframe>>(
                (Timeframe value) {
                  return DropdownMenuItem<Timeframe>(
                    value: value,
                    child:
                        Text(value == Timeframe.Weekly ? 'Weekly' : 'Monthly'),
                  );
                },
              ).toList(),
            ),

            // Display either LineChartSample2 or BarChartSample2 based on the selected timeframe
            if (selectedTimeframe == Timeframe.Weekly)
              SizedBox(
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
              ),
            if (selectedTimeframe == Timeframe.Monthly)
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
                child: PageView(
                  controller: _graphPageController,
                  children: [
                    MonthlyMeditation(),
                    MonthlyMeditation(),
                    MonthlyMeditation(),
                    MonthlyMeditation(),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
