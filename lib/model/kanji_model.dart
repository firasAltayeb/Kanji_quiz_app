import 'package:flutter/foundation.dart';

class Kanji {
  final String keyword;
  final String itemType;
  final String jlptLevel;
  final int frameNumber;
  final int koohiiNumber;
  final String characterLook;
  final List<String> buildingBlocksLook;
  final List<String> buildingBlockKeywords;
  final List<String> similarCharactersLook;
  final List<String> similarCharactersKeyword;
  final int frequencyInAozora;
  final List<String> kanjiMeanings;

  int progressLevel;
  String mnemonicStory;
  String learningStatus;
  DateTime dateLastLevelChanged;

  Kanji({
    @required this.keyword,
    @required this.itemType,
    @required this.jlptLevel,
    @required this.frameNumber,
    @required this.koohiiNumber,
    @required this.characterLook,
    @required this.buildingBlocksLook,
    @required this.buildingBlockKeywords,
    @required this.similarCharactersLook,
    @required this.similarCharactersKeyword,
    @required this.frequencyInAozora,
    @required this.kanjiMeanings,
    this.progressLevel = 1,
    this.mnemonicStory = "",
    this.learningStatus = "Lesson",
    this.dateLastLevelChanged,
  });
}
