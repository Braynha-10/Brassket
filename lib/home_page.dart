import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed('/login');
  }

  Future<void> _handlePlay(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      final data = doc.data();
      if (data != null && data['time'] != null && data['time'] != '') {
        Navigator.of(context).pushNamed('/time-home');
        return;
      }
    }
    Navigator.of(context).pushNamed('/intro');
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
            message: userEmail,
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Image.asset(
                'assets/images/personagem.png',
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
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              onPressed: () => _handlePlay(context),
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
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
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
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
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