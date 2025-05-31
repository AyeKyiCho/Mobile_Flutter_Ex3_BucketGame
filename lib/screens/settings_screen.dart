import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/game_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Game Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text('Sound Effects'),
              value: gameState.settings.soundEnabled,
              onChanged: (value) => gameState.updateSettings(
                gameState.settings.copyWith(soundEnabled: value),
              ),
            ),
            Slider(
              value: gameState.settings.difficultyLevel.toDouble(),
              min: 1,
              max: 5,
              divisions: 4,
              label: 'Difficulty: ${gameState.settings.difficultyLevel}',
              onChanged: (value) => gameState.updateSettings(
                gameState.settings.copyWith(difficultyLevel: value.toInt()),
              ),
            ),
            // Add more settings as needed
          ],
        ),
      ),
    );
  }
}