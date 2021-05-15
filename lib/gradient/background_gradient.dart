import 'dart:math';

import 'package:flutter/material.dart';
import 'package:power_tic_tac_toe/gradient/constants.dart';

class BackgroundGradient extends StatefulWidget {
  @override
  _BackgroundGradientState createState() => _BackgroundGradientState();
}

class _BackgroundGradientState extends State<BackgroundGradient>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late GradientModel _gradient;
  late Animation _gradientMovementAnim;

  AlignmentGeometry begin = Alignment.topLeft;
  AlignmentGeometry end = Alignment.bottomRight;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 10));
    _animationController.repeat(reverse: true);
    _gradient = gradients[Random().nextInt(gradients.length)];
    _gradientMovementAnim = Tween(begin: 0.0, end: 0.4).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, snapshot) {
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: _gradient.colors,
                  stops: [
                    0.0 + _gradientMovementAnim.value,
                    1.0 - _gradientMovementAnim.value
                  ],
                  begin: begin,
                  end: end,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }
}
