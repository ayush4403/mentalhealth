import 'package:MindFulMe/Activities/cardview.dart';
import 'package:flutter/material.dart';
import 'package:MindFulMe/Activities/Power_nap/power_nap_list.dart';
import 'package:MindFulMe/Activities/audiotemplate.dart';
import 'package:lottie/lottie.dart';

class MusicData {
  final String title;
  final String imageUrl;
  final String audioUrl;

  MusicData({
    required this.title,
    required this.imageUrl,
    required this.audioUrl,
  });
}

class PowerNapScreen extends StatefulWidget {
  final String title;
  final String imageUrl;
  final String audioUrl;

  const PowerNapScreen({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.audioUrl,
  });

  @override
  // ignore: library_private_types_in_public_api
  _PowerNapScreenState createState() => _PowerNapScreenState();
}

class _PowerNapScreenState extends State<PowerNapScreen> {
  late String selectedAudioUrl;

  late final List<MusicData> musicList = [
    MusicData(
      title: 'Night Music 1',
      imageUrl: 'assets/Images/logos.jpg',
      audioUrl: 'Night Music/F-MEDITATION SLEEP-INNER AWARENESS.mp3',
    ),
    MusicData(
      title: 'Night Music 2',
      imageUrl: 'assets/Images/logos.jpg',
      audioUrl: 'Night Music/I-ACCELERATED LEARNING.mp3',
    ),
    MusicData(
      title: 'Night Music 3',
      imageUrl: 'assets/Images/logos.jpg',
      audioUrl: 'Night Music/I-FRONTAL LOBE.mp3',
    ),
    MusicData(
      title: 'Night Music 4',
      imageUrl: 'assets/Images/logos.jpg',
      audioUrl: 'Night Music/I-PROBLEM SOLVING SKILL.mp3',
    ),
    MusicData(
      title: 'Night Music 5',
      imageUrl: 'assets/Images/logos.jpg',
      audioUrl: 'Night Music/M-INCREASE MEMORY RETENTION.mp3',
    ),
  ];

  @override
  void initState() {
    super.initState();
    selectedAudioUrl =
        widget.audioUrl; // Set initial selected URL to default audio URL
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 111, 186),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop(const PowerNapList());
          },
        ),
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 111, 186),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                  0, 0, 0, MediaQuery.of(context).size.height * 0.02),
              child: AudioCard(
                imageUrl: widget.imageUrl,
                title: widget.title,
                audioFileName: selectedAudioUrl,
                imageshow: false,
                showPlaybackControlButton: false,
                showProgressBar: false,
                showTimerSelector: false,
                timerSelectorfordisplay: false,
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _openAnimatedDialog(context); // Show the dialog
                  Navigator.of(context).pop(
                    const CardView(),
                  );
                },
                child: const Text('Activity done'),
              ),
            ),
            const SizedBox(
              height: 20,
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

  // ignore: unused_element
  Widget _buildCategory(BuildContext context, List<MusicData> musicList) {
    // Shuffle the musicList to display random cards
    musicList.shuffle();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 12,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: musicList.map(
                (musicData) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedAudioUrl = musicData.audioUrl;
                        });
                      },
                      child: Container(
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                              ),
                              child: Image.asset(
                                musicData.imageUrl,
                                width: 100,
                                height: 100,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                musicData.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
