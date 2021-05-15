import 'dart:math';

import 'package:flutter/material.dart';
import 'package:power_tic_tac_toe/game_ui/components/game_elements.dart';
import 'package:power_tic_tac_toe/gradient/particle.dart';
import 'package:power_tic_tac_toe/gradient/constants.dart';
import 'package:power_tic_tac_toe/utils/extensions.dart';

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

  List<Particle> particles = [];

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 10));
    _animationController.repeat(reverse: true);
    _gradient = gradients[Random().nextInt(gradients.length)];
    _gradientMovementAnim = Tween(begin: 0.0, end: 0.45).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, snapshot) {
        particles.forEach(
            (e) => e.updateVelocities(MediaQuery.of(context).size.offset));
        particles.forEach((e) => e.updatePosition());

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
            ...particles.map((e) => e.build()),
          ],
        );
      },
    );
  }

  void generateParticles() {
    var size = MediaQuery.of(context).size;

    particles = List.generate(
      7,
      (index) {
        var randomOffsetX = Random().nextInt(size.width.toInt());
        var randomOffsetY = Random().nextInt(size.height.toInt());

        return Particle(
          position: Offset(randomOffsetX.toDouble(), randomOffsetY.toDouble()),
          child: GameX(
            elementColor: Colors.white.withOpacity(0.6),
            thickness: 3.0,
          ),
        );
      },
    );

    particles.addAll(List.generate(
      7,
      (index) {
        var randomOffsetX = Random().nextInt(size.width.toInt());
        var randomOffsetY = Random().nextInt(size.height.toInt());

        return Particle(
          position: Offset(randomOffsetX.toDouble(), randomOffsetY.toDouble()),
          child: GameO(
            elementColor: Colors.white.withOpacity(0.6),
          ),
        );
      },
    ));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (particles.isEmpty) {
      generateParticles();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }
}
