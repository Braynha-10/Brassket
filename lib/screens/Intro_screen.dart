import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});


  @override
  Widget build(BuildContext context) {
    const personagemImg = 'assets/images/personagem.png';

    return Scaffold(
      backgroundColor: const Color(0xFF5D4037),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              const Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    '''olá você é um apaixonado por basquete desde a infância desde do inicio teve perspectivas de vida bem definidas sobre isso e como sua carreira poderia ser brilhante por conta de sua força de vontade e habilidade adquirida com o tempo infelizmente no college você teve uma lesão seria antes de ser draftado no joelho uma lesão que infelizmente você foi informado que não poderia mais jogar. mesmo assim você não d3esistiu estudou muito para continuar com seu sonho ou próximo disso e agora você tem a oportunidade de comandar um time do high school faça escolhas certas e tente manter o seu ranking bom para aumentar seu nível status e subir na sua carreira. você pode começar escolhendo entre três propostas''',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Image.asset(
                    personagemImg,
                    height: 150,
                    fit: BoxFit.contain,
                  ),
                  Positioned(
                    left: 16,
                    bottom: 120,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      width: 250,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Text(
                        'Você pode começar escolhendo entre três propostas...',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.brown,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/escolher-time');
                },
                child: const Text(
                  'Avançar',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
