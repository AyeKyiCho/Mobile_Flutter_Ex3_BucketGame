import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/game_screen.dart';
import 'screens/settings_screen.dart';
import 'services/game_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GameState(prefs)),
      ],
      child: const BucketCollectGame(),
    ),
  );
}

class BucketCollectGame extends StatelessWidget {
  const BucketCollectGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bucket Collect',
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => const GameScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}