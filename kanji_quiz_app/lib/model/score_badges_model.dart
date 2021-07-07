import 'package:flutter/foundation.dart';

List<ScoreBadges> scoreBadgesData = [
  ScoreBadges(
    pointToGain: 100,
    labelText: "10",
    backGroundAddress: "assets/images/grey_badge_template.png",
  ),
  ScoreBadges(
    pointToGain: 100,
    labelText: "50",
    backGroundAddress: "assets/images/grey_badge_template.png",
  ),
  ScoreBadges(
    pointToGain: 100,
    labelText: "100",
    backGroundAddress: "assets/images/grey_badge_template.png",
  ),
  ScoreBadges(
    pointToGain: 100,
    labelText: "200",
    backGroundAddress: "assets/images/grey_badge_template.png",
  ),
  ScoreBadges(
    pointToGain: 100,
    labelText: "300",
    backGroundAddress: "assets/images/grey_badge_template.png",
  ),
  ScoreBadges(
    pointToGain: 100,
    labelText: "400",
    backGroundAddress: "assets/images/grey_badge_template.png",
  ),
  ScoreBadges(
    pointToGain: 100,
    labelText: "500",
    backGroundAddress: "assets/images/grey_badge_template.png",
  ),
  ScoreBadges(
    pointToGain: 100,
    labelText: "600",
    backGroundAddress: "assets/images/grey_badge_template.png",
  ),
  ScoreBadges(
    pointToGain: 100,
    labelText: "700",
    backGroundAddress: "assets/images/grey_badge_template.png",
  ),
  ScoreBadges(
    pointToGain: 100,
    labelText: "800",
    backGroundAddress: "assets/images/grey_badge_template.png",
  ),
  ScoreBadges(
    pointToGain: 100,
    labelText: "900",
    backGroundAddress: "assets/images/grey_badge_template.png",
  ),
  ScoreBadges(
    pointToGain: 100,
    labelText: "1000",
    backGroundAddress: "assets/images/grey_badge_template.png",
  ),
];

class ScoreBadges {
  final int pointToGain;
  final String labelText;
  final String backGroundAddress;

  ScoreBadges({
    @required this.labelText,
    @required this.pointToGain,
    @required this.backGroundAddress,
  });
}
