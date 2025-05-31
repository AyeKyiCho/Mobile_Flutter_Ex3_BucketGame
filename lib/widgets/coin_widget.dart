import 'package:flutter/material.dart';
import '../models/coin.dart';

class CoinWidget extends StatelessWidget {
  final Coin coin;
  const CoinWidget({super.key, required this.coin});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: coin.x,
      top: coin.y,
      child: Container(
        width: coin.radius * 2,
        height: coin.radius * 2,
        decoration: BoxDecoration(
          color: coin.color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 3,
              offset: const Offset(1, 1),
            ),
          ], // ✅ Closing boxShadow list properly
        ), // ✅ Closing BoxDecoration properly
        child: const Icon(Icons.monetization_on, size: 15, color: Colors.white),
      ), // ✅ Closing Container properly
    ); // ✅ Closing Positioned properly
  }
}