import 'package:flutter/material.dart';

class LineScoreModel {
  final List<InningModel> innings;
  final int homeTeamTotalRuns;
  final int awayTeamTotalRuns;
  final int homeTeamTotalHits;
  final int awayTeamTotalHits;
  final int homeTeamTotalErrors;
  final int awayTeamTotalErrors;

  LineScoreModel({
    @required this.innings,
    @required this.homeTeamTotalRuns,
    @required this.awayTeamTotalRuns,
    @required this.homeTeamTotalHits,
    @required this.awayTeamTotalHits,
    @required this.homeTeamTotalErrors,
    @required this.awayTeamTotalErrors,
  });

  LineScoreModel.fromJson(Map<String, dynamic> json)
      : innings = (json['innings'] as List).map((e) => InningModel.fromJson(e)).toList(),
        homeTeamTotalRuns = json['teams']['home']['runs'] ?? 0,
        awayTeamTotalRuns = json['teams']['away']['runs'] ?? 0,
        homeTeamTotalHits = json['teams']['home']['hits'] ?? 0,
        awayTeamTotalHits = json['teams']['away']['hits'] ?? 0,
        homeTeamTotalErrors = json['teams']['home']['errors'] ?? 0,
        awayTeamTotalErrors = json['teams']['away']['errors'] ?? 0;
}

class InningModel {
  final int inningNum;
  final int homeTeamRuns;
  final int homeTeamErrors;
  final int homeTeamHits;
  final int awayTeamRuns;
  final int awayTeamErrors;
  final int awayTeamHits;

  InningModel({
    @required this.inningNum,
    @required this.homeTeamRuns,
    @required this.homeTeamErrors,
    @required this.homeTeamHits,
    @required this.awayTeamRuns,
    @required this.awayTeamErrors,
    @required this.awayTeamHits,
  });

  InningModel.fromJson(Map<String, dynamic> json)
      : inningNum = json['num'],
        homeTeamRuns = json['home']['runs'] ?? 0,
        homeTeamErrors = json['home']['errors'] ?? 0,
        homeTeamHits = json['home']['hits'] ?? 0,
        awayTeamRuns = json['away']['runs'] ?? 0,
        awayTeamErrors = json['away']['errors'] ?? 0,
        awayTeamHits = json['away']['hits'] ?? 0;
}
