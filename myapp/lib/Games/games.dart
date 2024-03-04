import 'package:flutter/material.dart';
import 'package:MindFulMe/Games/mindfulnessgame.dart';

class GamesPage extends StatelessWidget {
  const GamesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Games'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GameOptionCard(
              key: const Key('mindfulness_coloring_card'),
              title: 'Mindfulness Coloring',
              description: 'Relax and unwind with coloring activities.',
              level: 1, // Add the level number here
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RoadMap()));
              },
            ),
            const SizedBox(
              height: 16.0,
            ),
            GameOptionCard(
              key: const Key('breathing_exercises_card'),
              title: 'Breathing Exercises',
              description:
                  'Practice different breathing techniques for relaxation.',
              level: 2, // Add the level number here
              onTap: () {
                // Navigate to the Breathing Exercises game screen
              },
            ),
            const SizedBox(
              height: 16.0,
            ),
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
  final int level; // Add level parameter
  final VoidCallback onTap;

  const GameOptionCard({
    required Key key,
    required this.title,
    required this.description,
    required this.level, // Include level parameter
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3.0,
        child: Padding(
          padding: const EdgeInsets.all(
            16.0,
          ),
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
              const SizedBox(
                height: 8.0,
              ),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                'Level $level', // Display level number here
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
