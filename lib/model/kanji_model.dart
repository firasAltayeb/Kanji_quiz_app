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
    //what happens when item lapse
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

  DateTime nextReviewDate() {
    switch (progressLevel) {
      case 1:
        return dateLastLevelChanged
            .add(Duration(hours: 4 + difficultyFactor()));
        break;
      case 2:
        return dateLastLevelChanged
            .add(Duration(hours: 8 + difficultyFactor()));
        break;
      case 3:
        return dateLastLevelChanged
            .add(Duration(hours: 12 + difficultyFactor()));
        break;
      case 4:
        return dateLastLevelChanged
            .add(Duration(hours: 24 + difficultyFactor()));
        break;
    }
    return dateLastLevelChanged;
  }

  int difficultyFactor() {
    switch (chosenDifficulty) {
      case 1:
        return 0;
        break;
      case 2:
        return -4;
        break;
      case 3:
        return -8;
        break;
      case 4:
        return -12;
        break;
    }
    return 0;
  }

  String difficultyMeaning() {
    switch (chosenDifficulty) {
      case 1:
        return "Easy";
        break;
      case 2:
        return "Moderate";
        break;
      case 3:
        return "Hard";
        break;
      case 4:
        return "Challenging";
        break;
    }
    return "Easy";
  }
}
