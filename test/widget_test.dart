// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sb_flutter_take_home/main.dart';
import 'package:sb_flutter_take_home/screens/custom_view.dart';
import 'package:sb_flutter_take_home/models/models.dart';
import 'package:sb_flutter_take_home/screens/schedule_screen.dart';
import 'package:sb_flutter_take_home/constants.dart';

void main() {
  testWidgets('Test PlayerStatsRow', (WidgetTester tester) async {
    await tester.pumpWidget(PlayerStatsRow(
      title: 'HITTERS',
      stats1: 'AB',
      stats2: 'R',
      stats3: 'H',
      stats4: 'RBI',
    ));

    final titleFinder = find.text('HITTERS');
    expect(titleFinder, findsOneWidget);
  });

  testWidgets('Test GameText', (WidgetTester tester) async {
    await tester.pumpWidget(GameText('CHI'));
    final titleFinder = find.text('CHI');

    expect(titleFinder, findsOneWidget);
  });

  testWidgets('Test PlayerItem', (WidgetTester tester) async {
    final BattingStatsModel battingStats = BattingStatsModel(runs: 2, doubles: 2, triples: 0, homeRuns: 1, strikeOuts: 2, hits: 3, atBats: 0, rbi: 3);
    final PitchingStatsModel pitchingStats = PitchingStatsModel(runs: 3, doubles: 1, triples: 0, homeRuns: 2, strikeOuts: 0, hits: 2, atBats: 1, inningsPitched: '1.2', wins: 0, losses: 1, rbi: 3);
    final PlayerModel player = PlayerModel(fullName: 'Nathan Eovaldi', jerseyNumber: '17', positionType: PositionType.pitcher, position: 'P', battingStats: battingStats, pitchingStats: pitchingStats, id: '543135');

    await tester.pumpWidget(PlayerItem(player: player));
    final titleFinder = find.text('Nathan Eovaldi');

    expect(titleFinder, findsOneWidget);
  });

  testWidgets('Test MyApp', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    final raisedButtonFinder = find.byType(RaisedButton);

    /// Test whether a raised is in MyApp
    expect(raisedButtonFinder, findsOneWidget);

    await tester.tap(raisedButtonFinder);
    await tester.pumpAndSettle();

    /// Test whether ScheduleScreen is presented
    expect(find.byType(ScheduleScreen), findsOneWidget);

    final titleFinder = find.text(scheduleScreenTitle);

    /// Test whether presented ScheduleScreen has the correct navigation title
    expect(titleFinder, findsOneWidget);
  });
}
