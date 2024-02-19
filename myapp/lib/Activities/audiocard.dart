import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AudioCardVisualize extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String audioFileName;
  final bool showProgressBar;
  final bool showPlaybackControlButton;
  final bool showTimerSelector;
  final bool imageshow;
  final VoidCallback onAudioPlay; // Add callback function

  const AudioCardVisualize({
    required this.imageUrl,
    required this.title,
    required this.audioFileName,
    this.showProgressBar = true,
    this.showPlaybackControlButton = true,
    this.showTimerSelector = true,
    this.imageshow = true,
    required this.onAudioPlay, // Receive callback function
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AudioCardVisualizeState createState() => _AudioCardVisualizeState();
}

class _AudioCardVisualizeState extends State<AudioCardVisualize> {
  final _player = AudioPlayer();
  double selectedDuration = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    _setupAudioPlayer();
  }

  @override
  void didUpdateWidget(AudioCardVisualize oldWidget) {
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
      print("Error getting audio URL: $e");
      return '';
    }
  }

  Future<void> _setupAudioPlayer() async {
    await _updateAudioSource(widget.audioFileName);
    _player.playerStateStream.listen((state) {
      if (state.playing) {
        widget.onAudioPlay(); // Trigger animation when audio starts playing
      }
    });
  }

  Widget _progessBar() {
    return StreamBuilder<Duration?>(
      stream: _player.positionStream,
      builder: (context, snapshot) {
        return ProgressBar(
          progress: snapshot.data ?? Duration.zero,
          buffered: _player.bufferedPosition,
          total: _player.duration ?? Duration.zero,
          progressBarColor: Colors.red,
          thumbGlowColor: Colors.red,
          baseBarColor: Colors.grey,
          bufferedBarColor: Colors.white,
          thumbColor: Colors.red,
          timeLabelTextStyle: TextStyle(color: Colors.white),
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
            child: const CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        } else if (playing != true) {
          return IconButton(
            icon: const Icon(
              Icons.play_arrow,
              color: Colors.white,
            ),
            iconSize: 40,
            onPressed: _player.play,
          );
        } else if (processingState != ProcessingState.completed) {
          return IconButton(
            icon: const Icon(
              Icons.pause,
              color: Colors.white,
            ),
            iconSize: 40,
            onPressed: _player.pause,
          );
        } else {
          return IconButton(
            icon: const Icon(
              Icons.replay,
              color: Colors.white,
            ),
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
        const Icon(Icons.timer),
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
              value: 60.0,
              child: Text(
                "1 Minute",
                style: TextStyle(color: Colors.black),
              ),
            ),
            DropdownMenuItem(
              value: 120.0,
              child: Text(
                "2 Minutes",
                style: TextStyle(color: Colors.black),
              ),
            ),
            DropdownMenuItem(
              value: 180.0,
              child: Text(
                "3 Minutes",
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
                if (mounted) {
                  setState(() {
                    selectedDuration = 0.0;
                  });
                }
                _player.stop();
              });
            }
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Container(
        child: Card(
          elevation: 9,
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          color: Colors.white.withOpacity(0.9), // Adjust opacity here
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
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10), // Placeholder for the image
                    if (widget.showProgressBar) _progessBar(),
                    if (widget.showPlaybackControlButton)
                      _playbackControlButton(),
                    if (widget.showTimerSelector) _timerSelector(),
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
