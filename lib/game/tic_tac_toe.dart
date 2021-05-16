import 'package:flutter/material.dart';
import 'package:power_tic_tac_toe/utils/constants.dart';

enum SquareState { playedPlayer1, playedPlayer2, notPlayed }

enum TurnOf {
  player1,
  player2,
}

class TicTacToe {
  late GameBoardType gameBoardType;
  late List<List<int>> gameBoard;
  TurnOf playerToPlay = TurnOf.player1;
  TurnOf? gameWinner;
  List<List<int>>? winningSquares;
  VoidCallback? onMove;

  TicTacToe({
    required this.gameBoardType,
    this.onMove,
  }) : gameBoard = List.generate(gameBoardType.size,
            (index) => List.generate(gameBoardType.size, (index) => 0));

  bool makeMove(int row, int column) {
    if (gameBoard[row][column] == 0) {
      gameBoard[row][column] = playerToPlay == TurnOf.player1 ? 1 : -1;
      changeTurn();
      isWin();
      onMove?.call();
      return true;
    }
    return false;
  }

  bool makeMoveWithoutChangingTurn(int row, int column) {
    if (gameBoard[row][column] == 0) {
      gameBoard[row][column] = playerToPlay == TurnOf.player1 ? 1 : -1;
      isWin();
      onMove?.call();
      return true;
    }
    return false;
  }

  bool flipSquare(int row, int column) {
    if (gameBoard[row][column] != 0) {
      gameBoard[row][column] = -gameBoard[row][column];
      return true;
    }
    return false;
  }

  void resetSquare(int row, int column) {
    gameBoard[row][column] = 0;
  }

  void resetBoard() {
    gameBoard = List.generate(gameBoardType.size,
        (index) => List.generate(gameBoardType.size, (index) => 0));
    playerToPlay = TurnOf.player1;
    gameWinner = null;
    winningSquares = null;
  }

  void changeTurn() {
    if (playerToPlay == TurnOf.player1) {
      playerToPlay = TurnOf.player2;
    } else {
      playerToPlay = TurnOf.player1;
    }
  }

  bool isDraw() {
    if (isWin()) {
      return false;
    }

    if (moves < gameBoardType.size * gameBoardType.size) {
      return false;
    }

    return true;
  }

  bool isWin() {
    switch (gameBoardType) {
      case GameBoardType.threeByThree:
        return checkWin();
      case GameBoardType.fiveByFive:
        return checkWin();
      case GameBoardType.sevenBySeven:
        return checkWin();
      default:
        return false;
    }
  }

  bool checkWin() {
    for (int i = 0; i < gameBoardType.size; i++) {
      for (int j = 0; j < gameBoardType.size; j++) {
        if (gameBoard[i][j] == 1) {
          var res = _checkWin(1, gameBoardType.size == 3 ? 3 : 4, i, j);

          if (res != null) {
            gameWinner = TurnOf.player1;
            winningSquares = res;
            return true;
          }
        } else if (gameBoard[i][j] == -1) {
          var res = _checkWin(-1, gameBoardType.size == 3 ? 3 : 4, i, j);

          if (res != null) {
            gameWinner = TurnOf.player2;
            winningSquares = res;
            return true;
          }
        }
      }
    }
    return false;
  }

  List<List<int>>? _checkWin(int findValue, int winSize, int row, int column) {
    for (int i = -1; i < 2; i++) {
      for (int j = -1; j < 2; j++) {
        /// Avoid the same square
        if (i == 0 && j == 0) {
          continue;
        }

        var count = 0;
        bool run = true;
        var loopRow = row;
        var loopColumn = column;

        List<List<int>> squares = [
          [row, column]
        ];

        while (run) {
          if (loopRow < gameBoardType.size &&
              loopRow >= 0 &&
              loopColumn < gameBoardType.size &&
              loopColumn >= 0 &&
              gameBoard[loopRow][loopColumn] == findValue) {
            squares.add([loopRow, loopColumn]);
            count++;
            loopRow += i;
            loopColumn += j;
          } else {
            run = false;
          }
        }

        if (count == winSize) {
          return squares;
        }
      }
    }

    return null;
  }

  int get moves => gameBoard.fold(
      0,
      (previousValue, element) =>
          previousValue + element.where((e) => e != 0).length);

  List<List<int>> get possibleMoves {
    List<List<int>> moves = [];

    for (int i = 0; i < gameBoardType.size; i++) {
      for (int j = 0; j < gameBoardType.size; j++) {
        if (gameBoard[i][j] == 0) {
          moves.add([i, j]);
        }
      }
    }

    return moves;
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

extension Sum on List<int> {
  int sum() => fold(0, (previousValue, element) => previousValue + element);
}
