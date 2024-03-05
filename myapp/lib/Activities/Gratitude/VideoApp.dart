// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:MindFulMe/Activities/cardview.dart';
import 'package:scratcher/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:async';

class VideoApp extends StatefulWidget {
  const VideoApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;
  late Future<void> initializeVideoPlayerFuture;
  late int currentDay;
  bool isVideoPlaying = false;
  bool isVideoScratched = false;
  TextEditingController gratitudeController = TextEditingController();
  final User? user = FirebaseAuth.instance.currentUser;
  // Add a variable to track whether the user has completed the activity
  bool activityCompleted = false;

  // Add a variable to track the time when the activity is completed
  late DateTime activityCompletionTime;

  // Timer to check if 24 hours have passed
  // ignore: unused_field
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    currentDay = DateTime.now().day;
    _controller =
        // ignore: deprecated_member_use
        VideoPlayerController.network(""); //
    _initializeVideoPlayer();
    fetchVideoUrl(currentDay);
    checkActivityCompletionStatus();
  }

  void checkActivityCompletionStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? activityStatus = prefs.getBool('activityCompleted');
    String? completionTimeString = prefs.getString('completionTime');
    DateTime? completionTime;

    if (activityStatus != null && completionTimeString != null) {
      completionTime = DateTime.parse(completionTimeString);
      DateTime todayAtMidnight = DateTime.now().subtract(Duration(
          hours: DateTime.now().hour,
          minutes: DateTime.now().minute,
          seconds: DateTime.now().second,
          milliseconds: DateTime.now().millisecond,
          microseconds: DateTime.now().microsecond));
      // Check if the completion time was before today at 12 AM
      if (completionTime.isBefore(todayAtMidnight)) {
        setState(() {
          activityCompleted = false;
        });
      } else {
        // If not, calculate the difference in time
        Duration difference = DateTime.now().difference(completionTime);
        if (difference.inHours < 24) {
          // If less than 24 hours have passed since the last completion, prevent the user from accessing the page
          setState(() {
            activityCompleted = true;
            activityCompletionTime = completionTime!;
          });
          // Start a timer to re-enable access after
          startTimer(24 - difference.inHours);
        }
      }
    }
  }

// Start a timer to re-enable access after a specified number of hours
  void startTimer(int remainingHours) {
    _timer = Timer(Duration(hours: remainingHours), () {
      setState(() {
        activityCompleted = false;
      });
    });
  }

  // Method to handle saving activity completion status
  Future<void> saveActivityCompletionStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('activityCompleted', true);
    prefs.setString('completionTime', DateTime.now().toString());
  }

  Future<void> saveUserActivity(
      String userId, String activityType, String inputText) async {
    final DateTime now = DateTime.now();
    final String formattedDate = '${now.year}-${now.month}-${now.day}';

    await FirebaseFirestore.instance
        .collection('Users')
        .doc(user
            ?.uid) // Use null-aware operator '?.' to access user's properties safely
        .collection('User_activities')
        .doc('Gratitude')
        .set({
      'userId': userId,
      'activityType': activityType,
      'activityDate': formattedDate,
      'inputText': inputText,
    });
  }

  Future<void> _initializeVideoPlayer() async {
    initializeVideoPlayerFuture = _controller.initialize();
    await initializeVideoPlayerFuture;
    setState(() {}); // Update the UI after initialization
  }

  Future<void> fetchVideoUrl(int day) async {
    try {
      String videoUrl = await firebase_storage.FirebaseStorage.instance
          .ref('Gratitude thought/GRATITUTE_THOUGHT/$day.mp4')
          .getDownloadURL();

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

      // Do not auto-play the video initially
      // _controller.play();
    } catch (error) {
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
            'Gratitude',
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
                    Scratcher(
                      brushSize: 50,
                      threshold: 50,
                      color: Colors.blue, // Adjust color as needed
                      onChange: (value) => print("Scratch progress: $value%"),
                      onThreshold: () {
                        print("Threshold reached!");
                        setState(() {
                          isVideoScratched = true;
                        });
                        _controller.play(); // Start playing the video
                      },
                      child: Container(
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
                    ),
                    const SizedBox(height: 50.0),
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
                            labelText: 'What are you grateful for today?',
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
                        onTap: () async {
                          if (gratitudeController.text.isNotEmpty) {
                            saveUserActivity(user!.uid, 'gratitude',
                                gratitudeController.text);
                            await saveActivityCompletionStatus();
                            // ignore: use_build_context_synchronously
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const CardView()));
                          } else {
                            // ignore: avoid_print
                            print('Your text is empty');
                          }
                        },
                        child: Container(
                          width: 250,
                          height: 60,
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.greenAccent,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: const Column(
                            children: [
                              Text(
                                'Activity Done',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
