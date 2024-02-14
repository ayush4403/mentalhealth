import 'package:flutter/material.dart';
import 'package:myapp/Activities/audiotemplate.dart';

class Guided extends StatefulWidget {
  const Guided({Key? key}) : super(key: key);

  @override
  State<Guided> createState() => _GuidedState();
}

class _GuidedState extends State<Guided> {
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Music Player
          Container(
            color: Colors.blueGrey[100],
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AudioCard(
                    imageUrl: 'assets/Images/persons/AlbertEinstein/1.jpg',
                    title: '5 min Music',
                    audioFileName: 'autumn-sky-meditation-7618.mp3')
              ],
            ),
          ),
          // Duration Cards
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildDurationCard(
                  '5 minutes',
                ),
                const SizedBox(
                  height: 16.0,
                ),
                _buildDurationCard(
                  '10 minutes',
                ),
                const SizedBox(
                  height: 16.0,
                ),
                _buildDurationCard(
                  '15 minutes',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDurationCard(String duration) {
    return GestureDetector(
      onTap: () {
        // Play audio based on duration
        print('Playing $duration audio');
      },
      child: Card(
        elevation: 4.0,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            duration,
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Guided(),
  ));
}
