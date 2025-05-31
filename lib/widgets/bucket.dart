import 'package:flutter/material.dart';

class Bucket extends StatelessWidget {
  final double position;
  final double width;
  final double height;

  const Bucket({
    super.key,
    required this.position,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position,
      bottom: 0,
      child: SizedBox(
        width: width,
        height: height,
        child: Image.asset(
          'assets/images/bucket.png', // Make sure this path is correct
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
