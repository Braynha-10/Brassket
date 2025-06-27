import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChooseTeamScreen extends StatefulWidget {
  const ChooseTeamScreen({super.key});

  @override
  State<ChooseTeamScreen> createState() => _ChooseTeamScreenState();
}

class _ChooseTeamScreenState extends State<ChooseTeamScreen> {
  bool _loading = true;

  final List<Map<String, dynamic>> mockTimes = const [
    {
      'nome': 'Bryant Bulldogs',
      'confiança': 60,
      'facilidade': 'Fácil',
      'dinheiro': 100,
    },
    {
      'nome': 'Saint Louis Billikens',
      'confiança': 45,
      'facilidade': 'Médio',
      'dinheiro': 50,
    },
    {
      'nome': 'Charlotte 49ers',
      'confiança': 90,
      'facilidade': 'Difícil',
      'dinheiro': 10,
    },
  ];

  @override
  void initState() {
    super.initState();
    _checkIfHasTeam();
  }

  Future<void> _checkIfHasTeam() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      final data = doc.data();
      if (data != null && data['time'] != null && data['time'] != '') {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushReplacementNamed('/time-home');
        });
        return;
      }
    }
    setState(() {
      _loading = false;
    });
  }

  Future<void> _escolherTime(BuildContext context, Map<String, dynamic> time) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set({
            'time': time['nome'],
            'score': 10,
            'financas': time['dinheiro'],
            'confianca': time['confiança'],
          }, SetOptions(merge: true));
      Navigator.of(context).pushNamedAndRemoveUntil('/time-home', (route) => false, arguments: time['nome']);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        backgroundColor: Color(0xFF5D4037),
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      backgroundColor: const Color(0xFF5D4037),
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text('Escolha seu time'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: mockTimes.length,
        itemBuilder: (context, index) {
          final time = mockTimes[index];
          return Card(
            color: Colors.orange[100],
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(
                time['nome'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Confiança: ${time['confiança']}%\nFacilidade: ${time['facilidade']}\nDinheiro: ${time['dinheiro']}%',
              ),
              onTap: () => _escolherTime(context, time),
            ),
          );
        },
      ),
    );
  }
}