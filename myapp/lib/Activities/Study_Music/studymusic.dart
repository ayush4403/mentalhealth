import 'dart:async';
import 'package:flutter/material.dart';
//import 'package:myapp/Activities/Night_Music/StudyMusicview.dart';
import 'package:myapp/Activities/Study_Music/studymusicview.dart';

void main() {
  runApp(const StudyMusic());
}

class StudyMusic extends StatelessWidget {
  const StudyMusic({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StudyMusicScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class StudyMusicScreen extends StatefulWidget {
  const StudyMusicScreen({Key? key});

  @override
  _StudyMusicScreenState createState() => _StudyMusicScreenState();
}

class _StudyMusicScreenState extends State<StudyMusicScreen>
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
      title: 'Serenity Sounds',
      imageUrl: 'assets/Images/night_music/nm_1.jpg',
      audioUrl:
          'Study Music/Y2meta.app - Can\'t Focus On Study_Work _ Listen To Boost Efficiency In Work_Study _ Binaural Beats (320 kbps).mp3',
      description:
          "Drift into a peaceful slumber with calming melodies curated to ease your mind and soothe your soul. Let the gentle rhythms of nature and ambient tunes guide you to a night of restful sleep.",
    ),
  ];

  // ignore: non_constant_identifier_names
  Widget _buildCategory(List<MusicData> StudyMusic) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Column(
            children: StudyMusic.asMap().entries.map((entry) {
              // ignore: unused_local_variable
              int index = entry.key;
              MusicData musicData = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StudyMusicViewScreen(
                          title: musicData.title,
                          imageUrl: musicData.imageUrl,
                          audioUrl: musicData.audioUrl,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 3,
                    color: getNextColor(),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.15,
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
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    musicData.description,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.025,
                                      fontWeight: FontWeight.normal,
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

// List of colors
  final List<Color> cardColors = [
    Colors.blue[100]!,
    Colors.red[100]!,
    Colors.green[100]!,
    Colors.yellow[100]!,
    Colors.orange[100]!,
    Colors.purple[100]!,
    Colors.teal[100]!,
    Colors.indigo[100]!,
    Colors.amber[100]!,
    Colors.deepOrange[100]!,
  ];

// Track the index of the last used color
  int lastColorIndex = -1;

// Function to get the next color ensuring no repetition
  Color getNextColor() {
    lastColorIndex = (lastColorIndex + 1) % cardColors.length;
    return cardColors[lastColorIndex];
  }

  Widget _buildCategorySlider(BuildContext context, List<MusicData> musicList) {
    // Shuffle the musicList to display random cards

    final PageController controller = PageController();

    // Start automatic sliding using a timer
    Timer? timer;

    void startTimer() {
      timer = Timer.periodic(
        const Duration(seconds: 2),
        (Timer timer) {
          if (controller.page == null ||
              controller.page! >= musicList.length - 1) {
            controller.jumpToPage(0);
          } else {
            controller.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease);
          }
        },
      );
    }

    // ignore: unused_element
    void cancelTimer() {
      timer?.cancel();
    }

    startTimer();

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
              mainAxisAlignment: MainAxisAlignment.center, // Center the slider
              children: [
                Center(
                  // Wrap with Center widget
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width *
                        0.95, // Adjusted width here
                    child: PageView.builder(
                      controller: controller,
                      itemCount: musicList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              child: ClipRRect(
                                // ClipRRect to apply rounded corners
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  musicList[index].imageUrl,
                                  width: MediaQuery.of(context).size.width *
                                      0.95, // Adjusted width here
                                  height:
                                      MediaQuery.of(context).size.height * 0.25,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
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
          'Study Music',
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
            _buildCategorySlider(context, allMusicData),
            _buildCategory(allMusicData),
          ],
        ),
      ),
    );
  }

  // ignore: unused_element, non_constant_identifier_names
  Widget _buildCarousel(List<MusicData> StudyMusic) {
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
          itemCount: StudyMusic.length,
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
  final String description; // Add this line

  MusicData({
    required this.title,
    required this.imageUrl,
    required this.audioUrl,
    required this.description, // Add this line
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
