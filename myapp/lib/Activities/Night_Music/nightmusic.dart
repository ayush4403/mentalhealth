import 'dart:async';
import 'package:flutter/material.dart';
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
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {
          _animationCompleted = true;
        });
      });
    _controller.forward();
    selectedCategory = 'Chanting';
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  late final List<MusicData> musicDataListCalm = [
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
  ];

  late final List<MusicData> musicDataListStressBuster = [
    MusicData(
      title: 'Anti stress and body healing',
      imageUrl: 'assets/Images/Music/Law_of_attraction_1.jpg',
      audioUrl: 'Gratitude thought/Music/Anti_Stress_and_Body_Healing.mp3',
    ),
  ];

  late final List<MusicData> musicDataListChanting = [
    MusicData(
      title: 'Om mantra chanting',
      imageUrl: 'assets/Images/Music/om_mantra.jpg',
      audioUrl: 'Gratitude thought/Music/OM_Mantra_Chanting.mp3',
    ),
  ];
  final List<String> images = [
    'assets/Images/Music/Law_of_attraction_1.jpg',
    'assets/Images/Music/om_mantra.jpg',
    'assets/Images/types_quotes/gym_1.jpg',
  ];

  late List<List<MusicData>> allMusicData = [
    // Add all music data lists
    musicDataListCalm,
    musicDataListStressBuster,
    musicDataListChanting,
  ];
  Widget _buildButtonsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              selectedCategory = 'Chanting';
            });
          },
          child: const Text('Chanting'),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              selectedCategory = 'Stress Buster';
            });
          },
          child: const Text('Stress Buster'),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              selectedCategory = 'Calm';
            });
          },
          child: const Text('Calm'),
        ),
      ],
    );
  }

  int _currentCategoryIndex = 0;
  Widget _buildCategory(String categoryTitle, List<MusicData> NightMusic) {
    if (selectedCategory != categoryTitle) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            categoryTitle,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Column(
            children: NightMusic.asMap().entries.map((entry) {
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
          'Music',
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
            _buildCarousel(allMusicData[_currentCategoryIndex]),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < allMusicData.length; i++)
                  InkWell(
                    onTap: () {
                      setState(() {
                        _currentCategoryIndex = i;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentCategoryIndex == i
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            _buildButtonsRow(),
            _buildCategory('Chanting', musicDataListChanting),
            _buildCategory(
              'Stress Buster',
              musicDataListStressBuster,
            ),
            _buildCategory('Calm', musicDataListCalm),
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
      timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
        if (controller.page == null || controller.page! >= images.length - 1) {
          controller.jumpToPage(0);
        } else {
          controller.nextPage(
              duration: const Duration(milliseconds: 500), curve: Curves.ease);
        }
      });
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
