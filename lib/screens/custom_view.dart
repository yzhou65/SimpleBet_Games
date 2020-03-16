import 'package:flutter/material.dart';
import 'package:sb_flutter_take_home/models/models.dart';
import 'package:sb_flutter_take_home/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';

class _TeamInfoColumn extends StatelessWidget {
  final GameModel game;
  final TeamType teamType;
  const _TeamInfoColumn({Key key, @required this.game, @required this.teamType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final teamLogoUrl = teamLogoBaseUrl + (teamType == TeamType.home ? game.homeTeamId.toString() : game.awayTeamId.toString()) + ".svg";
    final teamNameShort = teamType == TeamType.home ? game.homeTeamNameShort : game.awayTeamNameShort;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
            padding: const EdgeInsets.all(8.0),
            child:
            SvgPicture.network(teamLogoUrl,
              width: imageWidth,
              fit: BoxFit.fitWidth,
              placeholderBuilder: (BuildContext context) => Image.asset(placeHolderAssetImage),
            )
        ),
        GameText(teamNameShort)
      ],
    );
  }
}

class GameItem extends StatelessWidget {
  final GameModel game;
  const GameItem({Key key, this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        child: Row(
          textDirection: TextDirection.ltr,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              textDirection: TextDirection.ltr,
              children: <Widget>[
                _TeamInfoColumn(game: game, teamType: TeamType.home,),
                SizedBox(width: 30, child: GameText(game.homeTeamScore.toString(), scale: 1.5,)),
              ],
            ),

            Expanded(
              child: Text(game.gameStatus, textAlign: TextAlign.center, textScaleFactor: 1.5),
            ),


            Row(
              textDirection: TextDirection.ltr,
              children: <Widget>[
//                GameText(game.awayTeamScore.toString(), scale: 2),
                SizedBox(width: 30, child: GameText(game.awayTeamScore.toString(), scale: 1.5, direction: TextDirection.ltr,)),
                _TeamInfoColumn(game: game, teamType: TeamType.away,),
              ],
            )
          ],
        )
    );
  }
}

class GameText extends StatelessWidget {
  final String title;
  final bool isBold;
  final double scale;
  final TextDirection direction;
  const GameText(this.title, {Key key, this.isBold = false, this.scale = 1.0, this.direction = TextDirection.rtl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
        title,
        textDirection: direction,
        style: TextStyle(
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          color: Colors.black
        ),
        textScaleFactor: scale,
    );
  }
}


class PlayerItem extends StatelessWidget {
  final PlayerModel player;
  const PlayerItem({Key key, @required this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String playerImageUrl = playerImageBaseUrl + player.id + ".png";
    PositionType positionType = player.positionType;

    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey[400], width: 0.5))
      ),
      child: Row(
        textDirection: TextDirection.ltr,
        children: <Widget>[
          Container(padding: const EdgeInsets.all(8.0),
            child: CachedNetworkImage(
              width: imageWidth,
              fit: BoxFit.fitWidth,
              imageUrl: playerImageUrl,
              placeholder: (context, url) => Image.asset("lib/assets/placeHolder.png"),
              errorWidget: (context, url, error) => Image.asset("lib/assets/placeHolder.png"),
            )
          ),
          GameText(player.fullName),
          Spacer(),

          PlayerStatsRow(
            stats1: positionType == PositionType.batter ? player.battingStats.atBats.toString() : player.pitchingStats.inningsPitched,
            stats2: positionType == PositionType.batter ? player.battingStats.runs.toString() : player.pitchingStats.hits.toString(),
            stats3: positionType == PositionType.batter ? player.battingStats.hits.toString() : player.pitchingStats.runs.toString(),
            stats4: positionType == PositionType.batter ? player.battingStats.rbi.toString() : player.pitchingStats.strikeOuts.toString(),
          ),
        ]
      ),
    );
  }
}


class PlayerStatsRow extends StatelessWidget {
  final String title, stats1, stats2, stats3, stats4;
  const PlayerStatsRow({Key key,
    this.title,
    @required this.stats1,
    @required this.stats2,
    @required this.stats3,
    @required this.stats4}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(title == null) {
      return Row(
        textDirection: TextDirection.ltr,
        children: <Widget>[
          SizedBox(width: playerStatTextSpace + 10, child: GameText(stats1, )),
          SizedBox(width: playerStatTextSpace - 8,),
          SizedBox(width: playerStatTextSpace, child: GameText(stats2,)),
          SizedBox(width: playerStatTextSpace - 8,),
          SizedBox(width: playerStatTextSpace, child: GameText(stats3,)),
          SizedBox(width: playerStatTextSpace - 8,),
          SizedBox(width: playerStatTextSpace + 10, child: GameText(stats4, )),
        ],
      );
    }

    return Container(
      padding: EdgeInsets.only(top: playerStatTextSpace - 10, bottom: playerStatTextSpace - 10, left: imageWidth),
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey[400], width: 0.5))
      ),
      child: Row(
        textDirection: TextDirection.ltr,
        children: <Widget>[
          GameText(title, isBold: true, scale: 1.0,),
          Spacer(),
          SizedBox(width: playerStatTextSpace + 10, child: GameText(stats1)),
          SizedBox(width: playerStatTextSpace - 8 ,),
          SizedBox(width: playerStatTextSpace, child: GameText(stats2)),
          SizedBox(width: playerStatTextSpace - 8,),
          SizedBox(width: playerStatTextSpace, child: GameText(stats3)),
          SizedBox(width: playerStatTextSpace - 8,),
          SizedBox(width: playerStatTextSpace + 10, child: GameText(stats4,)),
        ],
      ),
    );
  }
}

