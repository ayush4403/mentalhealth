import 'package:flutter/material.dart';
import 'package:myapp/Activities/audiotemplate.dart';

class Visualize extends StatefulWidget {
  const Visualize({super.key});

  @override
  State<Visualize> createState() => _VisualizeState();
}

class _VisualizeState extends State<Visualize> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey[100],
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AudioCard(
              imageUrl: 'assets/Images/persons/AlbertEinstein/1.jpg',
              title: '5 min Music',
              audioFileName: 'autumn-sky-meditation-7618.mp3')
        ],
      ),
    );
  }
}
