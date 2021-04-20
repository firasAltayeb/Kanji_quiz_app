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
        if (progressList.any((element) => element.keyword == kanji.keyword))
          Kanji(
            keyword: kanji.keyword,
            itemType: kanji.itemType,
            jlptLevel: kanji.jlptLevel,
            frameNumber: kanji.frameNumber,
            koohiiNumber: kanji.koohiiNumber,
            characterLook: kanji.characterLook,
            buildingBlocksLook: kanji.buildingBlocksLook,
            buildingBlockKeywords: kanji.buildingBlockKeywords,
            similarCharactersLook: kanji.similarCharactersLook,
            similarCharactersKeyword: kanji.similarCharactersKeyword,
            frequencyInAozora: kanji.frequencyInAozora,
            kanjiMeanings: kanji.kanjiMeanings,
            progressLevel: progressList
                .firstWhere((element) => element.keyword == kanji.keyword)
                .progressLevel,
            mnemonicStory: progressList
                .firstWhere((element) => element.keyword == kanji.keyword)
                .mnemonicStory,
            learningStatus: progressList
                .firstWhere((element) => element.keyword == kanji.keyword)
                .learningStatus,
            dateLastLevelChanged: progressList
                .firstWhere((element) => element.keyword == kanji.keyword)
                .dateLastLevelChanged,
            incorrectReviewCounter: progressList
                .firstWhere((element) => element.keyword == kanji.keyword)
                .incorrectReviewCounter,
            chosenDifficulty: progressList
                .firstWhere((element) => element.keyword == kanji.keyword)
                .chosenDifficulty,
          )
        else
          kanji,
    ];
  }

  void editKanji(Kanji updatedKanji) {
    state = [
      for (final kanji in state)
        if (kanji.keyword == updatedKanji.keyword)
          Kanji(
            keyword: updatedKanji.keyword,
            itemType: updatedKanji.itemType,
            jlptLevel: updatedKanji.jlptLevel,
            frameNumber: updatedKanji.frameNumber,
            koohiiNumber: updatedKanji.koohiiNumber,
            characterLook: updatedKanji.characterLook,
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
            incorrectReviewCounter: updatedKanji.incorrectReviewCounter,
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
              mnemonicStory: kanji.mnemonicStory,
              learningStatus: kanji.learningStatus,
              dateLastLevelChanged: kanji.dateLastLevelChanged,
              incorrectReviewCounter: kanji.incorrectReviewCounter,
              chosenDifficulty: kanji.chosenDifficulty,
            ))
        .toList();
    var status = await Permission.storage.status;
    if (status.isGranted) {
      print("status.isGranted ${status.isGranted}");
      writeProgressUpdate(newProgress);
    }
  }

  // void _allocateLists(kanjiList) {
  //   _lessonList.clear();
  //   _reviewList.clear();
  //   for (var i = 0; i < kanjiList.length; i++) {
  //     if (kanjiList[i].learningStatus == 'Lesson') {
  //       _lessonList.add(kanjiList[i]);
  //     } else if (kanjiList[i].learningStatus == 'Review') {
  //       _addToReview(kanjiList[i]);
  //     }
  //   }
  //   print('allocate lists called');
  //   print('LessonList size is ' + '${_lessonList.length}');
  //   print('ReviewList size is ' + '${_reviewList.length}');
  // }

  // void _addToReview(Progress kanjiItem) {
  //   switch (kanjiItem.progressLevel) {
  //     case 1:
  //       if (kanjiItem.dateLastLevelChanged
  //           .isBefore(DateTime.now().subtract(Duration(seconds: 4))))
  //         _reviewList.add(kanjiItem);
  //       break;
  //     case 2:
  //       if (kanjiItem.dateLastLevelChanged
  //           .isBefore(DateTime.now().subtract(Duration(hours: 12))))
  //         _reviewList.add(kanjiItem);
  //       break;
  //     case 3:
  //       if (kanjiItem.dateLastLevelChanged
  //           .isBefore(DateTime.now().subtract(Duration(days: 2))))
  //         _reviewList.add(kanjiItem);
  //       break;
  //     case 4:
  //       if (kanjiItem.dateLastLevelChanged
  //           .isBefore(DateTime.now().subtract(Duration(days: 4))))
  //         _reviewList.add(kanjiItem);
  //       break;
  //     default:
  //       break;
  //   }
  // }
  //
}
