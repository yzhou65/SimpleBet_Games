import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sb_flutter_take_home/services/mlb_api_client.dart';
import 'package:sb_flutter_take_home/models/models.dart';
import 'package:sb_flutter_take_home/services/api_resource.dart';

class DetailScreen extends StatefulWidget {
  static const routeName = 'detail_route';
  @override
  State<StatefulWidget> createState() => new _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int segmentedControlValue = 0;

  @override
  Widget build(BuildContext context) {
    final GameModel game = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('${game.homeTeamNameShort} @ ${game.awayTeamNameShort}'),
      ),
      body: ListView(
        children: <Widget>[
          GameItem(game: game),
          SizedBox(height: 20,), // SizedBox
          _ScoreGridView(game: game),
          SizedBox(height: 40,), // SizedBox
          _ScorePageView(game: game),
        ],
      )
    );
  }
}


/// Grid view for both teams' inning, hits, runs, hits and errors
class _ScoreGridView extends StatelessWidget {
  final GameModel game;
  const _ScoreGridView({Key key, this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MLBApiClient apiClient = new MLBApiClient();
    String lineScoreEndpoint = apiClient.gameLinescoreUrl(game.gamePk.toString());
    return ApiResource.shared.buildFuture(lineScoreEndpoint,
      (data) {
        List<InningModel> innings = (data['innings'] as List).map((e) =>
            InningModel.fromJson(e)).toList();
        LineScoreModel score = LineScoreModel.fromJson(data);

        return GridView.builder(
          shrinkWrap:true,
          physics: ScrollPhysics(),
          padding: EdgeInsets.only(left: 16, right: 16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: innings.length + 4,
              childAspectRatio: 1),
          itemCount: (innings.length + 4) * 3,
          itemBuilder: (context, index) {
            final resultGridGameTexts = _getLineScoreResultTexts(innings, score, game);
            return Container(
              child: Container(
                color: index < innings.length + 4 ? Colors.grey[300] : Colors.white,
                child: Center(child: resultGridGameTexts[index]),
              ),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[400], width: 0.5)
              ),
            );
          }
        );
      },
    );
  }

  /// Get the result for each grid
  List<GameText> _getLineScoreResultTexts(List<InningModel> innings, LineScoreModel score, GameModel game) {
    int inningLength = innings.length;
    int rows = 3;
    int columns = inningLength + 4;
    int total = rows * columns;
    var resultGridGameTexts = new List.filled(total, GameText(""));

    for(var i = 1; i < total; i++) {
      if(i <= inningLength + 3) {
        if (i <= inningLength) {
          resultGridGameTexts[i] = GameText(i.toString());
        }
        else if(i == inningLength + 1) {
          resultGridGameTexts[i] = GameText('R', isBold: true);
        }
        else if(i == inningLength + 2) {
          resultGridGameTexts[i] = GameText('H', isBold: true);
        }
        else if(i == inningLength + 3) {
          resultGridGameTexts[i] = GameText('E', isBold: true);
        }
      }
      else {
        if(i ~/ columns == 1) {
          if (i % columns == 0) {
            resultGridGameTexts[i] = GameText(game.homeTeamNameShort, isBold: true, scale: 0.7);
          }
          else if (i % columns == inningLength + 1) {
            resultGridGameTexts[i] = GameText(score.homeTeamTotalRuns.toString(), isBold: true,);
          }
          else if (i % columns == inningLength + 2) {
            resultGridGameTexts[i] = GameText(score.homeTeamTotalHits.toString(), isBold: true,);
          }
          else if (i % columns == inningLength + 3) {
            resultGridGameTexts[i] = GameText(score.homeTeamTotalErrors.toString(), isBold: true,);
          } else {
            resultGridGameTexts[i] = GameText(innings[i % columns - 1].homeTeamRuns.toString());
          }
        }
        else if(i ~/ columns == 2) {
          if (i % columns == 0) {
            resultGridGameTexts[i] = GameText(game.awayTeamNameShort, isBold: true, scale: 0.7);
          }
          else if (i % columns == inningLength + 1) {
            resultGridGameTexts[i] = GameText(score.awayTeamTotalRuns.toString(), isBold: true, );
          }
          else if (i % columns == inningLength + 2) {
            resultGridGameTexts[i] = GameText(score.awayTeamTotalHits.toString(), isBold: true,);
          }
          else if (i % columns == inningLength + 3) {
            resultGridGameTexts[i] = GameText(score.awayTeamTotalErrors.toString(), isBold: true,);
          } else {
            resultGridGameTexts[i] = GameText(innings[i % columns - 1].awayTeamRuns.toString());
          }
        }
      }
    }
    return resultGridGameTexts;
  }
}


