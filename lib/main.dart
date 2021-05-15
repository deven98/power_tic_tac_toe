import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:power_tic_tac_toe/game/tic_tac_toe.dart';
import 'package:power_tic_tac_toe/game_ui/home_screen.dart';
import 'package:power_tic_tac_toe/utils/constants.dart';

void main() {
  TicTacToe tacToe = TicTacToe(gameBoardType: GameBoardType.threeByThree);

  tacToe.makeMoveWithoutChangingTurn(0, 0);
  tacToe.makeMoveWithoutChangingTurn(0, 1);
  tacToe.makeMoveWithoutChangingTurn(0, 2);

  print(tacToe.gameBoard);

  print(tacToe.isWin());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.aBeeZeeTextTheme()),
      home: HomeScreen(),
    );
  }
}
