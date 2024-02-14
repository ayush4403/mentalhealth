import 'package:flutter/material.dart';
import 'package:myapp/Activities/Music/stressSecond.dart';

void main() {
  runApp(MusicList());
}

class MusicList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MusicListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MusicListScreen extends StatefulWidget {
  @override
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
      duration: Duration(seconds: 2),
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
      title: 'Calm 1',
      imageUrl: 'assets/Images/logos.jpg',
      audioUrl: 'MORNING MEDITATION/Guided/Guided 1.mp3',
    ),
    MusicData(
      title: 'Calm 2',
      imageUrl: 'assets/Images/logos.jpg',
      audioUrl: 'autumn-sky-meditation-7618.mp3',
    ),
    MusicData(
      title: 'Calm 4',
      imageUrl: 'assets/Images/logos.jpg',
      audioUrl: 'autumn-sky-meditation-7618.mp3',
    ),
    MusicData(
      title: 'Calm 3',
      imageUrl: 'assets/Images/logos.jpg',
      audioUrl: 'autumn-sky-meditation-7618.mp3',
    ),
  ];
  late final List<MusicData> musicDataListStressBuster = [
    MusicData(
      title: 'Stress 1',
      imageUrl: 'assets/Images/logos.jpg',
      audioUrl: 'Winter-Spa-chosic.mp3',
    ),
    MusicData(
      title: 'Stress 2',
      imageUrl: 'assets/Images/logos.jpg',
      audioUrl: 'autumn-sky-meditation-7618.mp3',
    ),
  ];
  late final List<MusicData> musicDataListChanting = [
    MusicData(
      title: 'Chanting 1',
      imageUrl: 'assets/Images/logos.jpg',
      audioUrl: 'Winter-Spa-chosic.mp3',
    ),
    MusicData(
      title: 'Chanting 2',
      imageUrl: 'assets/Images/logos.jpg',
      audioUrl: 'autumn-sky-meditation-7618.mp3',
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
          child: Text('Chanting'),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              selectedCategory = 'Stress Buster';
            });
          },
          child: Text('Stress Buster'),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              selectedCategory = 'Calm';
            });
          },
          child: Text('Calm'),
        ),
      ],
    );
  }

  Widget _buildCategory(String categoryTitle, List<MusicData> musicList) {
    if (selectedCategory != categoryTitle) {
      return SizedBox.shrink();
    }
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            categoryTitle,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          Column(
            children: musicList.asMap().entries.map((entry) {
              // ignore: unused_local_variable
              int index = entry.key;
              MusicData musicData = entry.value;
              return Padding(
                padding: EdgeInsets.only(bottom: 16),
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
                                    style: TextStyle(
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
        title: Text('Music'),
      ),
      body: FutureBuilder(
        future: _controller.forward(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              !_animationCompleted) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FadeTransition(
                  opacity: _animation,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Choose and listen to your music',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                _buildButtonsRow(),
                SizedBox(height: 20),
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
