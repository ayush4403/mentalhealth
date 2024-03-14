import 'package:flutter/material.dart';

class CountdownAnimation extends StatefulWidget {
  final int duration;
  final Function onFinish;

  const CountdownAnimation({super.key, 
    required this.duration,
    required this.onFinish,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CountdownAnimationState createState() => _CountdownAnimationState();
}

class _CountdownAnimationState extends State<CountdownAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.duration),
    );
    _animation = IntTween(begin: widget.duration, end: 0).animate(_controller)
      ..addListener(() {
        setState(() {
          // Rebuild widget with updated time
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.onFinish();
        }
      });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _animation.value.toString(),
      style: const TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.bold,
        color: Colors.red, // Change color as needed
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
