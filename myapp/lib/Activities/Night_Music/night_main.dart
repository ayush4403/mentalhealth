import 'package:MindFulMe/Activities/Night_Music/nightmusic.dart';
import 'package:MindFulMe/Activities/audiotemplate.dart';
import 'package:MindFulMe/Activities/cardview.dart';
import 'package:MindFulMe/Activities/nighttemplate.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:MindFulMe/Activities/cardview.dart';

class NightMain extends StatefulWidget {
  const NightMain({super.key});

  @override
  State<NightMain> createState() => _NightMainState();
}

class _NightMainState extends State<NightMain> {
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
      'assets/Images/night_music/new_nm_1.jpg',
      'assets/Images/night_music/new_nm_2.jpg',
      'assets/Images/night_music/new_nm_3.jpg',
      'assets/Images/night_music/new_nm_4.jpg',
      'assets/Images/night_music/new_nm_5.jpg',
    ];

    List<String> titles = [
      'MoonTunes',
      'Midnight Melodies',
      'Nocturnal Notes',
      'Starry Soundtrack',
      'Twilight Tunes',
    ];

    List<String> audios = [
      'Night Music/F-MEDITATION SLEEP-INNER AWARENESS.mp3',
      'Night Music/I-ACCELERATED LEARNING-.mp3',
      'Night Music/I-FRONTAL LOBE.mp3',
      'Night Music/I-PROBLEM SOLVING SKILL.mp3',
      'Night Music/M-INCREASE MEMORY RETENTION.mp3',
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
          'Night Music',
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
              child: NightMusicCustomCard(
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
                  MaterialPageRoute(
                    builder: (context) => const NightMusic(),
                  ),
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
