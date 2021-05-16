import 'dart:math';

import 'package:power_tic_tac_toe/game/tic_tac_toe.dart';

class GameComputer {
  static makeMove(TicTacToe game) {
    makeRandomMove(game);
  }

  static List<int>? getPossibleWinningMove() {}

  static List<int>? stopPossibleWinningMove() {}

  static void makeRandomMove(TicTacToe game) {
    var moves = game.possibleMoves;

    var randomMove = moves[Random().nextInt(moves.length)];

    game.makeMove(randomMove[0], randomMove[1]);
  }
}
