import 'package:flutter/material.dart';

/// Gradients for backgrounds
/// Credit: https://digitalsynopsis.com/design/beautiful-color-ui-gradients-backgrounds/
List<GradientModel> gradients = [
  GradientModel(start: Color(0xffffafbd), end: Color(0xffffc3a0)),
  GradientModel(start: Color(0xff2193b0), end: Color(0xff6dd5ed)),
  GradientModel(start: Color(0xffcc2b5e), end: Color(0xff753a88)),
  GradientModel(start: Color(0xffee9ca7), end: Color(0xffffdde1)),
  GradientModel(start: Color(0xffeb3349), end: Color(0xfff45c43)),
  GradientModel(start: Color(0xff42275a), end: Color(0xff734b6d)),
  GradientModel(start: Color(0xffbdc3c7), end: Color(0xff2c3e50)),
  GradientModel(start: Color(0xff06beb6), end: Color(0xff48b1bf)),
  GradientModel(start: Color(0xffeb3349), end: Color(0xfff45c43)),
  GradientModel(start: Color(0xffdd5e89), end: Color(0xfff7bb97)),
  GradientModel(start: Color(0xff56ab2f), end: Color(0xffa8e063)),
];

class GradientModel {
  Color start;
  Color end;

  GradientModel({required this.start, required this.end});

  get colors => [start, end];
}
