import 'package:power_tic_tac_toe/utils/constants.dart';
import 'package:power_tic_tac_toe/utils/extensions.dart';

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

  TicTacToe({
    required this.gameBoardType,
  }) : gameBoard = List.generate(gameBoardType.size,
            (index) => List.generate(gameBoardType.size, (index) => 0));

  void makeMove(int row, int column) {
    gameBoard[row][column] = playerToPlay == TurnOf.player1 ? 1 : -1;
    changeTurn();
  }

  void makeMoveWithoutChangingTurn(int row, int column) {
    gameBoard[row][column] = playerToPlay == TurnOf.player1 ? 1 : -1;
  }

  void resetSquare(int row, int column) {
    gameBoard[row][column] = 0;
  }

  void resetBoard() {
    gameBoard = List.generate(gameBoardType.size,
        (index) => List.generate(gameBoardType.size, (index) => 0));
    playerToPlay = TurnOf.player1;
  }

  void changeTurn() {
    if (playerToPlay == TurnOf.player1) {
      playerToPlay = TurnOf.player2;
    } else {
      playerToPlay = TurnOf.player1;
    }
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
        if (_checkWin(
            1, 0, gameBoardType.size == 3 ? 3 : 4, i, j, gameBoardType)) {
          gameWinner = TurnOf.player1;
          return true;
        } else if (_checkWin(
            -1, 0, gameBoardType.size == 3 ? 3 : 4, i, j, gameBoardType)) {
          gameWinner = TurnOf.player2;
          return true;
        }
      }
    }
    return false;
  }

  bool _checkWin(int findValue, int valuesFound, int winSize, int row,
      int column, GameBoardType type,
      {int directionCoordinateOne = 0, int directionCoordinateTwo = 0}) {
    /// If we find enough in a line, win
    if (valuesFound == winSize) return true;

    /// Increment values found or return false since the line is broken
    if (gameBoard[row][column] == findValue) {
      valuesFound++;
    } else {
      return false;
    }

    /// If the first value is found, recursively find values on squares around it
    if (valuesFound == 1) {
      /// Go for all squares around it except the same square
      for (int i = -1; i < 2; i++) {
        for (int j = -1; j < 2; j++) {
          /// Avoid the same square
          if (i == 0 && j == 0) {
            continue;
          }

          /// If row and column aren't out of bounds, then go recursively to squares around
          if ((row + i < type.size && row + i >= 0) &&
              (column + j < type.size && column + j >= 0)) {
            if (gameBoard[row + i][column + j] == findValue) {
              _checkWin(
                findValue,
                valuesFound,
                winSize,
                row + i,
                column + j,
                type,
                directionCoordinateOne: i,
                directionCoordinateTwo: j,
              );
            }
          }
        }
      }
    } else {
      if ((row + directionCoordinateOne < type.size && row + directionCoordinateOne >= 0) &&
          (column + directionCoordinateTwo < type.size && column + directionCoordinateTwo >= 0)) {
        _checkWin(
          findValue,
          valuesFound,
          winSize,
          row + directionCoordinateOne,
          column + directionCoordinateTwo,
          type,
          directionCoordinateOne: directionCoordinateOne,
          directionCoordinateTwo: directionCoordinateTwo,
        );
      }
    }

    return false;
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
