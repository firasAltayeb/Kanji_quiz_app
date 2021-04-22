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
  List<String> recallHistory;
  int chosenDifficulty;

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
    this.recallHistory,
    this.chosenDifficulty = 1,
  });

  int newProgressLevel() {
    switch (chosenDifficulty) {
      case 1:
        if (progressLevel > 1) return progressLevel - 1;
        break;
      case 2:
        if (progressLevel > 2) return progressLevel - 2;
        break;
      case 3:
        if (progressLevel > 3) return progressLevel - 3;
        break;
      case 4:
        if (progressLevel > 4) return progressLevel - 4;
        break;
    }
    return 1;
  }
}
