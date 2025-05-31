import 'package:flutter/material.dart';

class GameOverlay extends StatelessWidget {
  final int score;
  final int coins;
  final bool gameOver;
  final VoidCallback onReset;

  const GameOverlay({
    super.key,
    required this.score,
    required this.coins,
    required this.gameOver,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 50,
          left: 20,
          child: Row(
            children: [
              _buildInfoBadge('Score: $score', Icons.score),
              const SizedBox(width: 10),
              _buildInfoBadge('Coins: $coins', Icons.monetization_on),
            ],
          ),
        ),
        if (gameOver)
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.7),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Game Over!', style: TextStyle(fontSize: 48)),
                    const SizedBox(height: 20),
                    Text('Final Score: $score', style: TextStyle(fontSize: 36)),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: onReset,
                      child: const Text('Play Again'),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildInfoBadge(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(width: 6),
          Text(text, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}