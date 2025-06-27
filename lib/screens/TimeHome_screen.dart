import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TimeHomeScreen extends StatefulWidget {
  const TimeHomeScreen({super.key});

  @override
  State<TimeHomeScreen> createState() => _TimeHomeScreenState();
}

class _TimeHomeScreenState extends State<TimeHomeScreen> {
  String nomeTime = '...';
  int score = 0;
  int financas = 0;
  int confianca = 0;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      final data = doc.data();
      if (data != null) {
        setState(() {
          nomeTime = data['time'] ?? 'Sem Time';
          score = data['score'] ?? 0;
          financas = data['financas'] ?? 0;
          confianca = data['confianca'] ?? 0;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacementNamed('/'); // Volta para HomePage
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF5D4037),
        appBar: AppBar(
          title: Text(nomeTime),
          backgroundColor: Colors.brown,
          automaticallyImplyLeading: false, // Remove botão voltar
          leading: IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/game');
                },
                child: const Text("Nova Temporada"),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Score: $score\nFinanças: $financas\nConfiança: $confianca',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}