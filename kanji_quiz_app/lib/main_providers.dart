import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:universal_io/io.dart' show Platform;

import 'model/study_item_notifier.dart';
import 'model/progress_services.dart';
import 'model/study_item_model.dart';
import 'model/item_static_data.dart';
import 'model/progress_model.dart';

final progressProvider =
    FutureProvider.autoDispose<List<Progress>>((ref) async {
  if (Platform.isAndroid) {
    if (!await Permission.storage.isGranted) {
      await Permission.storage.request();
    }
  }
  final progressList = await readProgressUpdate();
  ref.read(studyItemProvider.notifier).updateProgress(progressList);

  return progressList;
});

final studyItemProvider =
    StateNotifierProvider<ItemList, List<StudyItem>>((ref) {
  return ItemList(studyItemStaticData);
});

final targetItemProvider =
    StateProvider<StudyItem>((ref) => studyItemStaticData[0]);

final showAlertProvider = StateProvider<bool>((ref) => true);

final showSrsPopUpProvider = StateProvider<bool>((ref) => false);

final lvlColumnVisibleProvider = StateProvider<bool>((ref) => true);

final overallProgressVisibleProvider = StateProvider<bool>((ref) => true);

final practiceQueueIdxProvider = StateProvider<int>((ref) => 0);

final sentenceQueueIdxProvider = StateProvider<int>((ref) => 1);

final answeredRevealedProvider = StateProvider<bool>((ref) => false);

final lessonQueueIdxProvider = StateProvider<int>((ref) => 0);

final showScrollConProvider = StateProvider<bool>((ref) => true);

final showBottomRowProvider = StateProvider<bool>((ref) => true);

final reviewQueueIdxProvider = StateProvider<int>((ref) => 0);

final sessionScoreProvider = StateProvider<int>((ref) => 0);

final showAnsBtnVisibleProvider = StateProvider<bool>((ref) => true);

final sessionChoicesListProvider = StateProvider<List<bool>>((ref) => []);

final correctRecallListProvider = StateProvider<List<StudyItem>>((ref) => []);

final incorrectRecallListProvider = StateProvider<List<StudyItem>>((ref) => []);

final syncNowProvider = StateProvider<int>((ref) => 0);

final lessonListProvider = Provider<List<StudyItem>>((ref) {
  final kanjiMainList = ref.watch(studyItemProvider);
  final lessonList = kanjiMainList
      .where((kanjiItem) => kanjiItem.learningStatus == "Lesson")
      .toList();
  return lessonList;
});

final reviewListProvider = Provider<List<StudyItem>>((ref) {
  final kanjiMainList = ref.watch(studyItemProvider);
  final reviewList = kanjiMainList
      .where((kanjiItem) => kanjiItem.learningStatus == "Review")
      .toList();
  return reviewList;
});

final practiceListProvider = Provider<List<StudyItem>>((ref) {
  final kanjiMainList = ref.watch(studyItemProvider);
  final reviewList = kanjiMainList
      .where((kanjiItem) => kanjiItem.learningStatus == "Practice")
      .toList();
  return reviewList;
});

final reviewReadyListProvider = Provider<List<StudyItem>>((ref) {
  // ignore: unused_local_variable
  final syncNow = ref.watch(syncNowProvider);
  final reviewList = ref.watch(reviewListProvider);
  final readyList = reviewList.where((item) {
    return true; // used for testing review screen
    // return DateTime.now().isAfter(item.nextReviewDate()) ? true : false;
  }).toList();
  return readyList;
});

final reviewXlvlListProvider =
    Provider.autoDispose.family<List<StudyItem>, int>((ref, level) {
  final itemMainList = ref.watch(studyItemProvider);
  final reviewLvlList = itemMainList.where((item) {
    return item.progressLevel == level && item.learningStatus == "Review";
  }).toList();
  return reviewLvlList;
});

final practiceXlvlListProvider =
    Provider.autoDispose.family<List<StudyItem>, int>((ref, level) {
  final itemMainList = ref.watch(studyItemProvider);
  final practiceLvlList = itemMainList.where((item) {
    return item.progressLevel == level && item.learningStatus == "Practice";
  }).toList();
  return practiceLvlList;
});

final acquiredListProvider = Provider<List<StudyItem>>((ref) {
  final itemMainList = ref.watch(studyItemProvider);
  final acquiredList = itemMainList.where((item) {
    return item.learningStatus == "Acquired";
  }).toList();
  return acquiredList;
});

final studiedListProvider = Provider<List<StudyItem>>((ref) {
  final itemMainList = ref.watch(studyItemProvider);
  final studiedList = itemMainList.where((item) {
    return item.mnemonicStory != "" && item.learningStatus != "Lesson";
  }).toList();
  return studiedList;
});

final reviewedListProvider = Provider<List<StudyItem>>((ref) {
  final itemMainList = ref.watch(studyItemProvider);
  final reviewedList = itemMainList.where((item) {
    return item.recallHistory.isNotEmpty;
  }).toList();
  return reviewedList;
});

final practicedListProvider = Provider<List<StudyItem>>((ref) {
  final itemMainList = ref.watch(studyItemProvider);
  final practicedList = itemMainList.where((item) {
    return item.practiceHistory.isNotEmpty;
  }).toList();
  return practicedList;
});

final templateAddressProvider =
    Provider.autoDispose.family<String, StudyItem>((ref, targetKanji) {
  switch (targetKanji.itemType) {
    case "Hiragana":
      return "assets/images/templates/pink_badge_template.png";
    case "Katakana":
      return "assets/images/templates/pink_badge_template.png";
    case "Radical":
      return "assets/images/templates/blue_badge_template.png";
    case "Primitive":
      return "assets/images/badges/${targetKanji.characterID}.png";
    default:
      return "assets/images/templates/red_badge_template.png";
  }
});

final buildingBlocksProvider =
    Provider.autoDispose.family<List<StudyItem>, StudyItem>((ref, targetKanji) {
  final studyItemList = studyItemStaticData;
  List<String> targetbuildingBlockIDs = targetKanji.buildingBlocksID;

  List<StudyItem> buildingBlocks = [];
  for (var index = 0; index < targetbuildingBlockIDs.length; index++) {
    buildingBlocks.addAll(studyItemList
        .where((item) => item.characterID == targetbuildingBlockIDs[index]));
  }

  if (buildingBlocks.length > targetbuildingBlockIDs.length) {
    buildingBlocks.removeWhere((element) => element.itemType == "Katakana");
  }
  return buildingBlocks;
});
