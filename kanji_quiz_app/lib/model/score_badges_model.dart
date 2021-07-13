import 'package:flutter/foundation.dart';

List<ScoreBadge> scoreBadgesList = [
  ScoreBadge(
    scoreGained: 100,
    amountToGet: 10,
    decorationAddress: "assets/images/decorations/bronze_crown.png",
  ),
  ScoreBadge(
    scoreGained: 100,
    amountToGet: 25,
    decorationAddress: "assets/images/decorations/bronze_crown.png",
  ),
  ScoreBadge(
    scoreGained: 100,
    amountToGet: 50,
    decorationAddress: "assets/images/decorations/bronze_crown.png",
  ),
  ScoreBadge(
    scoreGained: 100,
    amountToGet: 75,
    decorationAddress: "assets/images/decorations/bronze_crown.png",
  ),
  ScoreBadge(
    scoreGained: 100,
    amountToGet: 100,
    decorationAddress: "assets/images/decorations/silver_crown.png",
  ),
  ScoreBadge(
    scoreGained: 100,
    amountToGet: 150,
    decorationAddress: "assets/images/decorations/silver_crown.png",
  ),
  ScoreBadge(
    scoreGained: 100,
    amountToGet: 200,
    decorationAddress: "assets/images/decorations/silver_crown.png",
  ),
  ScoreBadge(
    scoreGained: 100,
    amountToGet: 350,
    decorationAddress: "assets/images/decorations/silver_crown.png",
  ),
  ScoreBadge(
    scoreGained: 100,
    amountToGet: 500,
    decorationAddress: "assets/images/decorations/gold_crown.png",
  ),
  ScoreBadge(
    scoreGained: 100,
    amountToGet: 650,
    decorationAddress: "assets/images/decorations/gold_crown.png",
  ),
  ScoreBadge(
    scoreGained: 100,
    amountToGet: 800,
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
