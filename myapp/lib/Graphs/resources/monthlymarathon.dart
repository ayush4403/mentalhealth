import 'package:MindFulMe/reusable_widgets/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class _LineChartmain extends StatefulWidget {
  const _LineChartmain({required this.isShowingMainData});

  final bool isShowingMainData;
  State<_LineChartmain> createState() => LineChartmainState();
}

class LineChartmainState extends State<_LineChartmain> {
  late bool isShowingMainData;
  double percentage = 0;
  int touchedIndex = -1;
  int correctAnswers = 0;
  int incorrectAnswers = 0;
  int indexday = 1;
  int indexweek = 1;
  bool dataFetched = false;
  int totalAnswers = 5;
  List<FlSpot> spots = [];
    List<double> allDayPercentages = []; 
  @override
  void initState() {
    super.initState();
    _fetchdata();
    getPieData();
    isShowingMainData = true;
  }

  Future<void> _fetchdata() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final userDoc = FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .collection('mentalmarathondata')
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
        _updateCurrentDayAndWeekIndex(indexday, indexweek, currentdaylatest);
        getPieData();
      }
      print(
          'Current day and week index updated to: Day $indexday, Week $indexweek');
    } else {
      setState(() {
        indexday = 1;
        indexweek = 1;
      });
      _updateCurrentDayAndWeekIndex(indexday, indexweek, DateTime.now().day);
      print('Document does not exist');
    }
  }

  Future<void> _addMissingDay(
      String userId, int dayIndex, int weekIndex) async {
    final User? user = FirebaseAuth.instance.currentUser;
    try {
      final userDoc = FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('mentalmarathon')
          .doc('week$weekIndex}')
          .collection('day$dayIndex')
          .doc('data');
      await userDoc.set({
        'correctAnswers': 0,
        'incorrectAnswers': 0,
      }, SetOptions(merge: true));
      print('Added missing day $dayIndex for Week $weekIndex with value 0');
    } catch (e) {
      print('Error adding missing day: $e');
    }
  }

  Future<void> _updateCurrentDayAndWeekIndex(
      int indexday1, int indexweek1, int currentday) async {
    final User? user = FirebaseAuth.instance.currentUser;
    String weekPath = 'week$indexweek';

    final userDoc = FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .collection('mentalmarathondata')
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
      print('New document created with day $indexday, Week $indexweek');
    }
  }

  Future<void> getPieData() async {
     //List<double> allDayPercentages = [];
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      for (int weekIndex = 1; weekIndex <= indexweek; weekIndex++) {
      int startDayIndex = (weekIndex - 1) * 7 + 1; // Calculate the starting day index for each week

      // Loop through each day in the week (assuming each week has 7 days)
      for (int dayIndex = startDayIndex; dayIndex < startDayIndex + 7; dayIndex++) {
        // Construct the document path for the current day
        final userDoc = FirebaseFirestore.instance
            .collection('Users')
            .doc(user!.uid)
            .collection('mentalmarathon')
            .doc('week$weekIndex')
            .collection('day$dayIndex')
            .doc('data');
        final weekSnapshot = await userDoc.get();
        if (weekSnapshot.exists) {
          final weekData = weekSnapshot.data();
          setState(() {
            correctAnswers = weekData?['correctAnswers'] ?? 0;
            incorrectAnswers = weekData?['incorrectAnswers'] ?? 0;
            percentage =
                (correctAnswers / (incorrectAnswers + correctAnswers)) * 100;
           allDayPercentages.add(percentage);
          });
           print("your percentagedata $allDayPercentages");
        }
      }
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return LineChart(
      widget.isShowingMainData ? sampleData1 : sampleData2,
      duration: const Duration(milliseconds: 250),
    );
  }
  

  LineChartData get sampleData1 => LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData1,
        minX: 1,
        maxX: 30,
        maxY: 100,
        minY: 1,
      );

  LineChartData get sampleData2 => LineChartData(
        lineTouchData: lineTouchData2,
        gridData: gridData,
        titlesData: titlesData2,
        borderData: borderData,
        lineBarsData: lineBarsData2,
        minX: 1,
        maxX: 10,
        maxY: 100,
        minY: 1,
      );

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData1 => [
        //lineChartBarData1_1,
        lineChartBarData1_2,
        //lineChartBarData1_3,
      ];

  LineTouchData get lineTouchData2 => const LineTouchData(
        enabled: false,
      );

  FlTitlesData get titlesData2 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData2 => [
        //lineChartBarData2_1,
        //lineChartBarData2_2,
        //lineChartBarData2_3,
      ];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 25:
        text = '25';
        break;
        case 50:
        text = '50';
        break;
        case 75:
        text = '75';
        break;
        case 100:
        text = '100';
        break;
    

      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 40,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    int intValue = value.toInt();

    if (intValue >= 1 && intValue <= 30) {
      text = Text('${intValue}', style: style);
    } else {
      text = const Text('', style: style);
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => const FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom:
              BorderSide(color: AppColors.primary.withOpacity(0.2), width: 4),
          left: const BorderSide(color: Colors.transparent),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineChartBarData1_2 {
  List<FlSpot> spots = [];
  // Loop through allDayPercentages list to create FlSpot instances dynamically
  for (int i = 1; i < allDayPercentages.length; i++) {
    // Day index starts from 1, so add 1 to the loop variable to get the correct day
    int day = i;
    spots.add(FlSpot(day.toDouble(), allDayPercentages[i]));
    print(day.toDouble());
    print("here is your percentageeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee: ${allDayPercentages[i]}");
  }

  return LineChartBarData(
    isCurved: true,
    color: AppColors.contentColorPink,
    barWidth: 3,
    isStrokeCapRound: true,
    dotData: const FlDotData(show: false),
    belowBarData: BarAreaData(
      show: false,
      color: AppColors.contentColorPink.withOpacity(0),
    ),
    spots: spots, // Use the dynamically generated FlSpot list
  );
}
}

class LineChartSample1 extends StatefulWidget {
  const LineChartSample1({super.key});

  @override
  State<StatefulWidget> createState() => LineChartSample1State();
}

class LineChartSample1State extends State<LineChartSample1> {
  late bool isShowingMainData;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.23,
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(
                height: 37,
              ),
              const Text(
                'Mental Marathon',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 37,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16, left: 6),
                  child: _LineChartmain(isShowingMainData: isShowingMainData),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.white.withOpacity(isShowingMainData ? 1.0 : 0.5),
            ),
            onPressed: () {
              setState(() {
                isShowingMainData = !isShowingMainData;
              });
            },
          )
        ],
      ),
    );
  }
}