/// Toggle per team for additional batter and pitcher stats
class _ScorePageView extends StatefulWidget {
  final GameModel game;
  const _ScorePageView({Key key, this.game}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _ScorePageState();
}

class _ScorePageState extends State<_ScorePageView> {
  int _selectedControlIndex = 0;

  @override
  Widget build(BuildContext context) {
    final game = widget.game;
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Container(
          child: CupertinoSegmentedControl<int>(
            selectedColor: Theme.of(context).primaryColor,
            borderColor: Theme.of(context).primaryColor,
            children: {
              0: Text(game.homeTeamNameShort, textDirection: TextDirection.ltr,),
              1: Text(game.awayTeamNameShort, textDirection: TextDirection.ltr,),
            },
            onValueChanged: (int val) {
              setState(() {
                _selectedControlIndex = val;
              });
            },
            groupValue: _selectedControlIndex,
          ),
        ),

        SizedBox(height: 30), // SizedBox

        _selectedControlIndex == 0 ? _BoxScoreColumnView(team: TeamType.home, game: game) : _BoxScoreColumnView(team: TeamType.away, game: game)
      ],
    );
  }
}


/// Container for hitting and pitching stats listViews
class _BoxScoreColumnView extends StatelessWidget {
  final TeamType team;
  final GameModel game;
  const _BoxScoreColumnView({Key key, this.team, this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GameText('Hitting', scale: 1.5),
        _BoxScoreListView(teamType: team, positionType: PositionType.batter, game: game),

        SizedBox(height: 20),

        GameText('Pitching', scale: 1.5),
        _BoxScoreListView(teamType: team, positionType: PositionType.pitcher, game: game),
      ]
    );
  }
}


class _BoxScoreListView extends StatelessWidget {
  final TeamType teamType;
  final PositionType positionType;
  final GameModel game;
  final double textScale = 0.8;
  const _BoxScoreListView({Key key, this.teamType, this.positionType, this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MLBApiClient apiClient = new MLBApiClient();
    String boxScoreEndpoint = apiClient.gameBoxscoreUrl(game.gamePk.toString());

    return ApiResource.shared.buildFuture(
        boxScoreEndpoint,
        (data) {
          final teamJson = data['teams'][teamType.toString().split('.').last];
          final team = TeamModel.fromJson(teamJson, teamType);
          List<PlayerModel> players = _getPositionPlayers(positionType, team);
          int rows = players.length + 2;
          return ListView.builder(
            padding: EdgeInsets.all(16.0),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              if(index == 0) {
                return PlayerStatsRow(
                  title: positionType == PositionType.batter ? 'HITTERS' : 'PITCHERS',
                  stats1: positionType == PositionType.batter ? 'AB' : 'IP',
                  stats2: positionType == PositionType.batter ? 'R' : 'H',
                  stats3: positionType == PositionType.batter ? 'H' : 'R',
                  stats4: positionType == PositionType.batter ? 'RBI' : 'K',
                );
              }
              else if (index == rows - 1) {
                return PlayerStatsRow(
                  title: 'TEAM',
                  stats1: positionType == PositionType.batter ? team.battingStats.atBats.toString() : team.pitchingStats.inningsPitched,
                  stats2: positionType == PositionType.batter ? team.battingStats.runs.toString() : team.pitchingStats.hits.toString(),
                  stats3: positionType == PositionType.batter ? team.battingStats.hits.toString() : team.pitchingStats.runs.toString(),
                  stats4: positionType == PositionType.batter ? team.battingStats.rbi.toString() : team.pitchingStats.strikeOuts.toString(),
                );
              }
              return PlayerItem(player:  players[index - 1]);
            },
            itemCount: rows,
          );
        }
    );
  }

  List<PlayerModel> _getPositionPlayers(PositionType positionType, TeamModel team) {
    switch (positionType) {
      case PositionType.batter:
        return team.batters;
      case PositionType.pitcher:
        return team.pitchers;
      default:
        return [];
    }
  }
}