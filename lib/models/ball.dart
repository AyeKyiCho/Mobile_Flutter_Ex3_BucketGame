import 'package:flutter/material.dart';

class Ball {
  double x;
  double y;
  final double radius;
  final Color color;
  final double speed;
  final bool carriesCoin;
  final int coinValue;

  Ball({
    required this.x,
    required this.y,
    required this.radius,
    required this.color,
    required this.speed,
    this.carriesCoin = false,
    this.coinValue = 0,
  });
}