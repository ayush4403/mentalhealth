import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AudioCardState createState() => _AudioCardState();
}

class _AudioCardState extends State<AudioCard> {
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
  void didUpdateWidget(AudioCard oldWidget) {
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
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                        "PLAYING NOW",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 12, 12, 12)),
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          if (widget.timerSelectorfordisplay)
                            DropdownButton<double>(
                              value: selectedDuration,
                              icon: Icon(
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
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  padding: EdgeInsets.all(7),
                  width: 280,
                  height: 280,
                  decoration: BoxDecoration(
                      color: Color(0xffE5F1FD),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xff97A4B7),
                            offset: new Offset(8.0, 10.0),
                            blurRadius: 25.0)
                      ]),
                  child: Container(
                      decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                              fit: BoxFit.cover,
                              image: new AssetImage(widget.imageUrl))))),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 8.0),
                child: Text(
                  widget.title,
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 12, 12, 12)),
                ),
              ),
              Text(
                widget.title,
                style: TextStyle(
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
        Icon(
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
    print('Audio file name: ${widget.audioFileName}');
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
                  offset: Offset(130, -50),
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(10)),
                    child: Image.asset(
                      widget.imageUrl,
                      width: 120,
                      height: 120,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
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
