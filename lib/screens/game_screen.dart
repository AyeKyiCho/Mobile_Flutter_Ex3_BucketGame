import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/ball.dart';
import '../models/coin.dart';
import '../services/game_state.dart';
import '../widgets/ball_widget.dart';
import '../widgets/coin_widget.dart';
import '../widgets/game_overlay.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Random _random = Random();

  double _bucketPosition = 0.0;
  final double _bucketWidth = 150.0;   // previously 80.0
  final double _bucketHeight = 120.0;  // previously 60.0
  bool _gameOver = false;

  final List<Ball> _balls = [];
  final List<Coin> _coins = [];
  final double _ballRadius = 15.0;
  double _ballSpeed = 3.0;
  int _ballSpawnRate = 60;
  int _frameCount = 0;
  final double _coinSpawnChance = 0.3;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(days: 1),
      vsync: this,
    )..addListener(_updateGame);
    _controller.forward();
  }

  void _updateGame() {
    if (!_gameOver && mounted) {
      final gameState = Provider.of<GameState>(context, listen: false);
      final screenHeight = MediaQuery.of(context).size.height;
      final screenWidth = MediaQuery.of(context).size.width;

      setState(() {
        _frameCount++;

        if (_frameCount % _ballSpawnRate == 0) {
          final newBall = Ball(
            x: _random.nextDouble() * (screenWidth - _ballRadius * 2),
            y: 0,
            radius: _ballRadius,
            color: Colors.primaries[_random.nextInt(Colors.primaries.length)],
            speed: _ballSpeed,
            carriesCoin: _random.nextDouble() < _coinSpawnChance,
            coinValue: _random.nextInt(3) + 1,
          );

          _balls.add(newBall);

          if (newBall.carriesCoin) {
            _coins.add(Coin(
              x: newBall.x + newBall.radius - 6,
              y: newBall.y - 15,
              value: newBall.coinValue,
            ));
          }
        }

        _balls.removeWhere((ball) {
          ball.y += ball.speed;

          final caught = ball.y + ball.radius * 2 >= screenHeight - _bucketHeight &&
              ball.x + ball.radius >= _bucketPosition &&
              ball.x + ball.radius <= _bucketPosition + _bucketWidth;

          if (caught) {
            gameState.addScore(1);
            return true;
          } else if (ball.y >= screenHeight) {
            _gameOver = true;
            _controller.stop();
            return true;
          }
          return false;
        });

        _coins.removeWhere((coin) {
          coin.y += 2;
          if (coin.y + coin.radius >= screenHeight - _bucketHeight &&
              coin.x >= _bucketPosition &&
              coin.x <= _bucketPosition + _bucketWidth) {
            gameState.addCoins(coin.value);
            return true;
          }
          return coin.y > screenHeight;
        });
      });
    }
  }

  void _moveBucket(Offset position) {
    if (!_gameOver) {
      setState(() {
        _bucketPosition = (position.dx - _bucketWidth / 2)
            .clamp(0.0, MediaQuery.of(context).size.width - _bucketWidth);
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onPanUpdate: (details) => _moveBucket(details.globalPosition),
        onTapDown: (details) => _moveBucket(details.globalPosition),
        child: Stack(
          children: [
            // Background
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.lightBlue],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),

            // Game Elements
            ..._balls.map((ball) => BallWidget(ball: ball)),
            ..._coins.map((coin) => CoinWidget(coin: coin)),

            // PNG Bucket
            Positioned(
              left: _bucketPosition,
              bottom: 0,
              child: SizedBox(
                width: _bucketWidth,
                height: _bucketHeight,
                child: Image.asset(
                  'assets/images/bucket.png',
                  fit: BoxFit.fill, // or BoxFit.cover for cropping
                ),
              ),
            ),

            // Settings Button
            Positioned(
              top: 20,
              right: 20,
              child: IconButton(
                icon: const Icon(Icons.settings, color: Colors.white),
                onPressed: () => Navigator.pushNamed(context, '/settings'),
              ),
            ),

            // Overlay UI
            GameOverlay(
              score: context.watch<GameState>().score,
              coins: context.watch<GameState>().coins,
              gameOver: _gameOver,
              onReset: _resetGame,
            ),
          ],
        ),
      ),
    );
  }

  void _resetGame() {
    if (mounted) {
      setState(() {
        _balls.clear();
        _coins.clear();
        _gameOver = false;
        _ballSpeed = 3.0;
        _ballSpawnRate = 60;
        _frameCount = 0;
        context.read<GameState>().reset();
        _controller.forward();
      });
    }
  }
}
