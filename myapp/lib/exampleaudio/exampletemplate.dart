import 'dart:async';

import 'package:MindFulMe/exampleaudio/recommendation_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({
    super.key,
    required this.model,
    required this.audiourl,
    required this.name,
  });

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();

  final RecommendationModel model;
  final String audiourl;
  final String name;
}

class _PlayerScreenState extends State<PlayerScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progress;

  final ValueNotifier<double> _player = ValueNotifier<double>(0);
  bool _isDark = false;

  final _player1 = AudioPlayer();
  double selectedDuration = 0.0;
  bool timerSelectorforexample = false;
  bool isSessionActive = false;
  late Timer _sessionTimer;
  late final AudioPlayer _audioPlayer;
  int _sessionDurationInSeconds = 0;

  late int indexweek = 1;
  late int indexday = 1;

  final List<int> _sessionData = List.filled(7, 0);

  controllerListener() {
    if (_controller.status == AnimationStatus.forward ||
        _controller.status == AnimationStatus.completed) {
      increasePlayer();
    }
  }

  increasePlayer() async {
    if (_controller.status == AnimationStatus.forward ||
        _controller.status == AnimationStatus.completed) {
      if ((_player.value + .0005) > 1) {
        _player.value = 1;
        _controller.reverse();
      } else {
        _player.value += .00005;
      }

      await Future.delayed(
        const Duration(milliseconds: 100),
      );
      if (_player.value < 1) {
        increasePlayer();
      }
    }
  }

  Future<void> _loadAudio(Future<String> audioUrlFuture) async {
    try {
      String audioUrl = await audioUrlFuture;
      await _audioPlayer.setUrl(audioUrl);
    } catch (e) {
      print('Error loading audio: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _loadAudio(getAudioUrl(widget.audiourl));
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _progress = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.addListener(() {
      controllerListener();
    });

    _audioPlayer.positionStream.listen((position) {
      // Update the slider and animation controller based on audio playback position
      if (_audioPlayer.duration != null) {
        double progressValue =
            position.inMilliseconds / _audioPlayer.duration!.inMilliseconds;
        _player.value = progressValue;
        _controller.value = progressValue;

        if (_player.value >= 1) {
          _controller.stop();
          _player.value = 0;
        }
      }
    });

    _fetchdata();
  }

  Future<void> _fetchdata() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final userDoc = FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .collection('MeditationDataforday')
        .doc('currentweekandday');
    DocumentSnapshot<Map<String, dynamic>> docSnapshot = await userDoc.get();
    if (docSnapshot.exists) {
      int currentDay = docSnapshot.get('currentday');
      int currentWeek = docSnapshot.get('currentweek');
      int currentdaylatest = DateTime.now().day;
      int lastUpdatedDay = docSnapshot.get('lastupdatedday');
      if (currentdaylatest - lastUpdatedDay == 0) {
        setState(() {
          indexday = currentDay;
          indexweek = currentWeek;
        });
        _updateCurrentDayAndWeekIndex(indexday, indexweek, currentdaylatest);
      } else {
        // Calculate the missing days and add them with a value of 0
        int missingDays = currentdaylatest - lastUpdatedDay;
        for (int i = 1; i < missingDays; i++) {
          int missingDayIndex = currentDay + i;
          await _addMissingDay(user.uid, missingDayIndex, currentWeek);
        }
        setState(() {
          indexday = currentDay + missingDays;
          if (indexday % 7 == 1) {
            indexweek = currentWeek + 1;
          } else {
            indexweek = currentWeek;
          }
        });
        _updateCurrentDayAndWeekIndex(indexday, indexweek, currentdaylatest);
      }
      print(
          'Current day and week index updated to: Day $indexday, Week $indexweek');
    } else {
      setState(() {
        indexday = 1;
        indexweek = 1;
      });
      _updateCurrentDayAndWeekIndex(indexday, indexweek, DateTime.now().day);
      print('Document does not exist');
    }
  }

  Future<void> _addMissingDay(
      String userId, int dayIndex, int weekIndex) async {
    try {
      final userDoc = FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('MeditationData')
          .doc('week$weekIndex');
      await userDoc.set({'day$dayIndex': 0}, SetOptions(merge: true));
      print('Added missing day $dayIndex for Week $weekIndex with value 0');
    } catch (e) {
      print('Error adding missing day: $e');
    }
  }

  Future<void> _updateCurrentDayAndWeekIndex(
      int indexday1, int indexweek1, int currentday) async {
    final User? user = FirebaseAuth.instance.currentUser;
    // ignore: unused_local_variable
    String weekPath = 'week$indexweek';

    final userDoc = FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .collection('MeditationDataforday')
        .doc('currentweekandday');
    DocumentSnapshot<Map<String, dynamic>> docSnapshot = await userDoc.get();
    if (docSnapshot.exists) {
      await userDoc.update({
        'currentday': indexday1,
        'currentweek': indexweek1,
        'dayupdated': currentday,
        'lastupdatedday': Timestamp.now().toDate().day
      });
      setState(() {
        indexday = indexday1;
        indexweek = indexweek1;
      });
      // ignore: avoid_print
      print(
          'Current day and week index updated to: Day $indexday, Week $indexweek');
    } else {
      await userDoc.set({
        'currentday': indexday1,
        'currentweek': indexweek1,
        'dayupdated': currentday,
        'lastupdatedday': Timestamp.now().toDate().day
      });
      setState(() {
        indexday = indexday1;
        indexweek = indexweek1;
      });
      // ignore: avoid_print
      print('New document created with day $indexday, Week $indexweek');
    }
  }

  Future<void> _createNewWeekDocument(int timer) async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      String weekPath = 'week$indexweek';

      final userDoc = FirebaseFirestore.instance
          .collection('Users')
          .doc(user!.uid)
          .collection('MeditationData')
          .doc(weekPath);

      // Check if the document exists before updating
      DocumentSnapshot<Map<String, dynamic>> docSnapshot = await userDoc.get();
      if (docSnapshot.exists) {
        await userDoc.set({'day$indexday': timer}, SetOptions(merge: true));
        // ignore: avoid_print
        print('Week document updated with timer data for Day $indexday');
      } else {
        await userDoc.set({'day$indexday': timer});
        // ignore: avoid_print
        print('New week document created with timer data for Day $indexday');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error creating/updating week document: $e');
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

  void _startSessionTimer() {
    _sessionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _sessionDurationInSeconds++;
      });
    });
  }

  void _togglePlayback() {}

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _isDark ? Colors.black : Colors.white,
      child: Scaffold(
        backgroundColor: widget.model.color.withOpacity(.1),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 70),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    highlightColor: widget.model.color.withOpacity(.2),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.keyboard_backspace_rounded,
                      color: widget.model.color.shade300,
                    ),
                  ),
                  IconButton(
                    highlightColor: widget.model.color.withOpacity(.2),
                    onPressed: () {
                      setState(() {
                        _isDark = !_isDark;
                      });
                    },
                    icon: Icon(
                      _isDark
                          ? CupertinoIcons.sun_max_fill
                          : CupertinoIcons.moon_stars_fill,
                      color: widget.model.color.shade300,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              SizedBox.square(
                dimension: MediaQuery.sizeOf(context).width - 40,
                child: Stack(
                  children: [
                    Positioned.fill(
                      left: 30,
                      top: 30,
                      bottom: 30,
                      right: 30,
                      child: ValueListenableBuilder(
                          valueListenable: _player,
                          builder: (context, value, _) {
                            return CircularProgressIndicator(
                              color: widget.model.color.shade300,
                              value: value,
                              strokeCap: StrokeCap.round,
                              strokeWidth: 10,
                              backgroundColor:
                                  widget.model.color.withOpacity(.1),
                            );
                          }),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(1000),
                        child: Container(
                          padding: const EdgeInsets.only(top: 120, left: 20),
                          height: 200,
                          width: 200,
                          color: widget.model.color.shade300,
                          child: Transform.scale(
                            scale: 3,
                            child: Lottie.asset('assets/lottie/yoga.json'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                widget.name,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: widget.model.color.shade300,
                ),
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  const Spacer(),
                  const SizedBox(width: 30),
                  IconButton(
                    highlightColor: widget.model.color.withOpacity(.2),
                    onPressed: () {
                      if (_audioPlayer.playing) {
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
                                    _createNewWeekDocument(
                                        _sessionDurationInSeconds);

                                    setState(() {
                                      isSessionActive = false;
                                      _audioPlayer.pause();
                                      _audioPlayer.seek(Duration.zero);

                                      _player.value = 0;
                                      _stopSessionTimer();
                                    });
                                  },
                                  child: const Text("Yes"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                  child: const Text("No"),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
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
                                    Navigator.of(context).pop();
                                    setState(() {
                                      isSessionActive = true;

                                      _audioPlayer.play();
                                      _startSessionTimer();
                                      // Increment the day index
                                    });
                                    //
                                  },
                                  child: const Text("Yes"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                  child: const Text("No"),
                                ),
                              ],
                            );
                          },
                        );
                      }
                      if (_controller.status == AnimationStatus.completed) {
                        _controller.reverse();
                      } else {
                        _controller.forward();

                        // _togglePlayback();
                      }
                    },
                    icon: AnimatedIcon(
                      icon: AnimatedIcons.play_pause,
                      progress: _progress,
                      size: 50,
                      color: widget.model.color.shade300,
                    ),
                  ),
                  const SizedBox(width: 30),
                  const Spacer(),
                ],
              ),
              ValueListenableBuilder(
                valueListenable: _player,
                builder: (context, value, newvalue) {
                  return Slider(
                    thumbColor: widget.model.color.shade300,
                    activeColor: widget.model.color.shade300,
                    inactiveColor: widget.model.color.withOpacity(.4),
                    secondaryActiveColor: widget.model.color.withOpacity(.4),
                    secondaryTrackValue: .8,
                    value: value,
                    onChanged: (newValue) {
                      //
                      int newPositionInMilliseconds =
                          (_audioPlayer.duration!.inSeconds * newValue).toInt();
                      _audioPlayer
                          .seek(Duration(seconds: newPositionInMilliseconds));
                      // Update the player value based on the slider's value
                      _player.value = newValue;
                      _controller.value = newValue;
                    },
                  );
                },
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  widget.model.slogan,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: widget.model.color.shade300,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
