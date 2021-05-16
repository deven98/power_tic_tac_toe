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

  bool makeMove(int row, int column) {
    if (gameBoard[row][column] == 0) {
      gameBoard[row][column] = playerToPlay == TurnOf.player1 ? 1 : -1;
      changeTurn();
      return true;
    }
    return false;
  }

  bool makeMoveWithoutChangingTurn(int row, int column) {
    if (gameBoard[row][column] == 0) {
      gameBoard[row][column] = playerToPlay == TurnOf.player1 ? 1 : -1;
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
        if (gameBoard[i][j] == 1 &&
            _checkWin(1, gameBoardType.size == 3 ? 3 : 4, i, j)) {
          gameWinner = TurnOf.player1;
          return true;
        } else if (gameBoard[i][j] == -1 &&
            _checkWin(-1, gameBoardType.size == 3 ? 3 : 4, i, j)) {
          gameWinner = TurnOf.player2;
          return true;
        }
      }
    }
    return false;
  }

  bool _checkWin(int findValue, int winSize, int row, int column) {
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

        while (run) {
          if (loopRow < gameBoardType.size &&
              loopRow >= 0 &&
              loopColumn < gameBoardType.size &&
              loopColumn >= 0 &&
              gameBoard[loopRow][loopColumn] == findValue) {
            count++;
            loopRow += i;
            loopColumn += j;
          } else {
            run = false;
          }
        }

        if (count == winSize) {
          return true;
        }
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
