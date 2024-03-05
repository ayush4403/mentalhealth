import 'package:MindFulMe/Activities/Morning_Meditation/mindfulmeditation.dart';
import 'package:MindFulMe/Activities/audiotemplate.dart';
import 'package:MindFulMe/Activities/cardview.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:MindFulMe/Activities/cardview.dart';

class MorningMeds extends StatefulWidget {
  const MorningMeds({super.key});

  @override
  State<MorningMeds> createState() => _MorningMedsState();
}

class _MorningMedsState extends State<MorningMeds> {
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
      'assets/Images/Morning_meditation/mm_1.jpg',
      'assets/Images/Morning_meditation/mm_2.jpg',
      'assets/Images/Morning_meditation/mm_3.jpg',
      'assets/Images/Morning_meditation/mm_4.jpg',
      'assets/Images/Morning_meditation/mm_5.jpg',
      'assets/Images/Morning_meditation/mm_6.jpg',
      'assets/Images/Morning_meditation/mm_7.jpg',
      'assets/Images/Morning_meditation/mm_8.jpg',
      'assets/Images/Morning_meditation/mm_9.jpg',
      'assets/Images/Morning_meditation/mm_10.jpg',
      'assets/Images/Morning_meditation/mm_11.jpg',
      'assets/Images/Morning_meditation/mm_12.jpg',
      'assets/Images/Morning_meditation/mm_13.jpg',
      'assets/Images/Morning_meditation/mm_14.jpg',
      'assets/Images/Morning_meditation/mm_15.jpg',
    ];

    List<String> titles = [
      'Serene Sunrise',
      'Tranquil Harmony',
      'Dawn\'s Delight',
      'Peaceful Awakening',
      'Morning Bliss',
      'Zen Zephyr',
      'Gentle Dawn Chorus',
      'Harmony\'s Embrace',
      'Sunrise Serenity',
      'Tranquility\'s Touch',
      'Radiant Morning Hues',
      'Blissful Daybreak',
      'Peaceful Dawn Melodies',
      'Serenity\'s Symphony',
      'Morning Mist\'s Melody',
    ];

    List<String> audios = [
      'MORNING MEDITATION/Guided/Guided 1.mp3',
      'MORNING MEDITATION/Visualize/Visualize 1.mp3',
      'MORNING MEDITATION/Brainbeats/B-BALANCE BRAIN AND BODY.mp3',
      'MORNING MEDITATION/Guided/Guided 3.mp3',
      'MORNING MEDITATION/Visualize/Visualize 3.mp3',
      'MORNING MEDITATION/Brainbeats/._F-FOCUS.mp3',
      'MORNING MEDITATION/Guided/Guided 5.mp3',
      'MORNING MEDITATION/Visualize/Visualize 9.mp3',
      'MORNING MEDITATION/Brainbeats/F-SELF CONCIOUSNEES-.mp3',
      'MORNING MEDITATION/Guided/Guided 7.mp3',
      'MORNING MEDITATION/Visualize/Visualize 5.mp3',
      'MORNING MEDITATION/Brainbeats/F-alertness-relaxed.mp3',
      'MORNING MEDITATION/Guided/Guided 9.mp3',
      'MORNING MEDITATION/Visualize/Visualize 7.mp3',
      'MORNING MEDITATION/Brainbeats/I-CREATIVITY.mp3',
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
          'Morning Meditation',
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
                  MaterialPageRoute(builder: (context) => const MorningMeditation()),
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