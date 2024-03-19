import 'package:MindFulMe/Activities/audiotemplate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class MorningMeds extends StatefulWidget {
  const MorningMeds({Key? key}) : super(key: key);

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
    startDailyTimer();
  }

  void initializeUser() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    user = auth.currentUser;
  }

  void initializeFirestore() {
    firestore = FirebaseFirestore.instance;
  }
void startDailyTimer() {
    DateTime now = DateTime.now();
    DateTime nextFiveAM = DateTime(now.year, now.month, now.day, 5, 0, 0);
    if (now.isAfter(nextFiveAM)) {
      updateDailyIndex(); // Update index immediately if it's past 5 AM
    }

    timer = Timer.periodic(Duration(days: 1), (Timer t) {
      DateTime now = DateTime.now();
      if (now.hour == 5 && now.minute == 0) {
        updateDailyIndex();
      }
    });
  }

  void updateDailyIndex() {
    // Increment index by 1 every day
    int newIndex = (index + 1) % 15; // Ensure index stays within 0 to 14
    if (newIndex == 0) {
      resetIndex(); // Reset index to 0 after 15 days
    } else {
      updateFirestoreIndex(newIndex);
    }
  }

  void resetIndex() {
    updateFirestoreIndex(0);
  }

  void updateFirestoreIndex(int newIndex) {
    if (user != null) {
      firestore
          .collection('Users')
          .doc(user!.uid)
          .collection('meditationindex')
          .doc('indexdata')
          .update({
        'meditationIndex': newIndex,
        'lastUpdated': Timestamp.now(),
      }).then((_) {
        setState(() {
          index = newIndex;
        });
        print('Index updated in Firestore to $newIndex.');
      }).catchError((error) {
        print('Error updating index: $error');
      });
    }
  }

  void initializeIndex() async {
    if (user != null) {
      DocumentSnapshot documentSnapshot = await firestore
          .collection('Users')
          .doc(user!.uid)
          .collection('meditationindex')
          .doc('indexdata')
          .get();

      if (documentSnapshot.exists) {
        setState(() {
          index = documentSnapshot.get('meditationIndex') ?? 0;
        });
        print('Index initialized to $index from Firestore.');
      } else {
        // Create the document if it doesn't exist
        firestore
            .collection('Users')
            .doc(user!.uid)
            .collection('meditationindex')
            .doc('indexdata')
            .set({
          'meditationIndex': index,
          'lastUpdated': Timestamp.now(),
        }, SetOptions(merge: true)).then((_) {
          setState(() {
            index = 0;
          });
          print('Document created with initial index.');
        }).catchError((error) {
          print('Error creating document: $error');
        });
      }
    }
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
