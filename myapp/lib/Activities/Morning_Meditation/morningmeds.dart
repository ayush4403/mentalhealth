import 'package:MindFulMe/Activities/audiotemplate.dart';
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
    timer = Timer.periodic(Duration(hours: 24), (Timer t) {
      setState(() {
        index = (index + 1) % 14;
        saveIndexToSharedPreferences();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> images = [];
    List<String> titles = [];

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
    return AudioCard(
      imageUrl: 'new',
      title: 'nre',
      audioFileName: audios[index],
    );
  }
}
