import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:universal_io/io.dart' show Platform;

import 'progress_services.dart';
import 'progress_model.dart';
import 'learing_item_model.dart';

class ItemList extends StateNotifier<List<LearningItem>> {
  ItemList([List<LearningItem> kanjiList]) : super(kanjiList ?? []);

  void updateProgress(List<Progress> progressList) {
    state = [
      for (final kanji in state)
        if (progressList
            .any((element) => element.characterID == kanji.characterID))
          LearningItem(
            keyword: kanji.keyword,
            itemType: kanji.itemType,
            jlptLevel: kanji.jlptLevel,
            frameNumFifth: kanji.frameNumFifth,
            frameNumSixth: kanji.frameNumSixth,
            characterID: kanji.characterID,
            buildingBlocksID: kanji.buildingBlocksID,
            buildingBlockKeywords: kanji.buildingBlockKeywords,
            similarCharactersID: kanji.similarCharactersID,
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

  void editKanji(LearningItem updatedKanji) {
    state = [
      for (final kanji in state)
        if (kanji.characterID == updatedKanji.characterID)
          LearningItem(
            keyword: updatedKanji.keyword,
            itemType: updatedKanji.itemType,
            jlptLevel: updatedKanji.jlptLevel,
            frameNumFifth: updatedKanji.frameNumFifth,
            frameNumSixth: updatedKanji.frameNumSixth,
            characterID: updatedKanji.characterID,
            buildingBlocksID: updatedKanji.buildingBlocksID,
            buildingBlockKeywords: updatedKanji.buildingBlockKeywords,
            similarCharactersID: updatedKanji.similarCharactersID,
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
              characterID: kanji.characterID,
              progressLevel: kanji.progressLevel,
              mnemonicStory: kanji.mnemonicStory,
              recallHistory: kanji.recallHistory,
              learningStatus: kanji.learningStatus,
              practiceHistory: kanji.practiceHistory,
              chosenDifficulty: kanji.chosenDifficulty,
              dateLastLevelChanged: kanji.dateLastLevelChanged,
            ))
        .toList();

    if (Platform.isAndroid) {
      var status = await Permission.storage.status;
      if (status.isGranted) writeProgressUpdate(newProgress);
    }
  }
}
