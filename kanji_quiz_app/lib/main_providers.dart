import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:universal_io/io.dart' show Platform;

import 'model/kanji_list_notifier.dart';
import 'model/kanji_static_data.dart';
import 'model/progress_services.dart';
import 'model/progress_model.dart';
import 'model/kanji_model.dart';

final progressProvider =
    FutureProvider.autoDispose<List<Progress>>((ref) async {
  if (Platform.isAndroid) {
    if (!await Permission.storage.isGranted) {
      await Permission.storage.request();
    }
  }
  final progressList = await readProgressUpdate();
  ref.read(kanjiListProvider.notifier).updateProgress(progressList);

  return progressList;
});

final kanjiListProvider = StateNotifierProvider<KanjiList, List<Kanji>>((ref) {
  return KanjiList(kanjiStaticData);
});

final targetKanjiProvider = StateProvider<Kanji>((ref) => kanjiStaticData[0]);

final showAlertProvider = StateProvider<bool>((ref) => true);

final showSrsPopUpProvider = StateProvider<bool>((ref) => false);

final lvlColumnVisibleProvider = StateProvider<bool>((ref) => true);

final practiceQueueIdxProvider = StateProvider<int>((ref) => 0);

final sentenceQueueIdxProvider = StateProvider<int>((ref) => 1);

final lessonQueueIdxProvider = StateProvider<int>((ref) => 0);

final btnBottomRowProvider = StateProvider<bool>((ref) => true);

final reviewQueueIdxProvider = StateProvider<int>((ref) => 0);

final sessionScoreProvider = StateProvider<int>((ref) => 0);

final showAnsBtnVisibleProvider = StateProvider<bool>((ref) => true);

final answerChoiceListProvider = StateProvider<List<bool>>((ref) => []);

final correctRecallListProvider = StateProvider<List<Kanji>>((ref) => []);

final incorrectRecallListProvider = StateProvider<List<Kanji>>((ref) => []);

final syncNowProvider = StateProvider<int>((ref) => 0);

final lessonListProvider = Provider<List<Kanji>>((ref) {
  final kanjiMainList = ref.watch(kanjiListProvider);
  final lessonList = kanjiMainList
      .where((kanjiItem) => kanjiItem.learningStatus == "Lesson")
      .toList();
  return lessonList;
});

final reviewListProvider = Provider<List<Kanji>>((ref) {
  final kanjiMainList = ref.watch(kanjiListProvider);
  final reviewList = kanjiMainList
      .where((kanjiItem) => kanjiItem.learningStatus == "Review")
      .toList();
  return reviewList;
});

final practiceListProvider = Provider<List<Kanji>>((ref) {
  final kanjiMainList = ref.watch(kanjiListProvider);
  final reviewList = kanjiMainList
      .where((kanjiItem) => kanjiItem.learningStatus == "Practice")
      .toList();
  return reviewList;
});

final reviewReadyListProvider = Provider<List<Kanji>>((ref) {
  // ignore: unused_local_variable
  final syncNow = ref.watch(syncNowProvider);
  final reviewList = ref.watch(reviewListProvider);
  final readyList = reviewList.where((kanjiItem) {
    return true; // used for testing review screen
    // return DateTime.now().isAfter(kanjiItem.nextReviewDate()) ? true : false;
  }).toList();
  return readyList;
});

final srsXlvlListProvider =
    Provider.autoDispose.family<List<Kanji>, int>((ref, level) {
  final kanjiMainList = ref.watch(kanjiListProvider);
  final srsLvlList = kanjiMainList.where((item) {
    if (level >= 6 && item.learningStatus == "Lesson") {
      return false;
    }
    return item.progressLevel == level;
  }).toList();
  return srsLvlList;
});

final templateAddressProvider =
    Provider.autoDispose.family<String, Kanji>((ref, targetKanji) {
  switch (targetKanji.itemType) {
    case "Radical":
      return "assets/images/blue_badge_template.png";
    case "Primitive":
      return "assets/images/badges/${targetKanji.characterID}.png";
    default:
      return "assets/images/red_badge_template.png";
  }
});

final buildingBlocksProvider =
    Provider.autoDispose.family<List<Kanji>, Kanji>((ref, targetKanji) {
  final kanjiList = kanjiStaticData;
  List<String> bbkeywords = targetKanji.buildingBlockKeywords;

  List<Kanji> buildingBlocks = kanjiList
      .where((element) => bbkeywords.contains(element.keyword))
      .toList();

  return buildingBlocks;
});
