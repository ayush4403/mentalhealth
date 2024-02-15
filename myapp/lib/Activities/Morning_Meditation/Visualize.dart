import 'package:flutter/material.dart';
import 'package:myapp/Activities/Morning_Meditation/showvisualize.dart';

class Visualize extends StatefulWidget {
  const Visualize({super.key});

  @override
  State<Visualize> createState() => _VisualizeState();
}

class _VisualizeState extends State<Visualize> {
  late final List<MusicData> musicDataListChanting = [
    MusicData(
      title: 'Visualize1',
      imageUrl: 'assets/Images/logos.jpg',
      audioUrl: 'MORNING MEDITATION/Visualize/Visualize 1.mp3',
    ),
    MusicData(
      title: 'Visualize2',
      imageUrl: 'assets/Images/logos.jpg',
      audioUrl: 'MORNING MEDITATION/Visualize/Visualize 3.mp3',
    ),
    MusicData(
      title: 'Visualize3',
      imageUrl: 'assets/Images/logos.jpg',
      audioUrl: 'MORNING MEDITATION/Visualize/Visualize 5.mp3',
    ),
    MusicData(
      title: 'Visualize4',
      imageUrl: 'assets/Images/logos.jpg',
      audioUrl: 'MORNING MEDITATION/Visualize/Visualize 7.mp3',
    ),
  ];

  Widget _buildCategory(String Category, List<MusicData> musicList) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Category,
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
                        builder: (context) => VisualizeScreen(
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
    return Container(
      color: const Color.fromARGB(255, 8, 168, 236),
      child: ListView(
        children: [_buildCategory('', musicDataListChanting)],
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
