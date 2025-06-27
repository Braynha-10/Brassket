import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateTeamScreen extends StatefulWidget {
  const UpdateTeamScreen({super.key});

  @override
  State<UpdateTeamScreen> createState() => _UpdateTeamScreenState();
}

class _UpdateTeamScreenState extends State<UpdateTeamScreen> {
  final _formKey = GlobalKey<FormState>();
  final _teamController = TextEditingController();
  bool _isLoading = false;

  Future<void> _updateTeam() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _isLoading = true;
    });

    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
          'time': _teamController.text,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Time atualizado com sucesso!')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao atualizar time: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _teamController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atualizar Time'),
        backgroundColor: const Color(0xFF5D4037),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _teamController,
                decoration: const InputDecoration(labelText: 'Novo Time'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o nome do time';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFA726),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: _updateTeam,
                      child: const Text(
                        'Salvar',
                        style: TextStyle(fontSize: 18, color: Colors.brown),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}