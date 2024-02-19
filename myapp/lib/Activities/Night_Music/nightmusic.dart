import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myapp/Activities/Music/stressSecond.dart';
import 'package:myapp/Activities/Night_Music/nightmusicview.dart';

void main() {
  runApp(const NightMusic());
}

class NightMusic extends StatelessWidget {
  const NightMusic({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NightMusicScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class NightMusicScreen extends StatefulWidget {
  const NightMusicScreen({Key? key});

  @override
  _NightMusicScreenState createState() => _NightMusicScreenState();
}

class _NightMusicScreenState extends State<NightMusicScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  // ignore: unused_field
  late Animation<double> _animation;
  // ignore: unused_field
  bool _animationCompleted = false;
  late String selectedCategory;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final List<String> images = [
    'assets/Images/Music/Law_of_attraction_1.jpg',
    'assets/Images/Music/om_mantra.jpg',
    'assets/Images/types_quotes/gym_1.jpg',
  ];

  final List<MusicData> allMusicData = [
    // Add all music data lists
    MusicData(
      title: 'Law of attraction',
      imageUrl: 'assets/Images/Music/Law_of_attraction_1.jpg',
      audioUrl: 'Gratitude thought/Music/Anti_Addication_Music.mp3',
    ),
    MusicData(
      title: 'Anti stress and body healing',
      imageUrl: 'assets/Images/types_quotes/gym_1.jpg',
      audioUrl: 'Gratitude thought/Music/Law_of_Attraction.mp3',
    ),
    MusicData(
      title: 'Anti stress and body healing',
      imageUrl: 'assets/Images/Music/Law_of_attraction_1.jpg',
      audioUrl: 'Gratitude thought/Music/Anti_Stress_and_Body_Healing.mp3',
    ),
    MusicData(
      title: 'Om mantra chanting',
      imageUrl: 'assets/Images/Music/om_mantra.jpg',
      audioUrl: 'Gratitude thought/Music/OM_Mantra_Chanting.mp3',
    ),
  ];

  Widget _buildCategory(List<MusicData> NightMusic) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Night Music',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Column(
            children: NightMusic.asMap().entries.map((entry) {
              int index = entry.key;
              MusicData musicData = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NightMusicViewScreen(
                          title: musicData.title,
                          imageUrl: musicData.imageUrl,
                          audioUrl: musicData.audioUrl,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 3, // Apply elevation here
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width *
                          0.9, // Adjust card width
                      height: MediaQuery.of(context).size.height *
                          0.16, // Adjust card height
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                musicData.imageUrl,
                                height: 200,
                                width: 150,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    musicData.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryslider(BuildContext context, List<MusicData> musicList) {
    // Shuffle the musicList to display random cards
    musicList.shuffle();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: musicList.map((musicData) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () {},
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
                            borderRadius: BorderRadius.only(
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
                              style: TextStyle(
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
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            _buildCategoryslider(context, allMusicData),
            _buildCategory(allMusicData),
          ],
        ),
      ),
    );
  }

  Widget _buildCarousel(List<MusicData> NightMusic) {
    final PageController controller = PageController();

    // Start automatic sliding using a timer
    Timer? timer;

    void startTimer() {
      timer = Timer.periodic(
        const Duration(seconds: 2),
        (Timer timer) {
          if (controller.page == null ||
              controller.page! >= images.length - 1) {
            controller.jumpToPage(0);
          } else {
            controller.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease);
          }
        },
      );
    }

    void cancelTimer() {
      timer?.cancel();
    }

    startTimer();

    return GestureDetector(
      onTap: () {
        cancelTimer();
        startTimer();
      },
      child: SizedBox(
        height: 300,
        child: PageView.builder(
          controller: controller,
          itemCount: NightMusic.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.withOpacity(0.2),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  images[index],
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

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

class MusicDetailsScreen extends StatelessWidget {
  final MusicData musicData;

  const MusicDetailsScreen({super.key, required this.musicData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 111, 186),
      appBar: AppBar(
        title: Text(musicData.title),
      ),
      body: Column(
        children: [
          Image.asset(
            musicData.imageUrl,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          ElevatedButton(
            onPressed: () {
              // Play music
            },
            child: const Text('Play Music'),
          ),
        ],
      ),
    );
  }
}
