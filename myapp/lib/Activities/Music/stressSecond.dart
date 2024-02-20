//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:myapp/Activities/Music/stressfirstscreen.dart';
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

class MusicCardDataScreen extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String audioUrl;

  MusicCardDataScreen({
    required this.title,
    required this.imageUrl,
    required this.audioUrl,
  });

  late final List<MusicData> musicList = [
    MusicData(
      title: 'Chanting 1',
      imageUrl: 'assets/Images/logos.jpg',
      audioUrl: 'Winter-Spa-chosic.mp3',
    ),
    MusicData(
      title: 'Chanting 2',
      imageUrl: 'assets/Images/logos.jpg',
      audioUrl: 'autumn-sky-meditation-7618.mp3',
    ),
    MusicData(
      title: 'Stress 1',
      imageUrl: 'assets/Images/logos.jpg',
      audioUrl: 'Winter-Spa-chosic.mp3',
    ),
    MusicData(
      title: 'Stress 2',
      imageUrl: 'assets/Images/logos.jpg',
      audioUrl: 'autumn-sky-meditation-7618.mp3',
    ),
    MusicData(
      title: 'Calm 1',
      imageUrl: 'assets/Images/logos.jpg',
      audioUrl: 'Winter-Spa-chosic.mp3',
    ),
    MusicData(
      title: 'Calm 2',
      imageUrl: 'assets/Images/logos.jpg',
      audioUrl: 'autumn-sky-meditation-7618.mp3',
    ),
    MusicData(
      title: 'Calm 4',
      imageUrl: 'assets/Images/logos.jpg',
      audioUrl: 'autumn-sky-meditation-7618.mp3',
    ),
    MusicData(
      title: 'Calm 3',
      imageUrl: 'assets/Images/logos.jpg',
      audioUrl: 'autumn-sky-meditation-7618.mp3',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 111, 186),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop(const MusicList());
          },
        ),
        title: const Text(
          'Music Card Data',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 111, 186),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                  0, 0, 0, MediaQuery.of(context).size.height * 0.05),
              child: AudioCard(
                imageUrl: imageUrl,
                title: title,
                audioFileName: audioUrl,
                showProgressBar: false,
                showPlaybackControlButton: false,
                showTimerSelector: false,
                imageshow: false,
              ),
            ),
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
                    onTap: () {},
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
