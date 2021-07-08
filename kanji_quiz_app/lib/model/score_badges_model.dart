import 'package:flutter/foundation.dart';

List<ScoreBadge> scoreBadgesList = [
  ScoreBadge(
    scoreGained: 100,
    amountToGet: 10,
    decorationAddress: "assets/images/decorations/bronze_crown.png",
  ),
  ScoreBadge(
    scoreGained: 100,
    amountToGet: 50,
    decorationAddress: "assets/images/decorations/bronze_crown.png",
  ),
  ScoreBadge(
    scoreGained: 100,
    amountToGet: 100,
    decorationAddress: "assets/images/decorations/bronze_crown.png",
  ),
  ScoreBadge(
    scoreGained: 100,
    amountToGet: 200,
    decorationAddress: "assets/images/decorations/bronze_crown.png",
  ),
  ScoreBadge(
    scoreGained: 100,
    amountToGet: 300,
    decorationAddress: "assets/images/decorations/silver_crown.png",
  ),
  ScoreBadge(
    scoreGained: 100,
    amountToGet: 400,
    decorationAddress: "assets/images/decorations/silver_crown.png",
  ),
  ScoreBadge(
    scoreGained: 100,
    amountToGet: 500,
    decorationAddress: "assets/images/decorations/silver_crown.png",
  ),
  ScoreBadge(
    scoreGained: 100,
    amountToGet: 600,
    decorationAddress: "assets/images/decorations/silver_crown.png",
  ),
  ScoreBadge(
    scoreGained: 100,
    amountToGet: 700,
    decorationAddress: "assets/images/decorations/gold_crown.png",
  ),
  ScoreBadge(
    scoreGained: 100,
    amountToGet: 800,
    decorationAddress: "assets/images/decorations/gold_crown.png",
  ),
  ScoreBadge(
    scoreGained: 100,
    amountToGet: 900,
    decorationAddress: "assets/images/decorations/gold_crown.png",
  ),
  ScoreBadge(
    scoreGained: 100,
    amountToGet: 1000,
    decorationAddress: "assets/images/decorations/gold_crown.png",
  ),
];

class ScoreBadge {
  final int scoreGained;
  final int amountToGet;
  final String decorationAddress;

  ScoreBadge({
    @required this.amountToGet,
    @required this.scoreGained,
    @required this.decorationAddress,
  });
}
