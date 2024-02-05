import 'package:flutter/material.dart';

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

  void handleActivityTap(String activity) {
    // Handle the onPressed action for each activity here
    print('Tapped on: $activity');
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: activities.length,
      itemBuilder: (context, index) {
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
                    activities[index],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
            ),
          ),
        );
      },
    );
  }
}
