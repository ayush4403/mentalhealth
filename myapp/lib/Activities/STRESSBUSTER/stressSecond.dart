// music_card_data_screen.dart

import 'package:flutter/material.dart';
import 'package:myapp/Activities/audiotemplate.dart';

class MusicCardDataScreen extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String audioUrl;

  MusicCardDataScreen({
    required this.title,
    required this.imageUrl,
    required this.audioUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Music Card Data'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AudioCard(imageUrl: imageUrl, title: title, audioFileName: audioUrl)
          ],
        ),
      ),
    );
  }
}
