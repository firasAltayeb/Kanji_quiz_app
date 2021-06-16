import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:universal_io/io.dart' show Platform;

import 'progress_services.dart';
import 'progress_model.dart';
import 'study_item_model.dart';

class ItemList extends StateNotifier<List<StudyItem>> {
  ItemList([List<StudyItem> kanjiList]) : super(kanjiList ?? []);

  void updateProgress(List<Progress> progressList) {
    state = [
      for (final item in state)
        if (progressList
            .any((element) => element.characterID == item.characterID))
          StudyItem(
            keyword: item.keyword,
            itemType: item.itemType,
            jlptLevel: item.jlptLevel,
            frameNumFifth: item.frameNumFifth,
            frameNumSixth: item.frameNumSixth,
            characterID: item.characterID,
            buildingBlocksID: item.buildingBlocksID,
            buildingBlockKeywords: item.buildingBlockKeywords,
            similarCharactersID: item.similarCharactersID,
            similarCharactersKeyword: item.similarCharactersKeyword,
            frequencyInAozora: item.frequencyInAozora,
            itemMeanings: item.itemMeanings,
            itemReadings: item.itemReadings,
            progressLevel: progressList
                .firstWhere(
                    (element) => element.characterID == item.characterID)
                .progressLevel,
            mnemonicStory: progressList
                .firstWhere(
                    (element) => element.characterID == item.characterID)
                .mnemonicStory,
            learningStatus: progressList
                .firstWhere(
                    (element) => element.characterID == item.characterID)
                .learningStatus,
            dateLastLevelChanged: progressList
                .firstWhere(
                    (element) => element.characterID == item.characterID)
                .dateLastLevelChanged,
            recallHistory: progressList
                .firstWhere(
                    (element) => element.characterID == item.characterID)
                .recallHistory,
            practiceHistory: progressList
                .firstWhere(
                    (element) => element.characterID == item.characterID)
                .practiceHistory,
            chosenDifficulty: progressList
                .firstWhere(
                    (element) => element.characterID == item.characterID)
                .chosenDifficulty,
          )
        else
          item,
    ];
  }

  void editKanji(StudyItem updatedKanji) {
    state = [
      for (final item in state)
        if (item.characterID == updatedKanji.characterID &&
            item.itemType == updatedKanji.itemType)
          StudyItem(
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
            itemMeanings: updatedKanji.itemMeanings,
            itemReadings: updatedKanji.itemReadings,
            progressLevel: updatedKanji.progressLevel,
            mnemonicStory: updatedKanji.mnemonicStory,
            learningStatus: updatedKanji.learningStatus,
            dateLastLevelChanged: updatedKanji.dateLastLevelChanged,
            recallHistory: updatedKanji.recallHistory,
            practiceHistory: updatedKanji.practiceHistory,
            chosenDifficulty: updatedKanji.chosenDifficulty,
          )
        else
          item,
    ];
  }

  void saveProgress() async {
    List<Progress> newProgress = state
        .map((item) => Progress(
              keyword: item.keyword,
              characterID: item.characterID,
              progressLevel: item.progressLevel,
              mnemonicStory: item.mnemonicStory,
              recallHistory: item.recallHistory,
              learningStatus: item.learningStatus,
              practiceHistory: item.practiceHistory,
              chosenDifficulty: item.chosenDifficulty,
              dateLastLevelChanged: item.dateLastLevelChanged,
            ))
        .toList();

    if (Platform.isAndroid) {
      var status = await Permission.storage.status;
      if (status.isGranted) writeProgressUpdate(newProgress);
    }
  }
}
