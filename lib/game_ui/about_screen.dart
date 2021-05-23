import 'package:flutter/material.dart';
import 'package:power_tic_tac_toe/gradient/background_gradient.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundGradient(),
          _buildBody(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_outlined,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Center(
      child: ListView(
        shrinkWrap: true,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(
                16.0,
              ),
              child: Text(
                'About',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '''
Power Tic-Tac-Toe is a modern, minimalistic take on Tic-Tac-Toe. 

Use powers to make the game more exciting in 2 player mode or play with a computer.

3x3 mode requires 3 in a row to win, 5x5 and 7x7 require 4 in a row.

This app is part of an initiative to make free, open-source, ad-free, educational games.
              ''',
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '''
To look at source code of the game, go here:
              ''',
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Center(
            child: TextButton(
              onPressed: () {
                launch('https://github.com/deven98/power_tic_tac_toe');
              },
              child: Text(
                'Source Code',
                style: TextStyle(fontSize: 22.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
