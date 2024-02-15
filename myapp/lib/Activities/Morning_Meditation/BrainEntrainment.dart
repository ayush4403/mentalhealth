import 'package:flutter/material.dart';
import 'package:myapp/Activities/audiotemplate.dart';

class BrainBeats extends StatefulWidget {
  const BrainBeats({Key? key}) : super(key: key);

  @override
  State<BrainBeats> createState() => BrainBeatsState();
}

class BrainBeatsState extends State<BrainBeats> {
  bool isPlaying = false;

  // Define a map to store music URLs for different durations
  Map<String, String> musicUrls = {
    '5 min': 'MORNING MEDITATION/Guided/Guided 1.mp3',
    '7 min': 'MORNING MEDITATION/Guided/Guided 3.mp3',
    '9 min': 'MORNING MEDITATION/Guided/Guided 5.mp3',
    '13 min': 'MORNING MEDITATION/Guided/Guided 7.mp3',
    '15 min': 'MORNING MEDITATION/Guided/Guided 8.mp3',
  };

  String selectedAudioUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Music Player
              Expanded(
                child: Container(
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 240,
                        left: 10,
                        top: 10,
                        child: _buildDurationButton('5 min'),
                      ),
                      Positioned(
                        bottom: 50,
                        left: 50,
                        top: 0,
                        child: _buildDurationButton('7 min'),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 140,
                        top: 1,
                        child: _buildDurationButton('9 min'),
                      ),
                      Positioned(
                        bottom: 50,
                        right: 50,
                        top: 0,
                        child: _buildDurationButton('13 min'),
                      ),
                      Positioned(
                        bottom: 240,
                        right: 10,
                        top: 10,
                        child: _buildDurationButton('15 min'),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),

              AudioCard(
                imageUrl: 'assets/Images/persons/AlbertEinstein/1.jpg',
                title: '5 min Music',
                audioFileName: selectedAudioUrl,
                showTimerSelector: false,
                imageshow: false,
              ),
              // Duration Cards
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDurationButton(String duration) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Material(
        shape: CircleBorder(),
        color: Colors.blue,
        child: InkWell(
          onTap: () {
            // Update selected audio URL
            setState(() {
              selectedAudioUrl = musicUrls[duration] ?? '';
            });
            print('Selected audio URL: $selectedAudioUrl');
          },
          child: Container(
            width: 80,
            height: 40,
            alignment: Alignment.center,
            child: Text(
              duration,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: BrainBeats(),
  ));
}
