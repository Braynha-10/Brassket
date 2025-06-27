import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    // Volta para a tela de login (limpando a pilha)
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    final userEmail = FirebaseAuth.instance.currentUser?.email ?? 'Desconhecido';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Brassket Home'),
        backgroundColor: const Color(0xFF5D4037),
        actions: [
          Tooltip(
            message: userEmail, // Mostra o email do usuário ao passar o mouse
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Image.asset(
                'assets/images/personagem.png', // Coloque aqui o caminho da imagem desejada
                width: 40,
                height: 40,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Bem-vindo\n',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFA726),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('/intro');
              },
              child: const Text(
                'Play',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.brown,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFA726),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('/options');
              },
              child: const Text(
                'Options',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.brown,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFA726),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              onPressed: () => _logout(context),
              child: const Text(
                'Logout',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.brown,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}