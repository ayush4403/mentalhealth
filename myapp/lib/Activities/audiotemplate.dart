import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AudioCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String audioFileName;

  const AudioCard({
    required this.imageUrl,
    required this.title,
    required this.audioFileName,
    Key? key,
  }) : super(key: key);

  @override
  _AudioCardState createState() => _AudioCardState();
}

class _AudioCardState extends State<AudioCard> {
  final _player = AudioPlayer();
  double selectedDuration = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    _setupAudioPlayer();
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
    String audioUrl = await getAudioUrl(widget.audioFileName);
    try {
      await _player.setAudioSource(AudioSource.uri(Uri.parse(audioUrl)));
    } catch (e) {
      print("Error loading audio source: $e");
    }
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

  Widget _timerSelector() {
    return Row(
      children: [
        const Icon(Icons.timer),
        SizedBox(width: 10),
        DropdownButton<double>(
          value: selectedDuration,
          items: const [
            DropdownMenuItem(
              value: 0.0,
              child: Text(
                "No Limit",
                style: TextStyle(color: Colors.white),
              ),
            ),
            DropdownMenuItem(
              value: 60.0,
              child: Text(
                "1 Minute",
                style: TextStyle(color: Colors.white),
              ),
            ),
            DropdownMenuItem(
              value: 120.0,
              child: Text(
                "2 Minutes",
                style: TextStyle(color: Colors.white),
              ),
            ),
            DropdownMenuItem(
              value: 180.0,
              child: Text(
                "3 Minutes",
                style: TextStyle(color: Colors.white),
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
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.99,
      height:
          MediaQuery.of(context).size.height * 0.3, // Fixed width for the card
      child: Card(
        elevation: 9,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  widget.imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    _progessBar(),
                    _playbackControlButton(),
                    _timerSelector()
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
