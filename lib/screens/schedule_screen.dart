import 'package:flutter/material.dart';
import 'package:sb_flutter_take_home/services/mlb_api_client.dart';
import 'package:intl/intl.dart';
import 'package:sb_flutter_take_home/models/models.dart';
import 'package:sb_flutter_take_home/services/api_resource.dart';
import 'details_screen.dart';
import 'package:sb_flutter_take_home/constants.dart';

class ScheduleScreen extends StatefulWidget {
  static const routeName = 'scheduleRoute';

  @override
  State<StatefulWidget> createState() => new _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    MLBApiClient apiClient = new MLBApiClient();
    DateTime now = DateTime.now();
    String formattedNow = new DateFormat('MM/dd/yyyy').format(now);
    String endpoint = apiClient.gameScheduleUrl(testDate);

    return Scaffold(
      appBar: AppBar(
        title: Text(scheduleScreenTitle),
      ),
      body: Container(
        alignment: Alignment.center,
        child: ApiResource.shared.buildFuture(endpoint, (data) {
          List<GameModel> games = (data['dates'][0]['games'] as List).map((e) => GameModel.fromJson(e)).toList();
          return ListView.builder(itemBuilder: (BuildContext context, int index) {
            final game = games[index];
            return GestureDetector(
              child: Center(
                child: GameItem(game: game),
              ),
              onTap: () {
                Navigator.pushNamed(context, DetailScreen.routeName, arguments: game);
              },
            );
          },
            itemCount: games.length,
          );
        },

        loadingWidget: CircularProgressIndicator()
        )
      ),
    );
  }
}