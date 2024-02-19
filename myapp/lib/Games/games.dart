import 'package:flutter/material.dart';
import 'package:myapp/Games/mindfulnessgame.dart';

class GamesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Games'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GameOptionCard(
              key: Key('mindfulness_coloring_card'), // Provide a key here
              title: 'Mindfulness Coloring',
              description: 'Relax and unwind with coloring activities.',
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MindfulnessGame()));
              },
            ),
            SizedBox(height: 16.0),
            GameOptionCard(
              key: Key('breathing_exercises_card'), // Provide a key here
              title: 'Breathing Exercises',
              description:
                  'Practice different breathing techniques for relaxation.',
              onTap: () {
                // Navigate to the Breathing Exercises game screen
              },
            ),
            SizedBox(height: 16.0),
            // Add more game options as needed
          ],
        ),
      ),
    );
  }
}

class GameOptionCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;

  const GameOptionCard({
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
