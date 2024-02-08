import 'package:flutter/material.dart';

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
      appBar: AppBar(
        title: Text('Guided Meditation'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Music Player
          Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.blueGrey[100],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                  onPressed: () {
                    setState(() {
                      isPlaying = !isPlaying;
                    });
                  },
                ),
                SizedBox(width: 16.0),
                Text(
                  isPlaying ? 'Playing' : 'Paused',
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
          ),
          // Duration Cards
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildDurationCard('5 minutes'),
                SizedBox(height: 16.0),
                _buildDurationCard('10 minutes'),
                SizedBox(height: 16.0),
                _buildDurationCard('15 minutes'),
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
