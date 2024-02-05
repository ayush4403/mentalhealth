import 'package:flutter/material.dart';
<<<<<<< HEAD
=======
import 'package:flutter_svg/flutter_svg.dart';
>>>>>>> f901e93769d25b890e4545ee2292bdc8d69faa38

void main() {
  runApp(CardView());
}

class CardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    
=======
>>>>>>> f901e93769d25b890e4545ee2292bdc8d69faa38
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

<<<<<<< HEAD
=======
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

>>>>>>> f901e93769d25b890e4545ee2292bdc8d69faa38
  void handleActivityTap(String activity) {
    // Handle the onPressed action for each activity here
    print('Tapped on: $activity');
  }

<<<<<<< HEAD
=======
  void handleStartButtonTap(String activity) {
    // Handle the onPressed action for the "Start" button here
    print('Started: $activity');
  }

>>>>>>> f901e93769d25b890e4545ee2292bdc8d69faa38
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: activities.length,
      itemBuilder: (context, index) {
<<<<<<< HEAD
        return GestureDetector(
          onTap: () => handleActivityTap(activities[index]),
          child: Card(
            elevation: 3,
            margin: EdgeInsets.all(10),
            child: Container(
              padding: EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: Colors.blue[100], // Background color for the activity
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  Text(
=======
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
>>>>>>> f901e93769d25b890e4545ee2292bdc8d69faa38
                    activities[index],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
<<<<<<< HEAD
                  SizedBox(
                    width: 80,
                    height: 35, // Adjust the width and height as needed for the "Start" button
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle the onPressed action for the "Start" button here
                        print('Started: ${activities[index]}');
                      },
                      child: Text('Start', style: TextStyle(fontSize: 12)), // Adjust the font size
                    ),
                  ),
                ],
              ),
=======
                ),
                SizedBox(
                  width: 80, // Adjust the width as needed for the "Start" button
                  child: ElevatedButton(
                    onPressed: () => handleStartButtonTap(activities[index]),
                    child: Text('Start', style: TextStyle(fontSize: 12)), // Adjust the font size
                  ),
                ),
              ],
>>>>>>> f901e93769d25b890e4545ee2292bdc8d69faa38
            ),
          ),
        );
      },
    );
  }
}
