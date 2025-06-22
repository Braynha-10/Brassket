import 'dart:math';
import 'package:flutter/material.dart';
import '../models/teams.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late List<Team> teams;
  late List<Match> schedule;
  bool finalPlayed = false;
  String lastResult = '';

  @override
  void initState() {
    super.initState();
    teams = [
      Team("Charlotte 49ers", 70),
      Team("Bryant Bulldogs", 60),
      Team("Saint Louis Billikens", 45),
      Team("UAB Blazers", 70),
      Team("Temple Owls", 50),
    ];

    schedule = generateSchedule(teams);
  }

  List<Match> generateSchedule(List<Team> teams) {
    List<Match> result = [];
    for (int i = 0; i < teams.length; i++) {
      for (int j = 0; j < teams.length; j++) {
        if (i != j) result.add(Match(teams[i], teams[j]));
      }
    }
    return result;
  }

  Match? getNextMatch() {
    try {
      return schedule.firstWhere((match) => !match.played);
    } catch (e) {
      return null;
    }
  }

  String simulateMatch(Match match) {
    final random = Random();
    int rollsHome = 3 + (match.home.score ~/ 10);
    int rollsAway = 3 + (match.away.score ~/ 10);

    int totalHome = List.generate(rollsHome, (_) => random.nextInt(6) + 1).reduce((a, b) => a + b);
    int totalAway = List.generate(rollsAway, (_) => random.nextInt(6) + 1).reduce((a, b) => a + b);

    match.played = true;
    match.homeScore = totalHome;
    match.awayScore = totalAway;

    if (totalHome > totalAway) {
      match.home.wins++;
      match.away.losses++;
      match.home.points += 3;
      return '${match.home.name} venceu ${match.away.name}: $totalHome x $totalAway';
    } else if (totalAway > totalHome) {
      match.away.wins++;
      match.home.losses++;
      match.away.points += 3;
      return '${match.away.name} venceu ${match.home.name}: $totalAway x $totalHome';
    } else {
      match.home.draws++;
      match.away.draws++;
      match.home.points += 1;
      match.away.points += 1;
      return 'Empate: ${match.home.name} $totalHome x $totalAway ${match.away.name}';
    }
  }

  List<Team> getStandings() {
    teams.sort((a, b) => b.points.compareTo(a.points));
    return teams;
  }

  bool isSeasonOver() {
    return schedule.every((match) => match.played);
  }

  Match? getFinalMatch() {
    List<Team> sorted = getStandings();
    if (sorted.length >= 2 && sorted[0].points == sorted[1].points) {
      return Match(sorted[0], sorted[1]);
    }
    return null;
  }

  void onNextGamePressed() {
    setState(() {
      Match? next = getNextMatch();

      if (next != null) {
        lastResult = simulateMatch(next);
      } else if (getFinalMatch() != null && !finalPlayed) {
        lastResult = simulateMatch(getFinalMatch()!);
        finalPlayed = true;
      } else {
        lastResult = 'Temporada finalizada. Campeão: ${getStandings().first.name}';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Next Game Simulator")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: onNextGamePressed,
              child: const Text("Next Game"),
            ),
            const SizedBox(height: 20),
            Text(lastResult, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            const Text("Classificação:"),
            Expanded(
              child: ListView.builder(
                itemCount: teams.length,
                itemBuilder: (context, index) {
                  final team = getStandings()[index];
                  return ListTile(
                    title: Text(team.name),
                    subtitle: Text("Pts: ${team.points} | V: ${team.wins} E: ${team.draws} D: ${team.losses}"),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
