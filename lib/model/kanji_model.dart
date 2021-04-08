import 'package:flutter/foundation.dart';

class Kanji {
  final String keyword;
  final String itemType;
  final int frameNumber;
  final int koohiiNumber;
  final String characterLook;
  final List<String> buildingBlocksLook;
  final List<String> buildingBlockKeywords;

  int progressLevel;
  String mnemonicStory;
  String learningStatus;
  DateTime dateLastLevelChanged;

  Kanji({
    @required this.keyword,
    @required this.itemType,
    @required this.frameNumber,
    @required this.koohiiNumber,
    @required this.characterLook,
    @required this.buildingBlocksLook,
    @required this.buildingBlockKeywords,
    this.progressLevel = 1,
    this.mnemonicStory = "",
    this.learningStatus = "Lesson",
    this.dateLastLevelChanged,
  });
}
