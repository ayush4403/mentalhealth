import 'package:flutter/material.dart';
import 'package:myapp/Activities/STRESSBUSTER/stressSecond.dart';

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

class _MusicListScreenState extends State<MusicListScreen> {
  final List<MusicData> musicDataList = [
    MusicData(
      title: 'Song 1',
      imageUrl: 'assets/Images/logos.jpg',
      audioUrl: 'Winter-Spa-chosic.mp3',
    ),
    MusicData(
      title: 'Song 2',
      imageUrl: 'assets/Images/logos.jpg',
      audioUrl: 'autumn-sky-meditation-7618.mp3',
    ),

    // Add more music data here...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Music Card Data'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: musicDataList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MusicCardDataScreen(
                        title: musicDataList[index].title,
                        imageUrl: musicDataList[index].imageUrl,
                        audioUrl: musicDataList[index].audioUrl)),
              );
            },
            child: Card(
              child: ListTile(
                leading: Image.asset(
                  musicDataList[index].imageUrl,
                  width: 50,
                  height: 50,
                ),
                title: Text(musicDataList[index].title),
              ),
            ),
          );
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
