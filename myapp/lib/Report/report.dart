import 'package:flutter/material.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ReportCard(
              key: const Key('report_card'),
              title: 'Weekly Mood Tracker',
              description: 'Track your mood changes throughout the week.',
              onTap: () {
                // Navigate to the Weekly Mood Tracker screen
              },
            ),
            const SizedBox(height: 16.0),
            ReportCard(
              key: const Key('report_card'),
              title: 'Activity Summary',
              description: 'View your activity and progress summary.',
              onTap: () {
                // Navigate to the Activity Summary screen
              },
            ),
            const SizedBox(height: 16.0),
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                description,
                style: const TextStyle(
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
