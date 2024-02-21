import 'package:flutter/material.dart';

class MindfulnessGame extends StatefulWidget {
  const MindfulnessGame({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MindfulnessGameState createState() => _MindfulnessGameState();
}

class _MindfulnessGameState extends State<MindfulnessGame> {
  int _roundsCompleted = 0;
  bool _isBreathing = false;

  void _startBreathing() {
    setState(() {
      _roundsCompleted = 0;
      _isBreathing = true;
    });
    _breathe();
  }

  void _breathe() async {
    const breathDuration = Duration(seconds: 6);
    const holdDuration = Duration(seconds: 4);

    // Inhale
    await Future.delayed(breathDuration);
    if (!mounted) return;

    // Hold
    await Future.delayed(holdDuration);
    if (!mounted) return;

    // Exhale
    await Future.delayed(breathDuration);
    if (!mounted) return;

    setState(() {
      _roundsCompleted++;
      if (_roundsCompleted < 3) {
        _breathe(); // Repeat for 3 rounds
      } else {
        _isBreathing = false; // Game over
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mindfulness Breathing Exercise'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Rounds Completed: $_roundsCompleted',
              style: const TextStyle(fontSize: 24.0),
            ),
            const SizedBox(
              height: 20.0,
            ),
            _isBreathing
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _startBreathing,
                    child: const Text('Start Breathing'),
                  ),
          ],
        ),
      ),
    );
  }
}
