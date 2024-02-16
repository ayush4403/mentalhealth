import 'package:flutter/material.dart';

class ReportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ReportCard(
              key: Key('report_card'),
              title: 'Weekly Mood Tracker',
              description: 'Track your mood changes throughout the week.',
              onTap: () {
                // Navigate to the Weekly Mood Tracker screen
              },
            ),
            SizedBox(height: 16.0),
            ReportCard(
              key: Key('report_card'),
              title: 'Activity Summary',
              description: 'View your activity and progress summary.',
              onTap: () {
                // Navigate to the Activity Summary screen
              },
            ),
            SizedBox(height: 16.0),
            // Add more report options as needed
          ],
        ),
      ),
    );
  }
}

class ReportCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;

  const ReportCard({
    required Key key,
    required this.title,
    required this.description,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3.0,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                description,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
