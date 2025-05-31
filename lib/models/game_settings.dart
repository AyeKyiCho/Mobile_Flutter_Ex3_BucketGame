class GameSettings {
  final bool soundEnabled;
  final int difficultyLevel;
  final double controlSensitivity;

  GameSettings({
    this.soundEnabled = true,
    this.difficultyLevel = 1,
    this.controlSensitivity = 1.0,
  });

  // Add copyWith method
  GameSettings copyWith({
    bool? soundEnabled,
    int? difficultyLevel,
    double? controlSensitivity,
  }) {
    return GameSettings(
      soundEnabled: soundEnabled ?? this.soundEnabled,
      difficultyLevel: difficultyLevel ?? this.difficultyLevel,
      controlSensitivity: controlSensitivity ?? this.controlSensitivity,
    );
  }
}