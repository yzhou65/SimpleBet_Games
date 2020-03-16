import 'package:flutter/material.dart';

class BoxScoreModel {
  final List<PlayerModel> awayPitchers;
  final List<PlayerModel> homePitchers;
  final List<PlayerModel> awayBatters;
  final List<PlayerModel> homeBatters;
  final TeamModel awayTeam;
  final TeamModel homeTeam;

  BoxScoreModel({
    @required this.awayPitchers,
    @required this.homePitchers,
    @required this.awayBatters,
    @required this.homeBatters,
    @required this.awayTeam,
    @required this.homeTeam
  });

  BoxScoreModel.fromJson(Map<String, dynamic> json)
      : awayPitchers = (json['teams']['away']['pitchers'] as List).map((e) => PlayerModel.fromJson(json['teams']['away']['players']["ID$e"], PositionType.pitcher, e)).toList(),
        homePitchers = (json['teams']['home']['pitchers'] as List).map((e) => PlayerModel.fromJson(json['teams']['home']['players']["ID$e"], PositionType.pitcher, e)).toList(),
        awayBatters = (json['teams']['away']['batters'] as List).map((e) => PlayerModel.fromJson(json['teams']['away']['players']["ID$e"], PositionType.batter, e)).toList(),
        homeBatters = (json['teams']['home']['batters'] as List).map((e) => PlayerModel.fromJson(json['teams']['home']['players']["ID$e"], PositionType.batter, e)).toList(),
        awayTeam = TeamModel.fromJson(json['teams']['away'], TeamType.away),
        homeTeam = TeamModel.fromJson(json['teams']['home'], TeamType.home);
}

class TeamModel {
  final BattingStatsModel battingStats;
  final PitchingStatsModel pitchingStats;
  final List<PlayerModel> batters;
  final List<PlayerModel> pitchers;
  final TeamType teamType;

  TeamModel({
    @required this.battingStats,
    @required this.pitchingStats,
    @required this.batters,
    @required this.pitchers,
    @required this.teamType
  });

  TeamModel.fromJson(Map<String, dynamic> json, TeamType type)
    : battingStats = BattingStatsModel.fromJson(json['teamStats']['batting']),
      pitchingStats = PitchingStatsModel.fromJson(json['teamStats']['pitching']),
      batters = (json['batters'] as List).map((e) => PlayerModel.fromJson(json['players']["ID$e"], PositionType.batter, e)).toList(),
      pitchers = (json['pitchers'] as List).map((e) => PlayerModel.fromJson(json['players']["ID$e"], PositionType.pitcher, e)).toList(),
      teamType = type;
}

// For this exercise assume positionType infielder in API = batter, batters are categorized under 'Hitting' on screen
enum PositionType { batter, pitcher }
enum TeamType { home, away }

class PlayerModel {
  final String fullName;
  final String jerseyNumber;
  final PositionType positionType;
  final String position;
  final BattingStatsModel battingStats;
  final PitchingStatsModel pitchingStats;
  final String id;

  PlayerModel({
    @required this.fullName,
    @required this.jerseyNumber,
    @required this.positionType,
    @required this.position,
    @required this.battingStats,
    @required this.pitchingStats,
    @required this.id,
  });

  PlayerModel.fromJson(Map<String, dynamic> json, PositionType type, int playerId)
      : fullName = json['person']['fullName'],
        jerseyNumber = json['jerseyNumber'],
        positionType = type,
        position = json['position']['abbreviation'],
        battingStats = BattingStatsModel.fromJson(json['stats']['batting']), // json['stats']['batting'],
        pitchingStats = PitchingStatsModel.fromJson(json['stats']['pitching']), // json['stats']['pitching'];
        id = playerId.toString();
}

class BattingStatsModel {
  final int runs;
  final int doubles;
  final int triples;
  final int homeRuns;
  final int strikeOuts;
  final int hits;
  final int atBats;
  final int rbi;

  BattingStatsModel({
    @required this.runs,
    @required this.doubles,
    @required this.triples,
    @required this.homeRuns,
    @required this.strikeOuts,
    @required this.hits,
    @required this.atBats,
    @required this.rbi,
  });

  BattingStatsModel.fromJson(Map<String, dynamic> json)
      : runs = json['runs'] ?? 0,
        doubles = json['doubles'] ?? 0,
        triples = json['triples'] ?? 0,
        homeRuns = json['homeRuns'] ?? 0,
        strikeOuts = json['strikeOuts'] ?? 0,
        hits = json['hits'] ?? 0,
        atBats = json['atBats'] ?? 0,
        rbi = json['rbi'] ?? 0;
}

class PitchingStatsModel {
  final int runs;
  final int doubles;
  final int triples;
  final int homeRuns;
  final int strikeOuts;
  final int hits;
  final int atBats;
  final int rbi;
  final String inningsPitched;
  final int wins;
  final int losses;

  PitchingStatsModel({
    @required this.runs,
    @required this.doubles,
    @required this.triples,
    @required this.homeRuns,
    @required this.strikeOuts,
    @required this.hits,
    @required this.atBats,
    @required this.inningsPitched,
    @required this.wins,
    @required this.losses,
    @required this.rbi,
  });

  PitchingStatsModel.fromJson(Map<String, dynamic> json)
      : runs = json['runs'] ?? 0,
        doubles = json['doubles'] ?? 0,
        triples = json['triples'] ?? 0,
        homeRuns = json['homeRuns'] ?? 0,
        strikeOuts = json['strikeOuts'] ?? 0,
        hits = json['hits'] ?? 0,
        atBats = json['atBats'] ?? 0,
        wins = json['wins'] ?? 0,
        losses = json['losses'] ?? 0,
        inningsPitched = json['inningsPitched'] ?? '0.0',
        rbi = json['rbi'] ?? 0;
}
