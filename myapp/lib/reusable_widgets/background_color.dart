import 'package:flutter/material.dart';

class BackgroundColor {
  static Widget fromColors({
    required Widget child,
    required Color color1,
    required Color color2,
    double opacity = 1.0,
  }) {
    return Scaffold(
      body: Container(
        color: _mixColors(color1, color2, opacity),
        child: child,
      ),
    );
  }

  static Color _mixColors(Color color1, Color color2, double opacity) {
    return Color.fromRGBO(
      ((color1.red + color2.red) ~/ 2), // Average of red components
      ((color1.green + color2.green) ~/ 2), // Average of green components
      ((color1.blue + color2.blue) ~/ 2), // Average of blue components
      opacity.clamp(0.0, 1.0), // Clamping opacity between 0 and 1
    );
  }
}

// Example of how to use:
// BackgroundColor.fromColors(
//   child: YourWidget(),
//   color1: Colors.white,
//   color2: Colors.blue,
//   opacity: 0.7,
// )
