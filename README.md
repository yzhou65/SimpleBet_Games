# SimpleBet Mobile Developer / Flutter Project Based Assessment

For help getting started with Flutter, view docs
[online documentation](https://flutter.dev/docs), which offer tutorials,
samples, guidance on mobile development, and a full API reference.

## Objective

Write a mobile application in Flutter that demonstrates your ability to develop a native app from design-level requirements. The app will pull information from an MLB API and display screens with game-specific details.

## Time Limit
Someone with some familiarity with Flutter should spend ~3 hours working on the project. 

## Design Reference

Use this provided [InVision prototype](https://projects.invisionapp.com/share/6WUQ90ZR3G4#/screens/392305866) as a reference to build a two-screen, mobile application

## What's Provided
- Partially completed models for Game, Inning, LineScore, BoxScore, Player, and PlayerStats with fromJson methods
- MLBApiClient with methods that generate the necessary URLs from the MLB API
- 3 failing tests in test/model_test.dart and 3 failing tests test/mlb_api_client_test.dart
- Sample json in test/support

## Requirements
Screen 1 (Game Schedule):
- Should call schedule endpoint and display a list of the day's games, team names, logos, and final scores
- On clicking item from list, display the appropriate game details screen and data

Screen 2 (Game Details):
The screen should contain three sections:

1. Final score section
  - Display team scores, names and logos
2. Line score section
  - Using line score endpoint, display runs scored by inning for each team as well as total hits and errors per team
3. Team/Player Game Stats Section
  - Toggle per team for additional batter and pitcher game stats
  - Batter stats  to display:
    - atBats (AB), runs (R), hits (H), rbi (RBI)
  - Pitcher stats to display:
    - inningsPitched (IP), hits (H), runs (r), strikeOuts (K)

Please include a ReadMe that outlines running the project/tests, project specifics, and ways you would improve the project given more time.

Feel free to modify folder structure as you see fit.

## Bonus Points
- Improve / slim down models
- Incorporate player images
- Widget tests

## Assessment Criteria
- Do provided tests pass?
- Does the project run?
- Does screen 1 display game schedule?
- Does screen 2 display stats from the selected game?
- State management
- Code style and quality

## Resources
- [Team Logos](https://www.mlbstatic.com/team-logos/119.svg)  - replace with correct team ID for team’s logo
- [Player Images](https://img.mlbstatic.com/mlb-photos/image/upload/images/headshots/current/60x60/543294@3x.png) - replace with correct player ID for player’s image
- Questions / Comments? Feel free to email manuel@simplebet.io

## Running the project
Environment Configuration:
1. The development IDE of this project is Android Studio 3.1.3, JRE 1.8.0_152
2. The development flutter environment is:
Flutter 1.14.6 • channel beta • https://github.com/flutter/flutter.git
Engine • revision c4229bfbba
Tools • Dart 2.8.0 (build 2.8.0-dev.5.0 fc3af737c7)
3. The project is successfully tested on both iPhone 11 iOS 13.2.2 simulator and Pixel 2 API 28 emulator.


Project execution on simulators:
1. Open the project in Android Studio -> simple_flutter_hiring-master/pubspec.yaml -> Packages get.
2. Choose a simulator and run the project, a home page titled "Simple Flutter Home Page" shows. Clicking on the RaisedButton "See schedule" is supposed to direct users to the list of game results (Home and Team names, logos and final scores) today called TODAY'S GAMES.

    For testing purpose (some dates don't have games), the testDate used is 03/13/2019, changing testDate in schedule_screen.dart line 22 into formattedNow from line 21 dynamically sets the date to be today's date.

3. In schedule screen, clicking on any game card directs users to the Detail screen dynamic titled [homeTeamNameShort] @ [awayTeamNameShort]. Detail screen displays the game result, score section, line score section and team/player game stats section including toggle per team for player image, atBats, runs, hits, rbi, inningsPitched, strikeOuts.


## To be improved:
1. The existing data models are based on inner dictionaries of the raw json response. If given more time, from the perspective of architecture, I would think of an idea to incorporate raw json parsing in api_resource.dart and return generic data model to outside. I'll try to create more data models for parsing the raw json file, then add one more input arguments into services/api_resource.dart's buildFuture() function - a Generic Model, outside can directly access the data model decoded from raw json in api_resource.

2. Implement the network cache for api_resource and define a cache expiration after which api_resource calls for the latest data.

3. Pull-to-refresh for both screens# SimpleBet_Games
