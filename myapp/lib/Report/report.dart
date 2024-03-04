import 'package:MindFulMe/Graphs/resources/BarGraph.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ChartReportTemplate extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;

  const ChartReportTemplate({
    super.key,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    List<dynamic> Activities = [
      'Morning Meditation',
      'Mental Marathon',
      'Sherlock Holmes',
      'Night Music',
    ];
    String formattedDate =
        DateFormat('EEEE d\'th\', MMM yyyy hh:mm:ss a').format(DateTime.now());
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'My performance report',
            style: TextStyle(
              color: Colors.white, // Change text color to white
              fontSize: 20, // Change font size
              fontWeight: FontWeight.bold, // Make the text bold
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 0, 111, 186),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    formattedDate, // Displaying current date
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Second Section: Cards with Images
                SizedBox(
                  height: 400, // Adjust the height as per your requirement
                  child: ListView.builder(
                    itemCount: Activities.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 3.0,
                        color: Colors.white,
                        margin: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image on left side
                            Container(
                              width: 100,
                              height: 100,
                              color: Colors.grey, // Placeholder color
                              // You can use AssetImage or NetworkImage here
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            // Heading and Percentage on right side
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 25,
                                ),
                                SizedBox(
                                  width: 150,
                                  child: Text(
                                    Activities[index],
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.yellow,
                                      borderRadius: BorderRadius.circular(25)),
                                  child: CircularPercentIndicator(
                                    radius: 25,
                                    percent: 0.4,
                                    lineWidth: 2,
                                    backgroundColor: Colors.blueAccent,
                                    center: const Text(
                                      '40%', // Replace with actual percentage
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        color: Color.fromARGB(255, 239, 16, 16),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: BarChartSample2(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LineChartSample extends StatelessWidget {
  const LineChartSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.4,
          child: LineChart(
            LineChartData(
                borderData: FlBorderData(show: true),
                gridData: const FlGridData(show: true),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      const FlSpot(2, 4),
                      const FlSpot(4, 5),
                      const FlSpot(5, 8),
                      const FlSpot(6, 9),
                    ],
                    isCurved: true,
                    color: const Color.fromARGB(255, 114, 243, 33),
                    barWidth: 5,
                    isStrokeCapRound: true,
                    belowBarData: BarAreaData(show: false),
                  ),
                ],
                titlesData: const FlTitlesData(
                    topTitles: AxisTitles(
                      axisNameWidget: Text('Activities'),
                      axisNameSize: 12,
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    rightTitles: AxisTitles(
                        axisNameWidget: Text('Days'),
                        sideTitles: SideTitles(showTitles: false)))),
          ),
        ),
      ),
    );
  }
}
