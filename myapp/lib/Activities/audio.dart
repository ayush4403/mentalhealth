import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:async';
enum AudioSourceOption { Network, Asset }

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _player = AudioPlayer();
  double selectedSpeed = 1.0;
  double selectedVolume = 1.0;
  double selectedDuration = 0.0;
  late Timer _durationTimer;
  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    _setupAudioPlayer(AudioSourceOption.Network);
  }
  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _durationTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Audio Player"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 25.0,
          ),
          child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  _sourceSelect(),
                  _progessBar(),
                  _controlButtons(),
                  _playbackControlButton(),
                  _timerSelector(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _setupAudioPlayer(AudioSourceOption option) async {
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stacktrace) {
          print("A stream error occurred: $e");
        });
    try {
      if (option == AudioSourceOption.Network) {
        await _player.setAudioSource(AudioSource.uri(Uri.parse(
            "https://orangefreesounds.com/wp-content/uploads/2023/10/Calm-sea-sound-effect.mp3")));
      } else if (option == AudioSourceOption.Asset) {
        await _player.setAudioSource(
            AudioSource.asset("assets/audio/song3.mp3"));
      }
    } catch (e) {
      print("Error loading audio source: $e");
    }
  }

  Widget _sourceSelect() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      MaterialButton(
        color: Colors.purple,
        child: Text("Network"),
        onPressed: () => _setupAudioPlayer(AudioSourceOption.Network),
      ),
      MaterialButton(
        color: Colors.purple,
        child: Text("Asset"),
        onPressed: () => _setupAudioPlayer(AudioSourceOption.Asset),
      ),
    ]);
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
            width: 64,
            height: 64,
            child: const CircularProgressIndicator(),
          );
        } else if (playing != true) {
          return IconButton(
            icon: const Icon(Icons.play_arrow),
            iconSize: 64,
            onPressed: _player.play,
          );
        } else if (processingState != ProcessingState.completed) {
          return IconButton(
            icon: const Icon(Icons.pause),
            iconSize: 64,
            onPressed: _player.pause,
          );
        } else {
          return IconButton(
            icon: const Icon(Icons.replay),
            iconSize: 64,
            onPressed: () => _player.seek(Duration.zero),
          );
        }
      },
    );
  }

  Widget _controlButtons() {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      StreamBuilder(
        stream: _player.speedStream,
        builder: (context, snapshot) {
          return Row(children: [
            const Icon(
              Icons.speed,
            ),
            Slider(
              min: 1,
              max: 3,
              value: selectedSpeed,
              divisions: 3,
              onChanged: (value) {
                setState(() {
                  selectedSpeed = value;
                });
                _player.setSpeed(value);
              },
            )
          ]);
        },
      ),
      StreamBuilder(
        stream: _player.volumeStream,
        builder: (context, snapshot) {
          return Row(children: [
            const Icon(
              Icons.volume_up,
            ),
            Slider(
              min: 0,
              max: 3,
              value: selectedVolume,
              divisions: 4,
              onChanged: (value) {
                setState(() {
                  selectedVolume = value;
                });
                _player.setVolume(value);
              },
            )
          ]);
        },
      ),
    ]);
  }

  // ... (previous code)
  Widget _timerSelector() {
    return Row(
      children: [
        const Icon(Icons.timer),
        SizedBox(width: 10),
        DropdownButton<double>(
          value: selectedDuration,
          items: [
            DropdownMenuItem(
              value: 0.0,
              child: Text("No Limit"),
            ),
            DropdownMenuItem(
              value: 60.0,
              child: Text("1 Minute"),
            ),
            DropdownMenuItem(
              value: 120.0,
              child: Text("2 Minutes"),
            ),
            DropdownMenuItem(
              value: 180.0,
              child: Text("3 Minutes"),
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
                    selectedDuration = 0.0; // Reset selectedDuration after audio stops
                  });
                }
                _player.stop(); // Stop the music when the desired duration is reached
              });
            }
          },
        ),
      ],
    );
  }



}
