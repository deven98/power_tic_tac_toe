import 'dart:math';

import 'package:flutter/material.dart';
import 'package:power_tic_tac_toe/utils/constants.dart';

class GameBoard extends StatefulWidget {
  final Color elementColor;
  final double thickness;
  final GameBoardType gameBoardType;

  GameBoard({
    this.elementColor = Colors.black,
    this.thickness = 0.5,
    this.gameBoardType = GameBoardType.threeByThree,
  });

  @override
  _GameBoardState createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TweenAnimationBuilder<double>(
        duration: Duration(milliseconds: 500),
        tween: Tween(begin: 0.0, end: 1.0),
        curve: Curves.easeInOut,
        builder: (context, val, wid) {
          return CustomPaint(
            painter: BoardPainter(
              progress: val,
              color: widget.elementColor,
              thickness: widget.thickness,
              gameBoardType: widget.gameBoardType,
            ),
            child: Container(),
          );
        },
      ),
    );
  }
}

class BoardPainter extends CustomPainter {
  double progress;
  Color color;
  double thickness;
  GameBoardType gameBoardType;

  BoardPainter({
    this.progress = 0,
    this.color = Colors.black,
    this.thickness = 0.5,
    this.gameBoardType = GameBoardType.threeByThree,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..strokeWidth = thickness
      ..color = color;

    var firstStrokeProgress = progress > 0.5 ? 1.0 : progress * 2;
    var secondStrokeProgress = progress < 0.5 ? 0 : (progress - 0.5) * 2;

    var shortestSize = size.width < size.height ? size.width : size.height;

    var baseStrokeDistance = shortestSize / gameBoardType.size;

    for (int i = 1; i < gameBoardType.size; i++) {
      canvas.drawLine(
          Offset(0, baseStrokeDistance * i),
          Offset(shortestSize * firstStrokeProgress, baseStrokeDistance * i),
          paint);
    }

    if (secondStrokeProgress > 0) {
      for (int i = 1; i < gameBoardType.size; i++) {
        canvas.drawLine(
            Offset(baseStrokeDistance * i, 0),
            Offset(baseStrokeDistance * i, shortestSize * secondStrokeProgress),
            paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant BoardPainter oldDelegate) {
    return progress != oldDelegate.progress || color != oldDelegate.color;
  }
}

extension on GameBoardType {
  get size {
    switch (GameBoardType.values[index]) {
      case GameBoardType.threeByThree:
        return 3;
      case GameBoardType.fiveByFive:
        return 5;
      case GameBoardType.sevenBySeven:
        return 7;
    }
  }
}
