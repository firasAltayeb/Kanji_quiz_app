import 'package:flutter/foundation.dart';

class Kanji {
  final String keyword;
  final String itemType;
  final String jlptLevel;
  final int frameNumFifth;
  final int frameNumSixth;
  final String characterID;
  final List<String> buildingBlocksLook;
  final List<String> buildingBlockKeywords;
  final List<String> similarCharactersID;
  final List<String> similarCharactersKeyword;
  final int frequencyInAozora;
  final List<String> kanjiMeanings;

  int progressLevel;
  String mnemonicStory;
  String learningStatus;
  List<String> recallHistory;
  List<String> practiceHistory;
  DateTime dateLastLevelChanged;
  int chosenDifficulty;

  Kanji({
    @required this.keyword,
    @required this.itemType,
    @required this.jlptLevel,
    @required this.frameNumFifth,
    @required this.frameNumSixth,
    @required this.characterID,
    @required this.buildingBlocksLook,
    @required this.buildingBlockKeywords,
    @required this.similarCharactersID,
    @required this.similarCharactersKeyword,
    @required this.frequencyInAozora,
    @required this.kanjiMeanings,
    this.progressLevel = 0,
    this.mnemonicStory = "",
    this.learningStatus = "Lesson",
    this.recallHistory,
    this.practiceHistory,
    this.dateLastLevelChanged,
    this.chosenDifficulty = 1,
  });

  int lapsePenalty() {
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
    }
    return dateLastLevelChanged.add(Duration(hours: 24 + difficultyFactor()));
  }

  int difficultyFactor() {
    switch (chosenDifficulty) {
      case 1:
        return 0;
        break;
      case 2:
        return -2;
        break;
      case 3:
        return -4;
        break;
    }
    return -6;
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
    }
    return "Challenging";
  }

  void difficultyAdjustment() {
    recallHistory.add("Incorrect");
    var lastIndex = recallHistory.lastIndexOf("Incorrect");
    switch (chosenDifficulty) {
      case 1:
        if (recallHistory.length > 1) {
          if ("Incorrect" == recallHistory[lastIndex - 1]) {
            chosenDifficulty++;
          }
        }
        break;
      case 2:
        if (recallHistory.length > 2) {
          if (("Incorrect" == recallHistory[lastIndex - 1]) &&
              ("Incorrect" == recallHistory[lastIndex - 2])) {
            chosenDifficulty++;
          }
        }
        break;
      case 3:
        if (recallHistory.length > 3) {
          if (("Incorrect" == recallHistory[lastIndex - 1]) &&
              ("Incorrect" == recallHistory[lastIndex - 2]) &&
              ("Incorrect" == recallHistory[lastIndex - 3])) {
            chosenDifficulty++;
          }
        }
        break;
    }
  }
}
