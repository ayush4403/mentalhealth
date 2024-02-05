import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(CardView());
}

class CardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Activities'),
        ),
        body: ActivityList(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ActivityList extends StatelessWidget {
  final List<String> activities = [
    'Morning Meditation',
    'Night Music',
    'Brain Training Games',
    'Mental Marathon',
    'Image Based Riddles',
    'Motivation Quotes',
    'Study Music',
    'Memory Technique',
    'Upcoming Events',
    'Stress Buster Music',
  ];

  final List<String> activityImages = [
    'assets/SVGS/meditation.svg',
    'assets/SVGS/night_music.svg',
    'assets/SVGS/brain_training.svg',
    'assets/SVGS/mental_marathon.svg',
    'assets/SVGS/image_based_riddles.svg',
    'assets/SVGS/brain_training.svg',
    'assets/SVGS/brain_training.svg',
    'assets/SVGS/brain_training.svg',
    'assets/SVGS/brain_training.svg',
    'assets/SVGS/brain_training.svg',

  ];

  void handleActivityTap(String activity) {
    // Handle the onPressed action for each activity here
    print('Tapped on: $activity');
  }

  void handleStartButtonTap(String activity) {
    // Handle the onPressed action for the "Start" button here
    print('Started: $activity');
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: activities.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 3,
          margin: EdgeInsets.all(8),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue[100], // Background color for the activity
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  activityImages[index],
                  width: 100,
                  height: 100,
                ),
                Expanded(
                  child: Text(
                    activities[index],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 80, // Adjust the width as needed for the "Start" button
                  child: ElevatedButton(
                    onPressed: () => handleStartButtonTap(activities[index]),
                    child: Text('Start', style: TextStyle(fontSize: 12)), // Adjust the font size
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
