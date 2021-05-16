import 'dart:math';

import 'package:flutter/material.dart';

class GameX extends StatefulWidget {
  final Color elementColor;
  final double thickness;

  GameX({this.elementColor = Colors.black, this.thickness = 0.5});

  @override
  _GameXState createState() => _GameXState();
}

class _GameXState extends State<GameX> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TweenAnimationBuilder<double>(
          duration: Duration(milliseconds: 500),
          tween: Tween(begin: 0.0, end: 1.0),
          curve: Curves.easeInOut,
          builder: (context, val, wid) {
            return CustomPaint(
              painter: XPainter(
                  progress: val,
                  color: widget.elementColor,
                  thickness: widget.thickness),
              child: Container(),
            );
          }),
    );
  }
}

class XPainter extends CustomPainter {
  double progress;
  Color color;
  double thickness;

  XPainter({
    this.progress = 0,
    this.color = Colors.black,
    this.thickness = 0.5,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..strokeWidth = thickness
      ..color = color;

    var firstStrokeProgress = progress > 0.5 ? 1.0 : progress * 2;
    var secondStrokeProgress = progress < 0.5 ? 0 : (progress - 0.5) * 2;

    canvas.drawLine(
        Offset(0, 0),
        Offset(size.width * firstStrokeProgress,
            size.height * firstStrokeProgress),
        paint);

    if (secondStrokeProgress > 0) {
      canvas.drawLine(
          Offset(0, size.height),
          Offset(size.width * secondStrokeProgress,
              size.height * (1.0 - secondStrokeProgress)),
          paint);
    }
  }

  @override
  bool shouldRepaint(covariant XPainter oldDelegate) {
    return progress != oldDelegate.progress || color != oldDelegate.color;
  }
}

class GameO extends StatefulWidget {
  final Color elementColor;
  final double thickness;

  GameO({this.elementColor = Colors.black, this.thickness = 0.5});

  @override
  _GameOState createState() => _GameOState();
}

class _GameOState extends State<GameO> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TweenAnimationBuilder<double>(
          duration: Duration(milliseconds: 500),
          tween: Tween(begin: 0.0, end: 1.0),
          curve: Curves.easeInOut,
          builder: (context, val, wid) {
            return CustomPaint(
              painter: OPainter(
                  progress: val,
                  color: widget.elementColor,
                  thickness: widget.thickness),
              child: Container(),
            );
          }),
    );
  }
}

class OPainter extends CustomPainter {
  double progress;
  Color color;
  double thickness;

  OPainter({
    this.progress = 0,
    this.color = Colors.black,
    this.thickness = 0.5,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..strokeWidth = thickness
      ..color = color;

    canvas.drawArc(
        Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2),
            radius: size.width / 2),
        0.0,
        2 * pi * progress,
        true,
        paint);
  }

  @override
  bool shouldRepaint(covariant OPainter oldDelegate) {
    return progress != oldDelegate.progress || color != oldDelegate.color;
  }
}
