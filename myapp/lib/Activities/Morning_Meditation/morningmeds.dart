import 'package:MindFulMe/Activities/audiotemplate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class MorningMeds extends StatefulWidget {
  const MorningMeds({super.key});

  @override
  State<MorningMeds> createState() => _MorningMedsState();
}

class _MorningMedsState extends State<MorningMeds> {
  late int index =0;
  late Timer timer;
  late FirebaseFirestore firestore;
  User? user;

  @override
  void initState() {
    super.initState();
    initializeUser();
    initializeFirestore();
    initializeIndex();
  }

  void initializeUser() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    user = auth.currentUser;
  }

  void initializeFirestore() {
    firestore = FirebaseFirestore.instance;
  }

  Future<void> initializeIndex() async {
    if (user != null) {
      DocumentSnapshot documentSnapshot = await firestore
          .collection('Users')
          .doc(user!.uid)
          .collection('meditationindex')
          .doc('indexdata')
          .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic>? data =
            documentSnapshot.data() as Map<String, dynamic>?;

        if (data != null) {
          int lastUpdatedDay = data['dayUpdated'] ?? 0;
          int currentDay = DateTime.now().day;

          if (lastUpdatedDay == currentDay) {
            setState(() {
              index = data['meditationIndex'] ?? 0; // Get current index
            });
          } else {
            updateFirestoreIndex(1, currentDay); // Update index to 1 for a new day
          }
        }
      } else {
        // Create the document if it doesn't exist and set index to 0
        createIndexDocument();
      }
    }
  }

  void updateFirestoreIndex(int newIndex, int currentDay) {
    firestore
        .collection('Users')
        .doc(user!.uid)
        .collection('meditationindex')
        .doc('indexdata')
        .update({
      'meditationIndex': newIndex,
      'lastUpdated': Timestamp.now(),
      'dayUpdated': currentDay,
    }).then((_) {
      setState(() {
        index = newIndex;
      });
      print('Index updated in Firestore to $newIndex.');
    }).catchError((error) {
      print('Error updating index in Firestore: $error');
    });
  }

  void createIndexDocument() {
    firestore
        .collection('Users')
        .doc(user!.uid)
        .collection('meditationindex')
        .doc('indexdata')
        .set({
      'meditationIndex': index,
      'lastUpdated': Timestamp.now(),
      'dayUpdated': DateTime.now().day,
    }).then((_) {
      print('Index document created in Firestore.');
    }).catchError((error) {
      print('Error creating index document in Firestore: $error');
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
              child: AudioCard(
                audioFileName: audios[index],
                title: titles[index],
                imageUrl: images[index],
                showTimerSelector: false,
                imageshow: false,
                timerSelectorfordisplay: false,
                showPlaybackControlButton: false,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(index.toString()),
            ),
          ],
        ),
      ),
    );
  }
}
