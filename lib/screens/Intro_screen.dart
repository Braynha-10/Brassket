import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const personagemImg = 'assets/images/personagem.png';
    const balaoFalaImg = 'assets/images/balao.webp';

    return Scaffold(
      backgroundColor: const Color(0xFF5D4037),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Balão de fala com texto dentro
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            balaoFalaImg,
                            width: 1000,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(
                            width: 600,
                            child: Text(
                              '''Olá! Você é um apaixonado por basquete desde a infância. Desde o início teve perspectivas de vida bem definidas sobre isso e como sua carreira poderia ser brilhante por conta de sua força de vontade e habilidade adquirida com o tempo. Infelizmente, no college você teve uma lesão séria antes de ser draftado, no joelho, e foi informado que não poderia mais jogar. Mesmo assim, você não desistiu: estudou muito para continuar com seu sonho ou próximo disso e agora você tem a oportunidade de comandar um time do high school. Faça escolhas certas e tente manter o seu ranking bom para aumentar seu nível, status e subir na sua carreira. Você pode começar escolhendo entre três propostas.''',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 22),
                      // Personagem abaixo do balão
                      Image.asset(
                        personagemImg,
                        height: 160,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
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