import 'package:MindFulMe/Activities/audiotemplate.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class MorningMeds extends StatefulWidget {
  const MorningMeds({Key? key}) : super(key: key);

  @override
  State<MorningMeds> createState() => _MorningMedsState();
}

class _MorningMedsState extends State<MorningMeds> {
  late int index;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    checkAndUpdateIndex();
    initializeIndex();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(minutes: 1), (Timer t) {
      checkAndUpdateIndex();
    });
  }

   void checkAndUpdateIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime? lastUpdate = prefs.getString('lastUpdate') != null
        ? DateTime.parse(prefs.getString('lastUpdate')!)
        : null;

    DateTime now = DateTime.now();
   
if (now.hour == 10 && now.minute >= 45 && now.minute <= 48) {
  print('Updating index between 10:22 AM and 10:23 AM...');
  int currentIndex = prefs.getInt('index') ?? 0;
  prefs.setInt('index', (currentIndex + 1) % 14);
  setState(() {
    index = prefs.getInt('index') ?? 0;
  });
  prefs.setString('lastUpdate', now.toString());
  print('Index updated to: $index');
} else {
  print('Conditions not met for index update.');
}

  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
    void initializeIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      index = prefs.getInt('index') ?? 0; // Use last stored index as default
    });
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
            Navigator.of(context).pop();
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
              child:AudioCard(
              audioFileName: audios[index],
              title: titles[index],
              imageUrl: images[index],
              showTimerSelector: false,
              imageshow: false,
              timerSelectorfordisplay: false,
              showPlaybackControlButton: false,
              )
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MorningMeds()),
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
                Navigator.of(context).pop();
              },
              child:  Text(index.toString()),
            ),
          ],
        ),
      ),
    );
  }
}
