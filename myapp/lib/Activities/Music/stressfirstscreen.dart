import 'package:flutter/material.dart';
import 'package:myapp/Activities/Music/stressSecond.dart';

void main() {
  runApp(const MusicList());
}

class MusicList extends StatelessWidget {
  const MusicList({super.key});

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
  const MusicListScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MusicListScreenState createState() => _MusicListScreenState();
}

class _MusicListScreenState extends State<MusicListScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
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
      title: 'Law of attration',
      imageUrl: 'assets/Images/logos.jpg',
      audioUrl: 'Gratitude thought/Music/Law_of_Attraction.mp3',
    ),
  ];
  late final List<MusicData> musicDataListStressBuster = [
    MusicData(
      title: 'Anti stress and body healing',
      imageUrl: 'assets/Images/logos.jpg',
      audioUrl: 'Gratitude thought/Music/Anti_Stress_and_Body_Healing.mp3',
    ),
  ];
  late final List<MusicData> musicDataListChanting = [
    MusicData(
      title: 'Om mantra chanting',
      imageUrl: 'assets/Images/logos.jpg',
      audioUrl: 'Gratitude thought/Music/OM_Mantra_Chanting.mp3',
    ),
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
                                fit: BoxFit.fitHeight,
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
      backgroundColor: const Color.fromARGB(255, 0, 111, 186),
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
      body: FutureBuilder(
        future: _controller.forward(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              !_animationCompleted) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FadeTransition(
                  opacity: _animation,
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Choose and listen to your music 🎧',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _buildButtonsRow(),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    children: [
                      _buildCategory('Chanting', musicDataListChanting),
                      _buildCategory(
                        'Stress Buster',
                        musicDataListStressBuster,
                      ),
                      _buildCategory('Calm', musicDataListCalm),
                    ],
                  ),
                ),
              ],
            );
          }
        },
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
