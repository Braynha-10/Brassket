import 'package:flutter/material.dart';

class OptionsScreen extends StatelessWidget {
  const OptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Options"),
        backgroundColor: const Color(0xFF5D4037),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFA726),
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                // Navega para a página de alteração de cadastro (email e senha)
                Navigator.of(context).pushNamed('/update_profile');
              },
              child: const Text(
                "Alterar Cadastro",
                style: TextStyle(fontSize: 18, color: Colors.brown),
              ),
            ),
            const SizedBox(height: 16),
            // Botão de alteração de time removido.
          ],
        ),
      ),
    );
  }
}