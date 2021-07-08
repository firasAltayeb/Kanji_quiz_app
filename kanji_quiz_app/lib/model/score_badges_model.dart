import 'package:flutter/foundation.dart';

List<ScoreBadge> scoreBadgesList = [
  ScoreBadge(
    scoreGained: 100,
    amountToGet: 10,
    backGroundAddress: "assets/images/green_badge_template.png",
  ),
  ScoreBadge(
    scoreGained: 100,
    amountToGet: 50,
    backGroundAddress: "assets/images/blue_badge_template.png",
  ),
  ScoreBadge(
    scoreGained: 100,
    amountToGet: 100,
    backGroundAddress: "assets/images/red_badge_template.png",
  ),
  ScoreBadge(
    scoreGained: 100,
    amountToGet: 200,
    backGroundAddress: "assets/images/green_badge_template.png",
  ),
  ScoreBadge(
    scoreGained: 100,
    amountToGet: 300,
    backGroundAddress: "assets/images/blue_badge_template.png",
  ),
  ScoreBadge(
    scoreGained: 100,
    amountToGet: 400,
    backGroundAddress: "assets/images/red_badge_template.png",
  ),
  ScoreBadge(
    scoreGained: 100,
    amountToGet: 500,
    backGroundAddress: "assets/images/green_badge_template.png",
  ),
  ScoreBadge(
    scoreGained: 100,
    amountToGet: 600,
    backGroundAddress: "assets/images/blue_badge_template.png",
  ),
  ScoreBadge(
    scoreGained: 100,
    amountToGet: 700,
    backGroundAddress: "assets/images/red_badge_template.png",
  ),
  ScoreBadge(
    scoreGained: 100,
    amountToGet: 800,
    backGroundAddress: "assets/images/pink_badge_template.png",
  ),
  ScoreBadge(
    scoreGained: 100,
    amountToGet: 900,
    backGroundAddress: "assets/images/pink_badge_template.png",
  ),
  ScoreBadge(
    scoreGained: 100,
    amountToGet: 1000,
    backGroundAddress: "assets/images/pink_badge_template.png",
  ),
];

class ScoreBadge {
  final int scoreGained;
  final int amountToGet;
  final String backGroundAddress;

  ScoreBadge({
    @required this.amountToGet,
    @required this.scoreGained,
    @required this.backGroundAddress,
  });
}
