import 'dart:async';
import 'package:flutter/material.dart';
import 'package:MindFulMe/Activities/Music/stressSecond.dart';

void main() {
  runApp(const MusicList());
}

class MusicList extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const MusicList({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MusicListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MusicListScreen extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const MusicListScreen({Key? key});

  @override
  // ignore: library_private_types_in_public_api
  _MusicListScreenState createState() => _MusicListScreenState();
}

class _MusicListScreenState extends State<MusicListScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  // ignore: unused_field
  late Animation<double> _animation;
  // ignore: unused_field
  bool _animationCompleted = false;
  late String selectedCategory;
  late PageController _pageController;

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
    _pageController = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _pageController.dispose();
    super.dispose();
  }

  late final List<MusicData> musicDataListCalm = [
    MusicData(
      title: 'Anti addication music',
      imageUrl: 'assets/Images/Music/ms_3.jpg',
      audioUrl: 'Gratitude thought/Music/Anti_Addication_Music.mp3',
    ),
    MusicData(
      title: 'Law of attraction',
      imageUrl: 'assets/Images/Music/ms_4.jpg',
      audioUrl: 'Gratitude thought/Music/Law_of_Attraction.mp3',
    ),
  ];

  late final List<MusicData> musicDataListStressBuster = [
    MusicData(
      title: 'Anti stress and body healing',
      imageUrl: 'assets/Images/Music/ms_1.jpg',
      audioUrl: 'Gratitude thought/Music/Anti_Stress_and_Body_Healing.mp3',
    ),
  ];

  late final List<MusicData> musicDataListChanting = [
    MusicData(
      title: 'Om mantra chanting',
      imageUrl: 'assets/Images/Music/ms_2.jpg',
      audioUrl: 'Gratitude thought/Music/OM_Mantra_Chanting.mp3',
    ),
  ];

  final List<String> images = [
    "assets/Images/Music/ms_1.jpg",
    "assets/Images/Music/ms_2.jpg",
    "assets/Images/Music/ms_3.jpg",
    "assets/Images/Music/ms_4.jpg",
  ];

  late List<List<MusicData>> allMusicData = [
    // Add all music data lists
    musicDataListCalm,
    musicDataListStressBuster,
    musicDataListChanting,
  ];
  Widget _buildCategorySlider(BuildContext context, List<MusicData> musicList) {
    Timer? timer;

    void startTimer() {
      timer = Timer.periodic(
        const Duration(seconds: 2),
        (Timer timer) {
          if (_pageController.page == null ||
              _pageController.page! >= musicList.length - 1) {
            _pageController.jumpToPage(0);
          } else {
            _pageController.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
            );
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: PageView.builder(
                      controller: _pageController, // Use _pageController here
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
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  musicList[index].imageUrl,
                                  width:
                                      MediaQuery.of(context).size.width * 0.95,
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

  // ignore: prefer_final_fields
  int _currentCategoryIndex = 0;
  Widget _buildCategory(String categoryTitle, List<MusicData> musicList) {
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
            children: musicList.asMap().entries.map((entry) {
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
                        builder: (context) => MusicCardDataScreen(
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
            _buildCategorySlider(context, allMusicData[_currentCategoryIndex]),
            const SizedBox(height: 20),
            _buildButtonsRow(),
            const SizedBox(height: 20),
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

  // ignore: unused_element
  Widget _buildCarousel(List<MusicData> musicList) {
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
          itemCount: musicList.length,
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
                  musicList[index].imageUrl,
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
