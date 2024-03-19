import 'package:MindFulMe/Activities/Night_Music/nightmusic.dart';
import 'package:MindFulMe/Activities/cardview.dart';
import 'package:MindFulMe/Activities/nighttemplate.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
                _openAnimatedDialog(context); // Show the dialog
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
}
