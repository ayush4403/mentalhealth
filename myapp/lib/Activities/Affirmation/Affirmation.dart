// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:MindFulMe/Activities/cardview.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AffirmationApp extends StatefulWidget {
  const AffirmationApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AffirmationAppState createState() => _AffirmationAppState();
}

class _AffirmationAppState extends State<AffirmationApp> {
  late VideoPlayerController _controller;
  late Future<void> initializeVideoPlayerFuture;
  late int currentDay;
  bool isVideoPlaying = false;
  TextEditingController gratitudeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    currentDay = DateTime.now().day;
    _controller =
        // ignore: deprecated_member_use
        VideoPlayerController.network(""); // Initialize with an empty URL
    _initializeVideoPlayer();
    fetchVideoUrl(currentDay);
  }

  Future<void> _initializeVideoPlayer() async {
    initializeVideoPlayerFuture = _controller.initialize();
    await initializeVideoPlayerFuture;
    setState(() {}); // Update the UI after initialization
  }

  Future<void> fetchVideoUrl(int day) async {
    try {
      String videoUrl = await firebase_storage.FirebaseStorage.instance
          .ref('Gratitude thought/GRATITUTE_THOUGHT/${day + 45}.mp4')
          .getDownloadURL();

      // ignore: deprecated_member_use
      _controller = VideoPlayerController.network(videoUrl);
      initializeVideoPlayerFuture = _controller.initialize();

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

      _controller.play();
    } catch (error) {
      // ignore: avoid_print
      print('Error fetching video URL: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Player Demo',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pop(const CardView());
            },
          ),
          title: const Text(
            'Affirmation',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 0, 111, 186),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 111, 186),
        resizeToAvoidBottomInset: true,
        // ignore: deprecated_member_use
        body: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50.0),
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
                            future: initializeVideoPlayerFuture,
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
                    const SizedBox(height: 20.0),
                    FloatingActionButton(
                      onPressed: () {
                        setState(
                          () {
                            if (_controller.value.isPlaying) {
                              _controller.pause();
                            } else {
                              _controller.play();
                            }
                          },
                        );
                      },
                      backgroundColor: Colors.yellow,
                      child: Icon(
                        _controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                      ),
                    ),
                    const SizedBox(height: 20.0),
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
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            labelText: 'Write an affirmation for yourself.',
                            labelStyle: TextStyle(color: Colors.black),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.greenAccent),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.yellow),
                            ),
                          ),
                          maxLines: 3,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CardView()));
                        },
                        child: Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const CardView(),
                                  ),
                                );
                              },
                              style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(
                                  const Size(
                                    200,
                                    50,
                                  ),
                                ),
                              ),
                              child: const Text(
                                'Activity Done',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
