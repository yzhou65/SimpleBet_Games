import 'dart:io';
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:sb_flutter_take_home/models/models.dart';

void main() {
  test('Parses game schedule json', () async {
    final file = File('test/support/schedule.json');
    final json = jsonDecode(await file.readAsString());
    final game = GameModel.fromJson(json['dates'][0]['games'][0]);

    expect(game.gameDate, '2019-10-04T18:05:00Z');
    expect(game.homeTeamNameShort, 'HOU');
    expect(game.awayTeamNameShort, 'TB');
  });

  test('Parses line score json', () async {
    final file = File('test/support/line_score.json');
    final json = jsonDecode(await file.readAsString());
    final lineScore = LineScoreModel.fromJson(json);

    expect(lineScore.innings.length, 9);
    expect(lineScore.innings[0].inningNum, 1);
    expect(lineScore.homeTeamTotalRuns, 10);
    expect(lineScore.homeTeamTotalHits, 8);
    expect(lineScore.awayTeamTotalRuns, 4);
    expect(lineScore.awayTeamTotalHits, 7);
  });

  test('Parses player game stats json', () async {
    final file = File('test/support/box_score.json');
    final json = jsonDecode(await file.readAsString());
    final boxScore = BoxScoreModel.fromJson(json);

    expect(boxScore.homeBatters.length, greaterThan(1));
    expect(boxScore.homePitchers.length, greaterThan(1));
    expect(boxScore.awayBatters.length, greaterThan(1));
    expect(boxScore.awayPitchers.length, greaterThan(1));

    final player = boxScore.homeBatters[0];

    expect(player.positionType, PositionType.batter);
    expect(player.battingStats.atBats != null, true);
  });
}
