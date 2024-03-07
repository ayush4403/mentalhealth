//import 'package:MindFulMe/Activities/Morning_Meditation/mindfulmeditation.dart';
import 'package:MindFulMe/Activities/Music/stressfirstscreen.dart';
import 'package:MindFulMe/Activities/audiotemplate.dart';
import 'package:MindFulMe/Activities/cardview.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:MindFulMe/Activities/cardview.dart';

class MainMusic extends StatefulWidget {
  const MainMusic({super.key});

  @override
  State<MainMusic> createState() => _MainMusicState();
}

// ignore: unused_element
class _MainMusicState extends State<MainMusic> {
  late int index = 0;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    loadIndexFromSharedPreferences(); // Load index before starting the timer
    startTimer();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void loadIndexFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime lastUpdated = DateTime.fromMillisecondsSinceEpoch(
      prefs.getInt('last_updated') ?? 0,
    );
    DateTime now = DateTime.now();

    if (lastUpdated.day != now.day) {
      // If it's a new day, set index to last index + 1
      int lastIndex = prefs.getInt('meditation_index') ?? 0;
      index = (lastIndex + 1) % 14;
      prefs.setInt('last_updated', now.millisecondsSinceEpoch);
      prefs.setInt('meditation_index', index);
    } else {
      // If it's the same day, load index from SharedPreferences
      index = prefs.getInt('meditation_index') ?? 0;
    }
  }

  void saveIndexToSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('meditation_index', index);
  }

  void startTimer() {
    DateTime now = DateTime.now();
    DateTime nextMidnight = DateTime(now.year, now.month, now.day + 1, 0, 0);
    Duration durationUntilMidnight = nextMidnight.difference(now);

    timer = Timer(
      durationUntilMidnight,
      () {
        setState(
          () {
            index = (index + 1) % 14; // Increment index by 1 every day
            saveIndexToSharedPreferences();
            startTimer();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> images = [
      'assets/Images/Music/mm_1.jpg',
      'assets/Images/Music/mm_2.jpg',
      'assets/Images/Music/mm_3.jpg',
      'assets/Images/Music/mm_4.jpg',
    ];

    List<String> titles = [
      'Anti Addication Music',
      'Anti Stress and Body Healing',
      'Law of Attraction',
      'OM Mantra Chanting',
    ];

    List<String> audios = [
      'Gratitude thought/Music/Anti_Addication_Music.mp3',
      'Gratitude thought/Music/Anti_Stress_and_Body_Healing.mp3',
      'Gratitude thought/Music/Law_of_Attraction.mp3',
      'Gratitude thought/Music/OM_Mantra_Chanting.mp3',
    ];

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
          'Music',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 111, 186),
      ),
      backgroundColor: const Color.fromARGB(255, 0, 111, 186),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              child: AudioCard(
                imageUrl: images[index],
                title: titles[index],
                imageshow: false,
                timerSelectorfordisplay: false,
                audioFileName: audios[index],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MusicList()),
                );
              },
              child: const Text(
                "Want more?",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(
                  const CardView(),
                );
              },
              child: const Text('Activity done'),
            ),
          ],
        ),
      ),
    );
  }
}
