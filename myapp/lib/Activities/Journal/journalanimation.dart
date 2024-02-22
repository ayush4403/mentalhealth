import 'package:flutter/material.dart';
import 'package:MindFulMe/Activities/Journal/journal.dart';

class BookAnimationScreen extends StatefulWidget {
  @override
  _BookAnimationScreenState createState() => _BookAnimationScreenState();
}

class _BookAnimationScreenState extends State<BookAnimationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5), // Adjust duration as needed
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.forward().whenComplete(() {
      // Navigate to another screen when animation is completed
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NextScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Animation'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.scale(
              scale: _animation.value, // Scale animation
              child: Image.asset(
                  'assets/book.png'), // Replace with your book image
            );
          },
        ),
      ),
    );
  }
}

class NextScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: JournalScreen());
  }
}
