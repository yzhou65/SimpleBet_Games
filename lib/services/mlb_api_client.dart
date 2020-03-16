class MLBApiClient {
  static const String baseURL = 'https://statsapi.mlb.com/api/v1';

  String gameScheduleUrl(String date) {
    final queryFields =
        'dates,games,gamePk,gameDate,status,detailedState,venue,teams,score,leagueRecord,wins,losses,team,id,name,isWinner';
    final url =
        '$baseURL/schedule/?sportId=1&startDate=$date&endDate=$date&fields=$queryFields';
    return url;
  }

  String gameLinescoreUrl(String gameId) {
    final url = '$baseURL/game/$gameId/linescore';
    return url;
  }

  String gameBoxscoreUrl(String gameId) {
    final queryFields =
        'teams,record,wins,losses,players,fullName,position,name,type,abbreviation,stats,batting,doubles,triples,homeRuns,strikeOuts,fielding,assists,errors,putOuts,pitching,runs,atBats,hits,rbi,inningsPitched,strikeOuts';
    final url = '$baseURL/game/$gameId/boxscore?fields=$queryFields';
    return url;
  }

  // API Request #1 - Game Schedule
  // Example: https://statsapi.mlb.com/api/v1/schedule/?sportId=1&startDate=10/04/2019&endDate=10/06/2019&fields=dates,games,gamePk,gameDate,status,detailedState,venue,teams,score,leagueRecord,wins,losses,team,name,isWinner
  // Make request to games schedule endpoint and retrieve all games
  // Should return list of schedule games and include team abbreviations

  // API Request #2 - Game Linescore
  // Example: https://statsapi.mlb.com/api/v1/game/599342/linescore
  // Using a gameID make request to the linescore endpoint
  // Should return game line score per inning and include home and away stat totals

  // API Request #3 - Player Game Stats / Boxscore
  // Example: https://statsapi.mlb.com/api/v1/game/599342/boxscore?fields=teams,record,wins,losses,players,fullName,position,name,type,abbreviation,stats,batting,doubles,triples,homeRuns,strikeOuts,fielding,assists,errors,putOuts,pitching,runs,atBats,hits,rbi,inningsPitched,strikeOuts
  // Make request to boxscore endpoint
  // Should return a list of all player's stats from a particular game
  // Players should be categorized under homePitchers, homeBatters, awayPitchers, awayBatters
}
