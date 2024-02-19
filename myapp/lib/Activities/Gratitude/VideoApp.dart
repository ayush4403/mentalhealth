import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class VideoApp extends StatefulWidget {
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  late int currentDay;
  bool isVideoPlaying = false;
  TextEditingController gratitudeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    currentDay = DateTime.now().day;
    fetchVideoUrl(currentDay);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> fetchVideoUrl(int day) async {
    try {
      // Replace 'video.mp4' with the name of your video file in Firebase Storage
      String videoUrl = await firebase_storage.FirebaseStorage.instance
          .ref('Gratitude thought/GRATITUTE_THOUGHT/$day.mp4')
          .getDownloadURL();

      _controller = VideoPlayerController.network(videoUrl);
      _initializeVideoPlayerFuture = _controller.initialize();

      _controller.addListener(() {
        if (_controller.value.isPlaying) {
          setState(() {
            isVideoPlaying = true;
          });
        } else {
          setState(() {
            isVideoPlaying = false;
          });
        }
      });

      // Start playing the video automatically when the screen loads
      _controller.play();
    } catch (error) {
      print('Error fetching video URL: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Player Demo',
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 0, 111, 186),
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 50.0),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    child: Stack(
                      children: [
                        FutureBuilder(
                          future: _initializeVideoPlayerFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return AspectRatio(
                                aspectRatio: _controller.value.aspectRatio,
                                child: VideoPlayer(_controller),
                              );
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                        if (isVideoPlaying)
                          Positioned(
                            bottom: 20,
                            left: 0,
                            right: 0,
                            child: VideoProgressIndicator(
                              _controller,
                              allowScrubbing: true,
                              padding: const EdgeInsets.all(8.0),
                              colors: const VideoProgressColors(
                                playedColor: Colors.redAccent,
                                bufferedColor: Colors.white,
                                backgroundColor: Colors.grey,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50.0),
                  FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        if (_controller.value.isPlaying) {
                          _controller.pause();
                        } else {
                          _controller.play();
                        }
                      });
                    },
                    backgroundColor: Colors.yellow,
                    child: Icon(
                      _controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.89,
                    height: MediaQuery.of(context).size.height * 0.16,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        cursorColor: Colors.black,
                        controller: gratitudeController,
                        style: const TextStyle(
                            color: Colors.black), // Set text color to white
                        decoration: const InputDecoration(
                          labelText: 'What are you grateful for today?',
                          labelStyle: TextStyle(
                              color: Colors.black), // Set label color to white
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors
                                    .greenAccent), // Set border color to yellow
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors
                                    .yellow), // Set focused border color to yellow
                          ),
                        ),
                        maxLines: 3,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Container(
                    width: 150,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: const Column(
                      children: [
                        Text(
                          'Done',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
