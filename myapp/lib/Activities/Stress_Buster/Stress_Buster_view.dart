import 'package:flutter/material.dart';

class AudioDetailsScreen extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String audioFileName;

  const AudioDetailsScreen({
    required this.imageUrl,
    required this.title,
    required this.audioFileName,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 200, // Adjust width as needed
              height: 200, // Adjust height as needed
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              audioFileName,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.skip_previous),
                  onPressed: () {
                    // Implement previous song functionality
                  },
                ),
                SizedBox(width: 24),
                IconButton(
                  icon: Icon(Icons.play_arrow),
                  onPressed: () {
                    // Implement play/pause functionality
                  },
                ),
                SizedBox(width: 24),
                IconButton(
                  icon: Icon(Icons.skip_next),
                  onPressed: () {
                    // Implement next song functionality
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
