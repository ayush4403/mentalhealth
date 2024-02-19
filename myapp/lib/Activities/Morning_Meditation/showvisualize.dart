import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:myapp/Activities/quotes/audiocard.dart';
import 'package:video_player/video_player.dart';

class VisualizeScreen extends StatefulWidget {
  final String title;
  final String imageUrl;
  final String audioUrl;
  final String gifurl;
  final VoidCallback? onAudioPlay;

  VisualizeScreen(
      {required this.title,
      required this.imageUrl,
      required this.audioUrl,
      required this.gifurl,
      this.onAudioPlay});

  @override
  _VisualizeScreenState createState() => _VisualizeScreenState();
}

class _VisualizeScreenState extends State<VisualizeScreen> {
  late VideoPlayerController _videoController;
  final _audioPlayer = AudioPlayer();
  // ignore: unused_field
  bool _audioPlaying = false;
  // ignore: unused_field
  bool _cardVisible = true;

  @override
  void initState() {
    super.initState();

    _initializeAudio();
    print("heeloo" + widget.gifurl);
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
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        // Background GIF

        Lottie.asset(widget.gifurl,
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.1),

        // ignore: avoid_print
        SizedBox(
          height: 30,
        ),
        AudioCardVisualize(
          imageUrl: widget.imageUrl,
          title: widget.title,
          audioFileName: widget.audioUrl,
          imageshow: false,
          showTimerSelector: false,
          onAudioPlay: _handleAudioPlay,
        ),
      ]),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();
    _audioPlayer.dispose();
  }
}
