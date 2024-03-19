import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AudioCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String audioFileName;
  final bool showProgressBar;
  final bool showPlaybackControlButton;
  final bool showTimerSelector;
  final bool imageshow;
  final bool timerSelectorfordisplay;

  const AudioCard({
    required this.imageUrl,
    required this.title,
    required this.audioFileName,
    this.showProgressBar = true,
    this.showPlaybackControlButton = true,
    this.showTimerSelector = true,
    this.imageshow = true,
    this.timerSelectorfordisplay = true,
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _AudioCardState createState() => _AudioCardState();
}

class _AudioCardState extends State<AudioCard> {
  final _player = AudioPlayer();
  double selectedDuration = 0.0;
  bool timerSelectorforexample = false;
  bool isSessionActive = false;
  late Timer _sessionTimer;
  int _sessionDurationInSeconds = 0;
   int indexweek=1;
  int indexday=1;
  final List<int> _sessionData = List.filled(7, 0);
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    _setupAudioPlayer();
    _setupSharedPreferences();

    // Get the current time
    DateTime now = DateTime.now();
    // Calculate the time until the next midnight
    DateTime nextMidnight =
        DateTime(now.year, now.month, now.day, now.hour, now.minute + 3);
    Duration durationUntilMidnight = nextMidnight.difference(now);

    _createNewWeekDocument(indexday);
    // Set a timer to run at the next midnight
    Timer(durationUntilMidnight, () {
      setState(() {
        indexday++;
        if (indexday > 7) {
          indexday = 1;
          indexweek++;
          _updateIndexDay(indexday);
          _updateIndexWeek(indexweek);
          _createNewWeekDocument(indexday);
        }
      });
    });
  }

  Future<void> _createNewWeekDocument(int day) async {
    final User? user = FirebaseAuth.instance.currentUser;
    String weekPath = 'week$indexweek';

    final userDoc = FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .collection('MeditationData')
        .doc(weekPath);

    // Create a new week document with the specified day
    await userDoc.set({'day$day': 0}, SetOptions(merge: true));
  }

  Future<void> _updateMeditationData(int day, int durationInSeconds) async {
    final User? user = FirebaseAuth.instance.currentUser;
    String weekPath = 'week$indexweek';

    final userDoc = FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .collection('MeditationData')
        .doc(weekPath);

    // Update the specified day with the duration
    await userDoc.update({'day$day': durationInSeconds});
  }

  Future<void> _setupSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    int savedIndexDay = _prefs.getInt('indexday') ?? 1;
    int savedIndexWeek = _prefs.getInt('indexweek') ?? 1; // Default value is 1
    setState(() {
      indexday = savedIndexDay;
      indexweek = savedIndexWeek;
    });
  }

  Future<void> _saveIndexDay(int day) async {
    await _prefs.setInt('indexday', day);
  }

  // Update the indexday value and save it in SharedPreferences
  void _updateIndexDay(int day) {
    setState(() {
      indexday = day;
    });
    _saveIndexDay(day);
  }

  void _updateIndexWeek(int week) {
    setState(() {
      indexweek = week;
    });
    _saveIndexWeek(week);
  }

  @override
  void didUpdateWidget(AudioCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.audioFileName != widget.audioFileName) {
      _updateAudioSource(widget.audioFileName);
    }
  }

  Future<void> _saveIndexWeek(int week) async {
    await _prefs.setInt('indexweek', week);
  }

  Future<void> _updateAudioSource(String audioFileName) async {
    try {
      final audioUrl = await getAudioUrl(audioFileName);
      await _player.setAudioSource(AudioSource.uri(Uri.parse(audioUrl)));
    } catch (e) {
      // ignore: avoid_print
      print("Error loading audio source: $e");
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  void _stopSessionTimer() {
    _sessionTimer.cancel();

    _sessionDurationInSeconds = 0;
  }

  Future<String> getAudioUrl(String audioFileName) async {
    try {
      Reference audioRef = FirebaseStorage.instance.ref().child(audioFileName);
      return await audioRef.getDownloadURL();
    } catch (e) {
      // ignore: avoid_print
      print("Error getting audio URL: $e");
      return '';
    }
  }

  Future<void> _setupAudioPlayer() async {
    await _updateAudioSource(widget.audioFileName);
  }

  void _startSessionTimer() {
    _sessionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _sessionDurationInSeconds++;
      });
    });
  }

  Widget _example() {
    Size size = MediaQuery.of(context).size;
    // Add a variable to control visibility

    return SingleChildScrollView(
      child: SafeArea(
        child: Container(
          height: size.height * 0.8,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xffDFEAFE), Color(0xffECF5FC)]),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                        "PLAYING NOW",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 12, 12, 12)),
                      ),
                    ),
                    // ignore: avoid_unnecessary_containers
                    Container(
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          if (widget.timerSelectorfordisplay)
                            DropdownButton<double>(
                              value: selectedDuration,
                              icon: const Icon(
                                Icons.menu,
                                size: 18.0,
                                color: Color.fromARGB(255, 12, 12, 12),
                              ),
                              items: const [
                                DropdownMenuItem(
                                  value: 0.0,
                                  child: Text(
                                    "Select Timer",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 12, 12, 12),
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 180.0,
                                  child: Text(
                                    "3 Minute",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 240.0,
                                  child: Text(
                                    "4 Minutes",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 300.0,
                                  child: Text(
                                    "5 Minutes",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  selectedDuration = value!;
                                });

                                // Stop the audio when a duration is selected
                                if (value != null && value > 0.0) {
                                  _player.positionStream
                                      .takeWhile((position) =>
                                          position.inSeconds < value)
                                      .last
                                      .then((_) {
                                    // Make sure the widget is still mounted before updating the state
                                    if (mounted) {
                                      setState(() {
                                        selectedDuration =
                                            0.0; // Reset selectedDuration after audio stops
                                      });
                                    }
                                    _player
                                        .stop(); // Stop the music when the desired duration is reached
                                  });
                                }
                              },
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  padding: const EdgeInsets.all(7),
                  width: 280,
                  height: 280,
                  decoration: const BoxDecoration(
                      color: Color(0xffE5F1FD),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xff97A4B7),
                            offset: Offset(8.0, 10.0),
                            blurRadius: 25.0)
                      ]),
                  child: Container(
                      // ignore: unnecessary_new
                      decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          // ignore: unnecessary_new
                          image: new DecorationImage(
                              fit: BoxFit.cover,
                              // ignore: unnecessary_new
                              image: new AssetImage(widget.imageUrl))))),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 8.0),
                child: Text(
                  widget.title,
                  style: const TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 12, 12, 12)),
                ),
              ),
              Text(
                widget.title,
                style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal,
                    color: Color.fromARGB(255, 12, 12, 12)),
              ),
              if (timerSelectorforexample)
                _timerSelector(), // Show the timer selector based on the variable
              Padding(padding: EdgeInsets.zero, child: _progessBar()),
              if (widget.showPlaybackControlButton)
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: _playbackControlButton(),
                ),
              ElevatedButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Confirmation"),
                        content: const Text(
                            "Are you sure you want to start the meditation session?"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () async {
                              Navigator.of(context).pop(); // Close the dialog
                              setState(() {
                                isSessionActive = true;
                                _player.play();
                                _startSessionTimer();
                                // Increment the day index
                              });
                              // Update the user's data in Firestore
                              _updateMeditationData(
                                  indexday, _sessionDurationInSeconds);
                            },
                            child: const Text("Yes"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: const Text("No"),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text('Start Meditation Session'),
              ),

              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Confirmation"),
                        content: const Text(
                            "Are you sure you want to stop the meditation session?"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              // Update the meditation data when stopping the session
                              _updateMeditationData(
                                  indexday, _sessionDurationInSeconds);
                              setState(() {
                                isSessionActive = false;
                                _player.pause();
                                _player.seek(Duration.zero);

                                _stopSessionTimer();
                              });
                            },
                            child: const Text("Yes"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: const Text("No"),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text('Stop Meditation Session'),
              ),

              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _progessBar() {
    return StreamBuilder<Duration?>(
      stream: _player.positionStream,
      builder: (context, snapshot) {
        return ProgressBar(
          progress: snapshot.data ?? Duration.zero,
          buffered: _player.bufferedPosition,
          total: _player.duration ?? Duration.zero,
          onSeek: (duration) {
            _player.seek(duration);
          },
        );
      },
    );
  }

  Widget _playbackControlButton() {
    return StreamBuilder<PlayerState>(
      stream: _player.playerStateStream,
      builder: (context, snapshot) {
        final processingState = snapshot.data?.processingState;
        final playing = snapshot.data?.playing;
        if (processingState == ProcessingState.loading ||
            processingState == ProcessingState.buffering) {
          return Container(
            margin: const EdgeInsets.all(8.0),
            width: 40,
            height: 40,
            child: const CircularProgressIndicator(),
          );
        } else if (playing != true) {
          return IconButton(
            icon: const Icon(Icons.play_arrow),
            iconSize: 40,
            onPressed: _player.play,
          );
        } else if (processingState != ProcessingState.completed) {
          return IconButton(
            icon: const Icon(Icons.pause),
            iconSize: 40,
            onPressed: _player.pause,
          );
        } else {
          return IconButton(
            icon: const Icon(Icons.replay),
            iconSize: 40,
            onPressed: () => _player.seek(Duration.zero),
          );
        }
      },
    );
  }

  Widget _timerSelector() {
    return Row(
      children: [
        const Icon(
          Icons.menu,
          size: 18.0,
          color: Color(0xff97A4B7),
        ),
        const SizedBox(width: 10),
        DropdownButton<double>(
          value: selectedDuration,
          items: const [
            DropdownMenuItem(
              value: 0.0,
              child: Text(
                "No Limit",
                style: TextStyle(color: Colors.black),
              ),
            ),
            DropdownMenuItem(
              value: 180.0,
              child: Text(
                "3 Minute",
                style: TextStyle(color: Colors.black),
              ),
            ),
            DropdownMenuItem(
              value: 240.0,
              child: Text(
                "4 Minutes",
                style: TextStyle(color: Colors.black),
              ),
            ),
            DropdownMenuItem(
              value: 300.0,
              child: Text(
                "5 Minutes",
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
              ),
            ),
          ],
          onChanged: (value) {
            setState(() {
              selectedDuration = value!;
            });

            // Stop the audio when a duration is selected
            if (value != null && value > 0.0) {
              _player.positionStream
                  .takeWhile((position) => position.inSeconds < value)
                  .last
                  .then((_) {
                // Make sure the widget is still mounted before updating the state
                if (mounted) {
                  setState(() {
                    selectedDuration =
                        0.0; // Reset selectedDuration after audio stops
                  });
                }
                _player
                    .stop(); // Stop the music when the desired duration is reached
              });
            }
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_print
    print('Audio file name: ${widget.audioFileName}');
    // ignore: sized_box_for_whitespace
    return Container(
      width: MediaQuery.of(context).size.width,
      // ignore: avoid_unnecessary_containers
      child: Container(
        child: Card(
          elevation: 9,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 13),
          child: Stack(
            children: [
              if (widget.imageshow)
                Transform.translate(
                  offset: const Offset(130, -50),
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(10)),
                    child: Image.asset(
                      widget.imageUrl,
                      width: 120,
                      height: 120,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Placeholder for the image
                    _example(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
