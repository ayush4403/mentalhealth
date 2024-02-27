import 'dart:math';

import 'package:flutter/material.dart';

class RoadMap extends StatelessWidget {
  final int unlockedLevels = 3; // Number of levels initially unlocked

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Road Map Levels'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    CustomPaint(
                      size: Size(constraints.maxWidth, constraints.maxHeight),
                      painter: RoadPainter(),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 60,
                          height: constraints.maxHeight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(
                              10,
                              (index) {
                                return GestureDetector(
                                  onTap: () {
                                    if (index < unlockedLevels) {
                                      // Navigate to the selected level
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              LevelScreen(index + 1),
                                        ),
                                      );
                                    } else {
                                      // Show a message indicating the level is locked
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'Level ${index + 1} is locked!'),
                                        ),
                                      );
                                    }
                                  },
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: index < unlockedLevels
                                          ? Colors.green
                                          : Colors.grey[300],
                                    ),
                                    child: Center(
                                      child: Text(
                                        (index + 1).toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class RoadPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[500]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    final path = Path();

    final double unitWidth = size.width / 10;
    final double unitHeight = size.height / 10;

    // Start the path at the bottom center of the canvas
    path.moveTo(unitWidth * 5, size.height);

    // Draw the road with less curvy segments
    for (var i = 0; i < 10; i++) {
      final double startX = unitWidth * (i.isEven ? 9 : 1);
      final double startY = size.height - unitHeight * (i + 1);
      final double endX = unitWidth * (i.isEven ? 9 : 1);
      final double endY = size.height - unitHeight * i;
      final double controlX = unitWidth * (i.isEven ? 9.2 : 0.8);
      final double controlY = (startY + endY) / 2;

      path.quadraticBezierTo(controlX, controlY, endX, endY);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class LevelScreen extends StatelessWidget {
  final int levelNumber;

  LevelScreen(this.levelNumber);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Level $levelNumber'),
      ),
      body: Center(
        child: Text(
          'Welcome to Level $levelNumber!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: RoadMap()));
}
