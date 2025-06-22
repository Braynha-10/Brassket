
class Team {
  final String name;
  int score; // quanto maior, mais chances de ganhar
  int wins = 0;
  int losses = 0;
  int draws = 0;
  int points = 0;

  Team(this.name, this.score);
}

class Match {
  final Team home;
  final Team away;
  bool played = false;
  int? homeScore;
  int? awayScore;

  Match(this.home, this.away);
}
