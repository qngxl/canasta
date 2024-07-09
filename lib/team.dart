class Team {
  Team(this.teamName);
  int canastaPoints = 0;
  int red3s = 0;
  bool dealingBonus = false;
  bool closingBonus = false;
  List<int> roundPoints = [];
  String teamName = "";

  int getCurrentRoundPoints() {
    double result = canastaPoints * 1.08 + red3s * 100;

    if (red3s == 6) {
      result += 600;
    }

    if (dealingBonus) {
      result += 500;
    }

    if (closingBonus) {
      result += 500;
    }

    return result.round();
  }

  void saveCurrentRoundPoints() {
    roundPoints.add(getCurrentRoundPoints());
    canastaPoints = 0;
    red3s = 0;
    dealingBonus = false;
    closingBonus = false;
  }

  int getTotalRoundPoints() {
    int total = 0;
    for (var roundPoint in roundPoints) {
      total = roundPoint + total;
    }
    return total;
  }

  int getAccumulatedRoundPoints(int maxRound) {
    int result = 0;

    for (var i = 0; i <= maxRound; i++) {
      result += roundPoints[i];
    }

    return result;
  }

  int getNotAcumulatedRoundPoints(roundIndex) {
    return roundPoints[roundIndex];
  }

  void newGame() {
    canastaPoints = 0;
    red3s = 0;
    dealingBonus = false;
    closingBonus = false;
    roundPoints.clear();
  }

  void deleteRound(int? roundNumber) {
    if (roundNumber != null) {
      roundPoints.removeAt(roundNumber);
    }
  }
}
