import 'package:flutter/material.dart';
import 'package:myapp/Activities/audiotemplate.dart';

class MusicData {
  final String title;
  final String imageUrl;
  final String audioUrl;

  MusicData({
    required this.title,
    required this.imageUrl,
    required this.audioUrl,
  });
}

class NightMusicViewScreen extends StatefulWidget {
  final String title;
  final String imageUrl;
  final String audioUrl;

  NightMusicViewScreen({
    required this.title,
    required this.imageUrl,
    required this.audioUrl,
  });

  @override
  _NightMusicViewScreenState createState() => _NightMusicViewScreenState();
}

class _NightMusicViewScreenState extends State<NightMusicViewScreen> {
  late String selectedAudioUrl;

  late final List<MusicData> musicList = [
    MusicData(
      title: 'Night Music 1',
      imageUrl: 'assets/Images/logos.jpg',
      audioUrl: 'Night Music/F-MEDITATION SLEEP-INNER AWARENESS.mp3',
    ),
    MusicData(
      title: 'Night Music 2',
      imageUrl: 'assets/Images/logos.jpg',
      audioUrl: 'Night Music/I-ACCELERATED LEARNING.mp3',
    ),
    MusicData(
      title: 'Night Music 3',
      imageUrl: 'assets/Images/logos.jpg',
      audioUrl: 'Night Music/I-FRONTAL LOBE.mp3',
    ),
    MusicData(
      title: 'Night Music 4',
      imageUrl: 'assets/Images/logos.jpg',
      audioUrl: 'Night Music/I-PROBLEM SOLVING SKILL.mp3',
    ),
    MusicData(
      title: 'Night Music 5',
      imageUrl: 'assets/Images/logos.jpg',
      audioUrl: 'Night Music/M-INCREASE MEMORY RETENTION.mp3',
    ),
  ];

  @override
  void initState() {
    super.initState();
    selectedAudioUrl =
        widget.audioUrl; // Set initial selected URL to default audio URL
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 111, 186),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                  0,
                  MediaQuery.of(context).size.height * 0.3,
                  0,
                  MediaQuery.of(context).size.height * 0.05),
              child: AudioCard(
                imageUrl: widget.imageUrl,
                title: widget.title,
                audioFileName: selectedAudioUrl,
                imageshow: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Recommendations',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildCategory(BuildContext context, List<MusicData> musicList) {
    // Shuffle the musicList to display random cards
    musicList.shuffle();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: musicList.map((musicData) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedAudioUrl = musicData.audioUrl;
                      });
                    },
                    child: Container(
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                            child: Image.asset(
                              musicData.imageUrl,
                              width: 100,
                              height: 100,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              musicData.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
