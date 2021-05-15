import 'dart:math';

import 'package:flutter/material.dart';

class Particle {
  Offset position;
  Offset velocity;
  double size;
  Widget child;

  Particle({
    required this.position,
    this.velocity = const Offset(0.0, 0.0),
    required this.child,
    this.size = 50.0,
  });

  void updatePosition() {
    position = position + velocity;
  }

  void updateVelocities(Offset boundingBox, {var scaleFactor = 0.001}) {
    double xPosOrNeg = 0.0;
    double yPosOrNeg = 0.0;

    if (position.dx < 0) {
      xPosOrNeg = 1.0;
    } else if (position.dx > boundingBox.dx) {
      xPosOrNeg = -1.0;
    } else {
      xPosOrNeg = Random().nextInt(2) == 0 ? -1.0 : 1.0;
    }

    if (position.dy < 0) {
      yPosOrNeg = 1.0;
    } else if (position.dy > boundingBox.dy) {
      yPosOrNeg = -1.0;
    } else {
      yPosOrNeg = Random().nextInt(2) == 0 ? -1.0 : 1.0;
    }

    velocity = velocity +
        Offset(scaleFactor * Random().nextInt(10) * xPosOrNeg,
            scaleFactor * Random().nextInt(10) * yPosOrNeg);
  }

  Widget build() {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: Container(
        child: child,
        height: size,
        width: size,
      ),
    );
  }
}
