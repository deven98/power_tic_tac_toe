import 'dart:math';

import 'package:power_tic_tac_toe/game/tic_tac_toe.dart';
import 'package:power_tic_tac_toe/utils/constants.dart';

class GameComputer {
  static makeMove(TicTacToe game) {
    var res = getPossibleWinningMove(game);

    if (res != null) {
      game.makeMove(res[0], res[1]);
      return;
    }

    var res1 = stopPossibleWinningMove(game);

    if (res1 != null) {
      game.makeMove(res1[0], res1[1]);
      return;
    }

    makeRandomMove(game);
  }

  static List<int>? getPossibleWinningMove(TicTacToe game) {
    for (int i = 0; i < game.gameBoardType.size; i++) {
      for (int j = 0; j < game.gameBoardType.size; j++) {
        if (game.gameBoard[i][j] != 0) {
          continue;
        }

        var gameCopy = TicTacToe.copy(game: game, playerToPlay: TurnOf.player2);

        gameCopy.makeMove(i, j);

        if (gameCopy.isWin()) {
          return [i, j];
        }
      }
    }
  }

  static List<int>? stopPossibleWinningMove(TicTacToe game) {
    for (int i = 0; i < game.gameBoardType.size; i++) {
      for (int j = 0; j < game.gameBoardType.size; j++) {
        if (game.gameBoard[i][j] != 0) {
          continue;
        }

        var gameCopy = TicTacToe.copy(game: game, playerToPlay: TurnOf.player1);

        gameCopy.makeMove(i, j);

        if (gameCopy.isWin()) {
          return [i, j];
        }
      }
    }
  }

  static void makeRandomMove(TicTacToe game) {
    var moves = game.possibleMoves;

    var randomMove = moves[Random().nextInt(moves.length)];

    game.makeMove(randomMove[0], randomMove[1]);
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
