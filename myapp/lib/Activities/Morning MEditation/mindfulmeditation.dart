import 'package:flutter/material.dart';

class MindfulMeditation extends StatefulWidget {
  const MindfulMeditation({Key? key}) : super(key: key);

  @override
  _MindfulMeditationState createState() => _MindfulMeditationState();
}

class _MindfulMeditationState extends State<MindfulMeditation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mindful Meditation'),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.blue, // Set background color to blue
      body: Column(
        children: [
          SizedBox(height: 20), // Leave space from the top

          // Container with rounded corners
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Music Title', // Replace with actual music title
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  // Progress bar, play/pause buttons, timer selection, etc.
                  // Add your audio player UI components here
                ],
              ),
            ),
          ),

          SizedBox(
              height: 20), // Leave space between the card and other content

          // Add to playlist and recommendation
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add to Playlist', // Replace with appropriate text
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                // Add your playlist and recommendation UI components here
              ],
            ),
          ),

          Spacer(), // Add spacer to push the bottom navigation to the bottom

          // Bottom navigation bar
          Container(
            color: Colors.blue,
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {}, // Add functionality for favorite icon
                  icon: Icon(Icons.favorite_border, color: Colors.white),
                ),
                IconButton(
                  onPressed: () {}, // Add functionality for share icon
                  icon: Icon(Icons.share, color: Colors.white),
                ),
                IconButton(
                  onPressed: () {}, // Add functionality for star icon
                  icon: Icon(Icons.star_border, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
