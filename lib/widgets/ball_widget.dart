import 'package:flutter/material.dart';
import '../models/ball.dart';

class BallWidget extends StatelessWidget {
  final Ball ball;

  const BallWidget({super.key, required this.ball});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: ball.x,
      top: ball.y,
      child: Container(
        width: ball.radius * 2,
        height: ball.radius * 2,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              ball.color.withOpacity(1.0),
              ball.color.withOpacity(0.4),
            ],
            center: const Alignment(-0.3, -0.3),
            radius: 0.85,
          ),
          boxShadow: [
            BoxShadow(
              color: ball.color.withOpacity(0.6),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, 0),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 6,
              offset: const Offset(2, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            Align(
              alignment: const Alignment(-0.4, -0.4),
              child: Container(
                width: ball.radius * 0.6,
                height: ball.radius * 0.6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
