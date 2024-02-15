import 'package:flutter/material.dart';
import 'package:myapp/Activities/quotes/audiocard.dart';
import 'package:video_player/video_player.dart';

class VisualizeScreen extends StatefulWidget {
  final String title;
  final String imageUrl;
  final String audioUrl;

  VisualizeScreen({
    required this.title,
    required this.imageUrl,
    required this.audioUrl,
  });

  @override
  _VisualizeScreenState createState() => _VisualizeScreenState();
}

class _VisualizeScreenState extends State<VisualizeScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/Video/video1.mp4')
      ..initialize().then((_) {
        _controller.play();
        _controller.setLooping(true);
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.3),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      0,
                      MediaQuery.of(context).size.height * 0.63,
                      0,
                      0,
                    ),
                    child: AudioCardVisualize(
                      imageUrl: widget.imageUrl,
                      title: widget.title,
                      audioFileName: widget.audioUrl,
                      imageshow: false,
                      showTimerSelector: false,
                    ),
                  ),
                ],
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
    _controller.dispose();
  }
}
