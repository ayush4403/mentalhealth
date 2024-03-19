// ignore_for_file: file_names
import 'package:MindFulMe/Activities/cardview.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lottie/lottie.dart';

class AudioCard1 extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String audioFileName;
  final bool showProgressBar;
  final bool showPlaybackControlButton;
  final bool showTimerSelector;
  final bool imageshow;
  final bool timerSelectorfordisplay;

  // ignore: use_super_parameters
  const AudioCard1({
    required this.imageUrl,
    required this.title,
    required this.audioFileName,
    this.showProgressBar = true,
    this.showPlaybackControlButton = true,
    this.showTimerSelector = true,
    this.imageshow = true,
    this.timerSelectorfordisplay = true,
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AudioCard1State createState() => _AudioCard1State();
}

class _AudioCard1State extends State<AudioCard1> {
  final _player = AudioPlayer();
  double selectedDuration = 0.0;
  bool timerSelectorforexample = false;

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    _setupAudioPlayer();
  }

  @override
  void didUpdateWidget(AudioCard1 oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.audioFileName != widget.audioFileName) {
      _updateAudioSource(widget.audioFileName);
    }
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

  Widget _example() {
    Size size = MediaQuery.of(context).size;
    // Add a variable to control visibility

    return SingleChildScrollView(
      child: SafeArea(
        child: Container(
          height: size.height * 0.86,
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
                      image: new AssetImage(widget.imageUrl),
                    ),
                  ),
                ),
              ),
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
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: _playbackControlButton(),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _customButton(
                      "Brain Entrainment", _onBrainEntrainmentPressed),
                  _customButton("Guided", _onGuidedPressed),
                  _customButton("Visualize", _onVisualizePressed),
                ],
              ),
              const SizedBox(height: 20),
              _volumeControlButton(),

              _doneButton(),
              
            ],
          ),
        ),
      ),
    );
  }

  void _openAnimatedDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return Container();
      },
      transitionBuilder: (context, a1, a2, widget) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.5, end: 1).animate(a1),
          child: AlertDialog(
            backgroundColor: Colors.transparent,
            content: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 100, // Adjust height as needed
                        color: Colors.red, // Upper part background color
                      ),
                      SizedBox(
                        height:
                            2, // Adjust the thickness of the horizontal line
                        child: Container(
                          color: Colors.grey, // Color of the horizontal line
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            const Text(
                              'Great Job!',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'You have successfully completed today\'s activity. You have earned 50 coins for it. Come back tomorrow for more.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context); // Close the dialog box
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors
                                    .blue, // Change button color if needed
                              ),
                              child: const Text(
                                'OK',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 40, // Adjust positioning as needed
                    left: MediaQuery.of(context).size.width / 2 - 125,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white, // Circular background color
                        border: Border.all(
                          color: Colors.black, // Border color
                          width: 2, // Adjust the border width as needed
                        ),
                      ),
                      child: Lottie.asset(
                        'assets/GIF/ShowDialog/trophy.json',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _customButton(String label, Function() onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }

  Widget _doneButton() {
    return GestureDetector(
      onTap: () {
        _openAnimatedDialog(context); // Show the dialog
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const CardView()), // Navigate to CardView.dart
        );
      },
      child: ElevatedButton(
        onPressed: () {
          // Handle "Done" button tap
        },
        child: const Text("Done"),
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

  Widget _volumeControlButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.volume_down),
          onPressed: () {
            setState(() {
              _player.setVolume((_player.volume - 0.1)
                  .clamp(0.0, 1.0)); // Decrease volume by 0.1
            });
          },
        ),
        Expanded(
          child: Slider(
            value: _player.volume, // Use player's volume as the initial value
            min: 0.0,
            max: 1.0,
            onChanged: (value) {
              setState(() {
                _player.setVolume(value); // Set volume based on slider value
              });
            },
          ),
        ),
        IconButton(
          icon: const Icon(Icons.volume_up),
          onPressed: () {
            setState(() {
              _player.setVolume((_player.volume + 0.1)
                  .clamp(0.0, 1.0)); // Increase volume by 0.1
            });
          },
        ),
      ],
    );
  }

  void _onBrainEntrainmentPressed() {
    // Handle "Brain Entrainment" button tap
  }

  void _onGuidedPressed() {
    // Handle "Guided" button tap
  }

  void _onVisualizePressed() {
    // Handle "Visualize" button tap
  }

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
      width: MediaQuery.of(context).size.width,
      // ignore: avoid_unnecessary_containers

      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Placeholder for the image
            _example(),
          ],
        ),
      ),
    );
  }
}
