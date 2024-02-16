import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:myapp/Activities/quotes/audiocard.dart';
import 'package:video_player/video_player.dart';

class VisualizeScreen extends StatefulWidget {
  final String title;
  final String imageUrl;
  final String audioUrl;
  final VoidCallback? onAudioPlay;

  VisualizeScreen(
      {required this.title,
      required this.imageUrl,
      required this.audioUrl,
      this.onAudioPlay});

  @override
  _VisualizeScreenState createState() => _VisualizeScreenState();
}

class _VisualizeScreenState extends State<VisualizeScreen> {
  late VideoPlayerController _videoController;
  final _audioPlayer = AudioPlayer();
  bool _audioPlaying = false;
  bool _cardVisible = true;

  @override
  void initState() {
    super.initState();

    _initializeAudio();
  }

  void _initializeAudio() async {
    try {
      final audioUrl = await getAudioUrl(widget.audioUrl);
      await _audioPlayer.setUrl(audioUrl);
      _audioPlayer.playerStateStream.listen((state) {
        if (state.playing) {
          setState(() {
            _audioPlaying = true;
          });
          widget.onAudioPlay?.call(); // Call the callback here
        } else {
          setState(() {
            _audioPlaying = false;
          });
        }
      });
    } catch (e) {
      print("Error initializing audio: $e");
    }
  }

  Future<String> getAudioUrl(String audioFileName) async {
    // Fetch audio URL from Firebase Storage or any other source
    return 'your_audio_url_here';
  }

  void _handleAudioPlay() {
    // Trigger animation here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          // Background GIF
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: Lottie.asset('assets/GIF/Features/getStarted.json'),
            ),
          ),
          // Audio Player Container
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            bottom:
                _audioPlaying ? MediaQuery.of(context).size.height * 0.2 : 0,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _cardVisible = !_cardVisible;
                });
              },
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 500),
                opacity: _cardVisible ? 1.0 : 0.0,
                child: AudioCardVisualize(
                  imageUrl: widget.imageUrl,
                  title: widget.title,
                  audioFileName: widget.audioUrl,
                  imageshow: false,
                  showTimerSelector: false,
                  onAudioPlay: _handleAudioPlay,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();
    _audioPlayer.dispose();
  }
}
