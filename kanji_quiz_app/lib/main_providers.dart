import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:universal_io/io.dart' show Platform;

import 'model/study_item_notifier.dart';
import 'model/progress_services.dart';
import 'model/study_item_model.dart';
import 'model/item_static_data.dart';
import 'model/progress_model.dart';

final studyItemProvider =
    StateNotifierProvider<StudyItemList, List<StudyItem>>((ref) {
  return StudyItemList(studyItemStaticData);
});

final itemProgressProvider =
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

final targetItemProvider =
    StateProvider<StudyItem>((ref) => studyItemStaticData[0]);

final practiceQueueIdxProvider = StateProvider<int>((ref) => 0);

final sentenceQueueIdxProvider = StateProvider<int>((ref) => 0);

final reviewQueueIdxProvider = StateProvider<int>((ref) => 0);

final lessonQueueIdxProvider = StateProvider<int>((ref) => 0);

final rtkLessonUnitProvider = StateProvider<int>((ref) => 1);

final sessionScoreProvider = StateProvider<int>((ref) => 0);

final syncNowProvider = StateProvider<int>((ref) => 0);

final sessionChoicesListProvider = StateProvider<List<bool>>((ref) => []);

final overallProgressVisibleProvider = StateProvider<bool>((ref) => true);

final answeredRevealedProvider = StateProvider<bool>((ref) => false);

final showAnsBtnVisibleProvider = StateProvider<bool>((ref) => true);

final lvlColumnVisibleProvider = StateProvider<bool>((ref) => true);

final keywordPressedProvider = StateProvider<bool>((ref) => false);

final showBottomRowProvider = StateProvider<bool>((ref) => true);

final showSrsPopUpProvider = StateProvider<bool>((ref) => false);

final showAlertProvider = StateProvider<bool>((ref) => true);

final notReadyListProvider = Provider<List<StudyItem>>((ref) {
  final mainStudyList = ref.watch(studyItemProvider);
  final itemList =
      mainStudyList.where((item) => item.learningStatus == "NotReady").toList();
  return itemList;
});

final queuedListProvider = Provider<List<StudyItem>>((ref) {
  final mainStudyList = ref.watch(studyItemProvider);
  final toQueueList =
      mainStudyList.where((item) => item.learningStatus == "Queued").toList();
  return toQueueList;
});

final inLessonListProvider = Provider<List<StudyItem>>((ref) {
  final mainStudyList = ref.watch(studyItemProvider);
  final lessonList =
      mainStudyList.where((item) => item.learningStatus == "Lesson").toList();
  return lessonList;
});

final inReviewListProvider = Provider<List<StudyItem>>((ref) {
  final mainStudyList = ref.watch(studyItemProvider);
  final reviewList =
      mainStudyList.where((item) => item.learningStatus == "Review").toList();
  return reviewList;
});

final inPracticeListProvider = Provider<List<StudyItem>>((ref) {
  final mainStudyList = ref.watch(studyItemProvider);
  final practiceList =
      mainStudyList.where((item) => item.learningStatus == "Practice").toList();
  return practiceList;
});

final acquiredListProvider = Provider<List<StudyItem>>((ref) {
  final mainStudyList = ref.watch(studyItemProvider);
  final acquiredList =
      mainStudyList.where((item) => item.learningStatus == "Acquired").toList();
  return acquiredList;
});

final reviewReadyListProvider = Provider<List<StudyItem>>((ref) {
  // ignore: unused_local_variable
  final syncNow = ref.watch(syncNowProvider);
  final reviewList = ref.watch(inReviewListProvider);
  final readyList = reviewList.where((item) {
    return true; // used for testing review screen
    // return DateTime.now().isAfter(item.nextReviewDate()) ? true : false;
  }).toList();
  return readyList;
});

final chosenlvlListProvider =
    Provider.autoDispose.family<List<StudyItem>, int>((ref, level) {
  final mainStudyList = ref.watch(studyItemProvider);
  final chosenlvlList = mainStudyList.where((item) {
    return item.progressLevel == level;
  }).toList();
  return chosenlvlList;
});

final studiedListProvider = Provider<List<StudyItem>>((ref) {
  final mainStudyList = ref.watch(studyItemProvider);
  final studiedList = mainStudyList.where((item) {
    return item.mnemonicStory != "" && item.learningStatus != "Lesson";
  }).toList();
  return studiedList;
});

final reviewedListProvider = Provider<List<StudyItem>>((ref) {
  final mainStudyList = ref.watch(studyItemProvider);
  final reviewedList = mainStudyList.where((item) {
    return item.recallHistory.isNotEmpty;
  }).toList();
  return reviewedList;
});

final practicedListProvider = Provider<List<StudyItem>>((ref) {
  final mainStudyList = ref.watch(studyItemProvider);
  final practicedList = mainStudyList.where((item) {
    return item.practiceHistory.isNotEmpty;
  }).toList();
  return practicedList;
});

final coloredAddressProvider =
    Provider.autoDispose.family<String, StudyItem>((ref, targetItem) {
  switch (targetItem.itemType) {
    case "Hiragana":
      return "assets/images/templates/pink_badge_template.png";
    case "Katakana":
      return "assets/images/templates/pink_badge_template.png";
    case "Radical":
      return "assets/images/templates/blue_badge_template.png";
    case "Primitive":
      return "assets/images/badges/${targetItem.characterID}.png";
    default:
      return "assets/images/templates/red_badge_template.png";
  }
});

final templateAddressProvider =
    Provider.autoDispose.family<String, StudyItem>((ref, targetItem) {
  if (targetItem.itemType == "Primitive") {
    return "assets/images/badges/${targetItem.characterID}.png";
  }
  if (targetItem.progressLevel == 0 && targetItem.mnemonicStory.isEmpty) {
    return "assets/images/templates/grey_badge_template.png";
  }
  switch (targetItem.itemType) {
    case "Hiragana":
      return "assets/images/templates/pink_badge_template.png";
    case "Katakana":
      return "assets/images/templates/pink_badge_template.png";
    case "Radical":
      return "assets/images/templates/blue_badge_template.png";
    default:
      return "assets/images/templates/red_badge_template.png";
  }
});

final buildingBlocksProvider =
    Provider.autoDispose.family<List<StudyItem>, StudyItem>((ref, targetKanji) {
  final mainStudyList = ref.watch(studyItemProvider);
  List<String> targetbuildingBlockIDs = targetKanji.buildingBlocksID;

  List<StudyItem> buildingBlocks = [];
  for (var index = 0; index < targetbuildingBlockIDs.length; index++) {
    buildingBlocks.addAll(mainStudyList
        .where((item) => item.characterID == targetbuildingBlockIDs[index]));
  }

  if (buildingBlocks.length > targetbuildingBlockIDs.length) {
    buildingBlocks.removeWhere((element) => element.itemType == "Katakana");
  }
  return buildingBlocks;
});
