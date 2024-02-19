import 'dart:math';
import 'package:flutter/material.dart';

import 'package:myapp/Activities/Morning_Meditation/showguided.dart';

class GuidedList extends StatefulWidget {
  const GuidedList({Key? key}) : super(key: key);

  @override
  State<GuidedList> createState() => _GuidedListState();
}

class _GuidedListState extends State<GuidedList> {
  late final List<MusicData> musicDataListChanting = [
    MusicData(
      title: 'GuidedList 1 (5 min)',
      imageUrl: 'assets/Images/Morning_meditation/vs_1.jpg',
      audioUrl: 'MORNING MEDITATION/Guided/Guided 1.mp3',
      gifurl: 'assets/GIF/Visualise/VZ1.json',
    ),
    MusicData(
      title: 'GuidedList 2 (7 min)',
      imageUrl: 'assets/Images/Morning_meditation/vs_2.jpg',
      audioUrl: 'MORNING MEDITATION/Guided/Guided 3.mp3',
      gifurl: 'assets/GIF/Visualise/VZ2.json',
    ),
    MusicData(
      title: 'GuidedList 3 (9 min)',
      imageUrl: 'assets/Images/Morning_meditation/vs_3.jpg',
      audioUrl: 'MORNING MEDITATION/Guided/Guided 5.mp3',
      gifurl: 'assets/GIF/Visualise/VZ3.json',
    ),
    MusicData(
      title: 'GuidedList 4 (13 min)',
      imageUrl: 'assets/Images/Morning_meditation/vs_4.jpg',
      audioUrl: 'MORNING MEDITATION/Guided/Guided 7.mp3',
      gifurl: 'assets/GIF/Visualise/VZ4.json',
    ),
    MusicData(
      title: 'GuidedList 5 (15 min)',
      imageUrl: 'assets/Images/Morning_meditation/vs_4.jpg',
      audioUrl: 'MORNING MEDITATION/Guided/Guided 8.mp3',
      gifurl: 'assets/GIF/Visualise/VZ5.json',
    ),
  ];

  // Color options
  final List<Color> colors = [
    Colors.blue[100]!,
    Colors.red[100]!,
    Colors.green[100]!,
    Colors.yellow[100]!,
    Colors.orange[100]!,
    Colors.purple[100]!,
    Colors.teal[100]!,
    Colors.indigo[100]!,
    Colors.amber[100]!,
    Colors.deepOrange[100]!,
  ];

  // Randomly shuffle the colors
  late final List<Color> shuffledColors = []
    ..addAll(colors)
    ..shuffle(Random());

  // Generate a random unique index for each card
  late List<int> cardColorIndices =
      List.generate(musicDataListChanting.length, (index) => index);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 0, 111, 186),
      child: ListView.builder(
        itemCount: musicDataListChanting.length,
        itemBuilder: (context, index) {
          int colorIndex = cardColorIndices.removeAt(0);
          return _buildCategory(
              musicDataListChanting[index], shuffledColors[colorIndex]);
        },
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget _buildCategory(MusicData musicData, Color cardColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShowGuidedScreen(
                title: musicData.title,
                imageUrl: musicData.imageUrl,
                audioUrl: musicData.audioUrl,
              ),
            ),
          );
        },
        child: Card(
          elevation: 3,
          margin: const EdgeInsets.all(3),
          color: cardColor,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.16,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      musicData.imageUrl,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          musicData.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MusicData {
  final String title;
  final String imageUrl;
  final String audioUrl;
  final String gifurl;

  MusicData(
      {required this.title,
      required this.imageUrl,
      required this.audioUrl,
      required this.gifurl});
}
