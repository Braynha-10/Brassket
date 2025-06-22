import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'screens/splash_screen.dart';
import 'screens/Intro_screen.dart';
import 'screens/choose_team_screen.dart';
import 'screens/TimeHome_screen.dart';
import 'screens/game_screen.dart'; // Importando a tela do jogo

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const BrassketApp());
}

class BrassketApp extends StatelessWidget {
  const BrassketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Brassket',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: const Color(0xFF5D4037), // marrom escuro
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
      ),
      initialRoute: '/',
      home: const SplashScreen(),
      routes: {
        '/intro': (context) => const IntroScreen(),
        '/escolher-time': (_) => const ChooseTeamScreen(),
        '/time-home': (_) => const TimeHomeScreen(),
        '/game': (_) => const GamePage(), // Rota para a tela do jogo
      },
    );
  }
}