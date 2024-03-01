import 'package:MindFulMe/Graphs/PieChart.dart';
import 'package:MindFulMe/Graphs/resources/BarGraph.dart';
import 'package:MindFulMe/Graphs/resources/Line.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartReportTemplate extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;

  const ChartReportTemplate({
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // First Section: Current Date
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                DateTime.now().toString(), // Displaying current date
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Second Section: Cards with Images
            SizedBox(
              height: 400, // Adjust the height as per your requirement
              child: ListView.builder(
                itemCount: 4,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3.0,
                    color: Colors.white,
                    margin: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        // Image on left side
                        Container(
                          width: 100,
                          height: 100,
                          color: Colors.grey, // Placeholder color
                          // You can use AssetImage or NetworkImage here
                        ),
                        SizedBox(width: 8.0),
                        // Heading and Percentage on right side
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Heading $index',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '10%', // Replace with actual percentage
                              style: TextStyle(
                                fontSize: 6.0,
                                color: Color.fromARGB(255, 239, 16, 16),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              width: double.infinity,
              height: 300,
              child: LineChartD(isShowingMainData: true),
            ),
            SizedBox(
              width: double.infinity,
              height: 300,
              child: BarChartSample2(),
            ),
            SizedBox(
              width: double.infinity,
              height: 300,
              child: PieChartSample1(),
            ),
          ],
        ),
      ),
    );
  }
}

class LineChartSample extends StatelessWidget {
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
                gridData: FlGridData(show: true),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      FlSpot(2, 4),
                      FlSpot(4, 5),
                      FlSpot(5, 8),
                      FlSpot(6, 9),
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
