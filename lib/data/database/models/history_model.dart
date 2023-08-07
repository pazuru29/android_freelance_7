class HistoryModel {
  int sportType;
  int timeOfMatch;
  int scoreTeam1;
  int scoreTeam2;

  HistoryModel({
    required this.sportType,
    required this.timeOfMatch,
    required this.scoreTeam1,
    required this.scoreTeam2,
  });

  factory HistoryModel.fromMap(Map<String, dynamic> json) => HistoryModel(
        sportType: json['sport_type'],
        timeOfMatch: json['time_of_match'],
        scoreTeam1: json['score_team_1'],
        scoreTeam2: json['score_team_2'],
      );

  Map<String, dynamic> toMap() {
    var map = <String, Object?>{
      'sport_type': sportType,
      'time_of_match': timeOfMatch,
      'score_team_1': scoreTeam1,
      'score_team_2': scoreTeam2,
    };

    return map;
  }
}
