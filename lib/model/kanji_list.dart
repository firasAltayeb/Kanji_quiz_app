import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanji_quiz_app/model/kanji_model.dart';
import 'package:kanji_quiz_app/model/progress_model.dart';
import 'package:kanji_quiz_app/model/progress_services.dart';
import 'package:permission_handler/permission_handler.dart';

class KanjiList extends StateNotifier<List<Kanji>> {
  KanjiList([List<Kanji> kanjiList]) : super(kanjiList ?? []);

  void updateProgress(List<Progress> progressList) {
    state = [
      for (final kanji in state)
        if (progressList
            .any((element) => element.characterID == kanji.characterID))
          Kanji(
            keyword: kanji.keyword,
            itemType: kanji.itemType,
            jlptLevel: kanji.jlptLevel,
            frameNumForth: kanji.frameNumForth,
            frameNumSixth: kanji.frameNumSixth,
            characterID: kanji.characterID,
            buildingBlocksLook: kanji.buildingBlocksLook,
            buildingBlockKeywords: kanji.buildingBlockKeywords,
            similarCharactersLook: kanji.similarCharactersLook,
            similarCharactersKeyword: kanji.similarCharactersKeyword,
            frequencyInAozora: kanji.frequencyInAozora,
            kanjiMeanings: kanji.kanjiMeanings,
            progressLevel: progressList
                .firstWhere(
                    (element) => element.characterID == kanji.characterID)
                .progressLevel,
            mnemonicStory: progressList
                .firstWhere(
                    (element) => element.characterID == kanji.characterID)
                .mnemonicStory,
            learningStatus: progressList
                .firstWhere(
                    (element) => element.characterID == kanji.characterID)
                .learningStatus,
            dateLastLevelChanged: progressList
                .firstWhere(
                    (element) => element.characterID == kanji.characterID)
                .dateLastLevelChanged,
            recallHistory: progressList
                .firstWhere(
                    (element) => element.characterID == kanji.characterID)
                .recallHistory,
            practiceHistory: progressList
                .firstWhere(
                    (element) => element.characterID == kanji.characterID)
                .practiceHistory,
            chosenDifficulty: progressList
                .firstWhere(
                    (element) => element.characterID == kanji.characterID)
                .chosenDifficulty,
          )
        else
          kanji,
    ];
  }

  void editKanji(Kanji updatedKanji) {
    state = [
      for (final kanji in state)
        if (kanji.characterID == updatedKanji.characterID)
          Kanji(
            keyword: updatedKanji.keyword,
            itemType: updatedKanji.itemType,
            jlptLevel: updatedKanji.jlptLevel,
            frameNumForth: updatedKanji.frameNumForth,
            frameNumSixth: updatedKanji.frameNumSixth,
            characterID: updatedKanji.characterID,
            buildingBlocksLook: updatedKanji.buildingBlocksLook,
            buildingBlockKeywords: updatedKanji.buildingBlockKeywords,
            similarCharactersLook: updatedKanji.similarCharactersLook,
            similarCharactersKeyword: updatedKanji.similarCharactersKeyword,
            frequencyInAozora: updatedKanji.frequencyInAozora,
            kanjiMeanings: updatedKanji.kanjiMeanings,
            progressLevel: updatedKanji.progressLevel,
            mnemonicStory: updatedKanji.mnemonicStory,
            learningStatus: updatedKanji.learningStatus,
            dateLastLevelChanged: updatedKanji.dateLastLevelChanged,
            recallHistory: updatedKanji.recallHistory,
            practiceHistory: updatedKanji.practiceHistory,
            chosenDifficulty: updatedKanji.chosenDifficulty,
          )
        else
          kanji,
    ];
  }

  void saveProgress() async {
    List<Progress> newProgress = state
        .map((kanji) => Progress(
              keyword: kanji.keyword,
              progressLevel: kanji.progressLevel,
              characterID: kanji.characterID,
              mnemonicStory: kanji.mnemonicStory,
              learningStatus: kanji.learningStatus,
              dateLastLevelChanged: kanji.dateLastLevelChanged,
              recallHistory: kanji.recallHistory,
              practiceHistory: kanji.practiceHistory,
              chosenDifficulty: kanji.chosenDifficulty,
            ))
        .toList();
    var status = await Permission.storage.status;
    if (status.isGranted) {
      print("status.isGranted ${status.isGranted}");
      writeProgressUpdate(newProgress);
    }
  }
}
