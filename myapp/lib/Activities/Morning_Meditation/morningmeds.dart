import 'package:MindFulMe/Activities/audiotemplate.dart';
import 'package:MindFulMe/Activities/cardview.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class MorningMeds extends StatefulWidget {
  const MorningMeds({super.key});

  @override
  State<MorningMeds> createState() => _MorningMedsState();
}

class _MorningMedsState extends State<MorningMeds> {
  late int index;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    loadIndexFromSharedPreferences();
    startTimer();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void loadIndexFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      index = prefs.getInt('meditation_index') ?? 0;
    });
  }

  void saveIndexToSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('meditation_index', index);
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(hours: 24), (Timer t) {
      setState(() {
        index = (index + 1) % 14;
        saveIndexToSharedPreferences();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
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

    // ignore: unused_local_variable
    List<String> titles = [
      'Serene Sunrise',
      'Tranquil Harmony',
      'Dawns Delight',
      'Peaceful Awakening',
      'Morning Bliss',
      'Zen Zephyr',
      'Gentle Dawn Chorus',
      'Harmonys Embrace',
      'Sunrise Serenity',
      'Tranquilitys Touch',
      'Radiant Morning Hues',
      'Blissful Daybreak',
      'Peaceful Dawn Melodies',
      'Serenitys Symphony',
      'Morning Mists Melody',
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
      body: AudioCard(
        imageUrl: images[index],
        title: titles[index],
        imageshow: false,
        timerSelectorfordisplay: false,
        audioFileName: audios[index],
      ),
    );
  }
}
