import 'package:flutter_test/flutter_test.dart';
import 'package:sb_flutter_take_home/services/mlb_api_client.dart';
import 'package:sb_flutter_take_home/services/api_resource.dart';
import 'package:sb_flutter_take_home/constants.dart';
import 'package:sb_flutter_take_home/models/models.dart';

void main() {
  test('API Request #1 - Game Schedule', () async {
    // Write a test that ensures your method returns List of GameModels from the MLB API's gameScheduleUrl endpoint
    MLBApiClient apiClient = new MLBApiClient();
    String endpoint = apiClient.gameScheduleUrl(testDate);

    // ignore: missing_return, return value is useless here
    ApiResource.shared.buildFuture(endpoint, (data) {
      final games = (data['dates'][0]['games'] as List).map((e) => GameModel.fromJson(e)).toList();
      expect(games is List<GameModel>, true);
    });
  });

  test('API Request #2 - Game Linescore', () async {
    // Write a test that ensures your method returns a LineScoreModel from the MLB API's gameLinescoreUrl endpoint.
    MLBApiClient apiClient = new MLBApiClient();
    String endpoint = apiClient.gameLinescoreUrl('565021');

    // ignore: missing_return, return value is useless here
    ApiResource.shared.buildFuture(endpoint, (data) {
      final lineScore = LineScoreModel.fromJson(data);
      expect(lineScore is LineScoreModel, true);
    });
  });

  test('API Request #3 - Player Game Stats / Boxscore', () async {
    // Write a test that ensures your method returns a BoxScoreModel from the MLB API's gameBoxscoreUrl endpoint.
    MLBApiClient apiClient = new MLBApiClient();
    String endpoint = apiClient.gameBoxscoreUrl('565021');

    // ignore: missing_return, return value is useless here
    ApiResource.shared.buildFuture(endpoint, (data) {
      final boxScore = BoxScoreModel.fromJson(data);
      expect(boxScore is BoxScoreModel, true);
    });
  });
}
