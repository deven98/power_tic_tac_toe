import 'package:flutter/material.dart';
import 'package:power_tic_tac_toe/game/tic_tac_toe.dart';
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
  late TicTacToe game;
  bool enablePowers = false;

  @override
  void initState() {
    super.initState();
    game = TicTacToe(gameBoardType: widget.gameBoardType);
  }

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
              Row(
                mainAxisAlignment:
                    widget.gamePlayerType == GamePlayerType.twoPlayer
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.end,
                children: [
                  if (widget.gamePlayerType == GamePlayerType.twoPlayer)
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            enablePowers = !enablePowers;
                          });
                        },
                        style: ButtonStyle(),
                        child: Text(
                          'Powers: ${enablePowers ? 'On' : 'Off'}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0,
                          ),
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Text(
                      (widget.gamePlayerType == GamePlayerType.twoPlayer
                              ? 'Player 2'
                              : 'Computer') +
                          '${game.gameWinner == TurnOf.player2 ? ' Wins' : ''}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GameBoard(
                  game: game,
                  gameBoardType: widget.gameBoardType,
                  gamePlayerType: widget.gamePlayerType,
                  elementColor: Colors.white.withOpacity(0.8),
                  thickness: 4.0,
                  onResult: () {
                    setState(() {});
                  },
                  enablePowers: enablePowers,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Player 1' +
                          '${game.gameWinner == TurnOf.player1 ? ' Wins' : ''}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          game.resetBoard();
                        });
                      },
                      style: ButtonStyle(),
                      child: Text(
                        'Reset',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SafeArea(
            child: Align(
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
          ),
        ],
      ),
    );
  }
}
