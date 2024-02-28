import 'dart:math';
import 'package:MindFulMe/Activities/cardview.dart';
import 'package:flutter/material.dart';
import 'package:MindFulMe/Activities/Power_nap/power_nap.dart';

class PowerNapList extends StatefulWidget {
  const PowerNapList({super.key});

  @override
  State<PowerNapList> createState() => _PowerNapListListState();
}

class _PowerNapListListState extends State<PowerNapList> {
  late final List<MusicData> musicDataListChanting = [
    MusicData(
      title: 'Power nap (10 min)',
      imageUrl: 'assets/Images/power_nap/pn_1.jpg',
      audioUrl: 'Power Nap/10 Minutes POWER NAP.mp3',
      gifurl: 'assets/Images/power_nap/pn_1.jpg',
    ),
    MusicData(
      title: 'Power nap (15 min)',
      imageUrl: 'assets/Images/power_nap/pn_2.jpg',
      audioUrl: 'Power Nap/15 Minutes POWER NAP.mp3',
      gifurl: 'assets/Images/power_nap/pn_2.jpg',
    ),
    MusicData(
      title: 'Power nap (20 min)',
      imageUrl: 'assets/Images/power_nap/pn_3.jpg',
      audioUrl: 'Power Nap/20 Minutes POWER NAP.mp3',
      gifurl: 'assets/Images/power_nap/pn_3.jpg',
    ),
    MusicData(
      title: 'Power nap (25 min)',
      imageUrl: 'assets/Images/power_nap/pn_4.jpg',
      audioUrl: 'Power Nap/25 Minutes POWER NAP.mp3',
      gifurl: 'assets/Images/power_nap/pn_4.jpg',
    ),
    MusicData(
      title: 'Power nap (30 min)',
      imageUrl: 'assets/Images/power_nap/pn_5.jpg',
      audioUrl: 'Power Nap/30 Minutes POWER NAP.mp3',
      gifurl: 'assets/Images/power_nap/pn_5.jpg',
    ),
    MusicData(
      title: 'Power nap (45 min)',
      imageUrl: 'assets/Images/power_nap/pn_6.jpg',
      audioUrl: 'Power Nap/45 Minutes POWER NAP.mp3',
      gifurl: 'assets/Images/power_nap/pn_6.jpg',
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
    Colors.lightBlueAccent[100]!,
    Colors.lime[100]!
  ];

  // Randomly shuffle the colors
  late final List<Color> shuffledColors = []
    // ignore: prefer_spread_collections
    ..addAll(colors)
    ..shuffle(Random());

  // Generate a random unique index for each card
  late List<int> cardColorIndices =
      List.generate(musicDataListChanting.length, (index) => index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop(const CardView());
          },
        ),
        title: const Text(
          'Power nap',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 111, 186),
      ),
      body: Container(
        color: const Color.fromARGB(255, 0, 111, 186),
        child: ListView.builder(
          itemCount: musicDataListChanting.length,
          itemBuilder: (context, index) {
            int colorIndex = cardColorIndices.removeAt(0);
            return _buildCategory(
                musicDataListChanting[index], shuffledColors[colorIndex]);
          },
        ),
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
              builder: (context) => PowerNapScreen(
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
