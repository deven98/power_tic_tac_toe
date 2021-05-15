import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:power_tic_tac_toe/game_ui/home_screen.dart';

void main() {
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
