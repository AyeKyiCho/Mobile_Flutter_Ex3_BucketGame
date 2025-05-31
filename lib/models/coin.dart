import 'package:flutter/material.dart';

class Coin {
  double x;
  double y;
  final double radius;
  final int value;
  final Color color;

  Coin({
    required this.x,
    required this.y,
    this.radius = 12,
    this.value = 1,
    this.color = Colors.amber,
  });
}