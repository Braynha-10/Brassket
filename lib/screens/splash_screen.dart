// lib/screens/splash_screen.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login_screen.dart';
import '../home_page.dart'; // sua HomePage já pronta

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Aguarda 2 segundos e então decide para onde ir
    Timer(const Duration(seconds: 2), () {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Usuário já está logado → vai para Home
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
      } else {
        // Não está logado → vai para Login
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fundo marrom escuro configurado no Theme
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Imagem da bola de basquete
            Image.asset(
              'assets/images/basketball.png',
              width: 120,
              height: 120,
            ),
            const SizedBox(height: 16),
            // Título “Brassket”
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFFFA726), // laranja
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Brassket',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown[900],
                  fontFamily: 'PressStart2P', // se tiver a fonte
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Versão Beta 1.0',
              style: TextStyle(
                fontSize: 12,
                color: Colors.orange[100],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
