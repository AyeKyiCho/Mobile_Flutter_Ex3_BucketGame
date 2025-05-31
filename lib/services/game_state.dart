import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/game_settings.dart';

class GameState with ChangeNotifier {
  int _score = 0;
  int _coins = 0;
  GameSettings _settings = GameSettings();
  final SharedPreferences prefs;

  GameState(this.prefs) {
    _loadSettings();
  }

  // Public Getters
  int get score => _score;
  int get coins => _coins;
  GameSettings get settings => _settings;

  // Game Progress Updates
  void addScore(int points) {
    _score += points;
    notifyListeners();
  }

  void addCoins(int amount) {
    _coins += amount;
    notifyListeners();
  }

  void reset() {
    _score = 0;
    _coins = 0;
    notifyListeners();
  }

  // Settings Management
  void updateSettings(GameSettings newSettings) {
    _settings = newSettings;
    _saveSettings();
    notifyListeners();
  }

  void _loadSettings() {
    _settings = GameSettings(
      soundEnabled: prefs.getBool('soundEnabled') ?? true,
      difficultyLevel: prefs.getInt('difficultyLevel') ?? 3,
    );
  }

  void _saveSettings() {
    prefs.setBool('soundEnabled', _settings.soundEnabled);
    prefs.setInt('difficultyLevel', _settings.difficultyLevel);
  }
}
