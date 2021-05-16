import 'dart:math';

import 'package:flutter/material.dart';
import 'package:power_tic_tac_toe/game/tic_tac_toe.dart';
import 'package:power_tic_tac_toe/utils/constants.dart';

import 'game_elements.dart';

class GameBoard extends StatefulWidget {
  final Color elementColor;
  final double thickness;
  final GameBoardType gameBoardType;
  final TicTacToe game;

  GameBoard({
    this.elementColor = Colors.black,
    this.thickness = 0.5,
    this.gameBoardType = GameBoardType.threeByThree,
    required this.game,
  });

  @override
  _GameBoardState createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  @override
  void initState() {
    super.initState();
    widget.game.onMove = () {
      setState(() {});
    };
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Stack(
        children: [
          Container(
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
          ),
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.game.gameBoardType.size,
            ),
            itemBuilder: (context, position) {
              int size = widget.game.gameBoardType.size;
              int row = position ~/ size;
              int column = position % size;

              int move = widget.game.gameBoard[row][column];

              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  child: _buildMove(move, row, column),
                ),
              );
            },
            shrinkWrap: true,
            itemCount:
                widget.game.gameBoardType.size * widget.game.gameBoardType.size,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
          ),
          if (widget.game.winningSquares != null)
            TweenAnimationBuilder<double>(
              duration: Duration(milliseconds: 700),
              tween: Tween(begin: 0, end: 1.0),
              builder: (context, val, wid) {
                return CustomPaint(
                  child: SizedBox.expand(),
                  painter: WinPainter(
                    winningSquares: widget.game.winningSquares!,
                    gameBoardType: widget.gameBoardType,
                    progress: val,
                    thickness: 3.0,
                    color: Colors.white,
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildMove(int i, int row, int column) {
    switch (i) {
      case -1:
        return GameO(
          elementColor: Colors.white,
        );
      case 1:
        return GameX(
          elementColor: Colors.white,
          thickness: 2.0,
        );
      default:
        return InkWell(
          child: SizedBox.expand(),
          onTap: () {
            if (!widget.game.isWin() && !widget.game.isDraw()) {
              widget.game.makeMove(row, column);
            }
          },
        );
    }
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

class WinPainter extends CustomPainter {
  double progress;
  Color color;
  double thickness;
  GameBoardType gameBoardType;
  List<List<int>> winningSquares;

  WinPainter({
    this.progress = 0,
    this.color = Colors.black,
    this.thickness = 0.5,
    required this.gameBoardType,
    required this.winningSquares,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..strokeWidth = thickness
      ..color = color;

    var start = winningSquares[0];
    var end = winningSquares.last;

    var shortestSize = size.width < size.height ? size.width : size.height;

    var blockSize = shortestSize / gameBoardType.size;

    var startPosition = Offset(blockSize * start[1], blockSize * start[0]) +
        Offset(blockSize / 2, blockSize / 2);
    var endPosition = Offset(blockSize * end[1], blockSize * end[0]) +
        Offset(blockSize / 2, blockSize / 2);

    canvas.drawLine(startPosition, endPosition * progress, paint);
  }

  @override
  bool shouldRepaint(covariant WinPainter oldDelegate) {
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
