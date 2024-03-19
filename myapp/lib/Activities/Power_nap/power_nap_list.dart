import 'dart:math';
import 'package:MindFulMe/Activities/cardview.dart';
import 'package:flutter/material.dart';
import 'package:MindFulMe/Activities/Power_nap/power_nap.dart';
import 'package:lottie/lottie.dart';

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

  void _openAnimatedDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return Container();
      },
      transitionBuilder: (context, a1, a2, widget) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.5, end: 1).animate(a1),
          child: AlertDialog(
            backgroundColor: Colors.transparent,
            content: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 100, // Adjust height as needed
                        color: Colors.red, // Upper part background color
                      ),
                      SizedBox(
                        height:
                            2, // Adjust the thickness of the horizontal line
                        child: Container(
                          color: Colors.grey, // Color of the horizontal line
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            const Text(
                              'Great Job!',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'You have successfully completed today\'s activity. You have earned 50 coins for it. Come back tomorrow for more.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context); // Close the dialog box
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors
                                    .blue, // Change button color if needed
                              ),
                              child: const Text(
                                'OK',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 40, // Adjust positioning as needed
                    left: MediaQuery.of(context).size.width / 2 - 125,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white, // Circular background color
                        border: Border.all(
                          color: Colors.black, // Border color
                          width: 2, // Adjust the border width as needed
                        ),
                      ),
                      child: Lottie.asset(
                        'assets/GIF/ShowDialog/trophy.json',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ignore: non_constant_identifier_names
  Widget _buildCategory(MusicData musicData, Color cardColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: GestureDetector(
        onTap: () {
          _openAnimatedDialog(context); // Show the dialog
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
