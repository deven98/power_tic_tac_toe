import 'package:flutter/material.dart';
import 'package:power_tic_tac_toe/gradient/background_gradient.dart';
import 'package:power_tic_tac_toe/utils/constants.dart';

import 'components/game_board.dart';

class GameScreen extends StatefulWidget {
  final GamePlayerType gamePlayerType;
  final GameBoardType gameBoardType;

  GameScreen({
    required this.gamePlayerType,
    required this.gameBoardType,
  });

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundGradient(
            bgOpacity: 0.1,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Text(
                    widget.gamePlayerType == GamePlayerType.twoPlayer
                        ? 'Player 2'
                        : 'Computer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: GameBoard(
                    gameBoardType: widget.gameBoardType,
                    elementColor: Colors.white.withOpacity(0.8),
                    thickness: 4.0,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    'Player 1',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: Icon(
                Icons.cancel,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
