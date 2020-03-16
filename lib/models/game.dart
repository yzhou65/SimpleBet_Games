import 'package:flutter/material.dart';

class GameModel {
  // HINT: Map of team MLB ID's to their team abbreviations
   static final Map<int, String> teamIdtoAbbr = {
     109: "ARI",
     144: "ATL",
     110: "BAL",
     111: "BOS",
     112: "CHC",
     113: "CIN",
     114: "CLE",
     115: "COL",
     145: "CWS",
     116: "DET",
     117: "HOU",
     118: "KC",
     108: "LAA",
     119: "LAD",
     146: "MIA",
     158: "MIL",
     142: "MIN",
     121: "NYM",
     147: "NYY",
     133: "OAK",
     143: "PHI",
     134: "PIT",
     135: "SD",
     136: "SEA",
     137: "SF",
     138: "STL",
     139: "TB",
     140: "TEX",
     141: "TOR",
     120: "WSH",
   };

  final int gamePk;
  final String gameDate;
  final String gameStatus;

  final int homeTeamScore;
  final int homeTeamId;
  final String homeTeamNameShort;
  final String homeTeamName;

  final int awayTeamScore;
  final int awayTeamId;
  final String awayTeamNameShort;
  final String awayTeamName;

  GameModel({
    @required this.gamePk,
    @required this.gameDate,
    @required this.gameStatus,
    @required this.homeTeamScore,
    @required this.homeTeamId,
    @required this.homeTeamNameShort,
    @required this.homeTeamName,
    @required this.awayTeamScore,
    @required this.awayTeamId,
    @required this.awayTeamNameShort,
    @required this.awayTeamName
  });

  GameModel.fromJson(Map<String, dynamic> json)
      : gamePk = json['gamePk'],
        gameDate = json['gameDate'],
        gameStatus = json['status']['detailedState'],
        homeTeamScore = json['teams']['home']['score'],
        homeTeamId = json['teams']['home']['team']['id'],
        homeTeamNameShort = teamIdtoAbbr[json['teams']['home']['team']['id']] ?? 'ARI',
        homeTeamName = json['teams']['home']['team']['name'],
        awayTeamScore = json['teams']['away']['score'],
        awayTeamId = json['teams']['away']['team']['id'],
        awayTeamNameShort = teamIdtoAbbr[json['teams']['away']['team']['id']] ?? 'ARI',
        awayTeamName = json['teams']['away']['team']['name'];
}