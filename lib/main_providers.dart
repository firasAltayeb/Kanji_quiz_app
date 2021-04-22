import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanji_quiz_app/model/kanji_list.dart';
import 'model/kanji_static_data.dart';
import 'model/progress_services.dart';
import 'model/progress_model.dart';
import 'model/kanji_model.dart';

final progressProvider =
    FutureProvider.autoDispose<List<Progress>>((ref) async {
  if (!await Permission.storage.isGranted) {
    await Permission.storage.request();
  }
  final progressList = await readProgressUpdate();
  ref.read(kanjiListProvider.notifier).updateProgress(progressList);

  return progressList;
});

final kanjiListProvider = StateNotifierProvider<KanjiList, List<Kanji>>((ref) {
  return KanjiList(kanjiStaticData);
});

final targetKanjiProvider = StateProvider<Kanji>((ref) => kanjiStaticData[0]);

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

final reviewReadyListProvider = Provider<List<Kanji>>((ref) {
  final syncNow = ref.watch(syncNowProvider);
  final reviewList = ref.watch(reviewListProvider);
  final readyList =
      reviewList.where((kanjiItem) => isReviewReady(kanjiItem)).toList();
  return readyList;
});

bool isReviewReady(Kanji kanjiItem) {
  if (kanjiItem.learningStatus == "Review")
    switch (kanjiItem.progressLevel) {
      case 1:
        if (kanjiItem.dateLastLevelChanged
            .isBefore(DateTime.now().subtract(Duration(seconds: 10))))
          return true;
        break;
      case 2:
        if (kanjiItem.dateLastLevelChanged
            .isBefore(DateTime.now().subtract(Duration(seconds: 20))))
          return true;
        break;
      case 3:
        if (kanjiItem.dateLastLevelChanged
            .isBefore(DateTime.now().subtract(Duration(seconds: 30))))
          return true;
        break;
      case 4:
        if (kanjiItem.dateLastLevelChanged
            .isBefore(DateTime.now().subtract(Duration(seconds: 45))))
          return true;
        break;
      default:
        return false;
        break;
    }
  return false;
}

final srsXlvlListProvider =
    Provider.autoDispose.family<List<Kanji>, int>((ref, level) {
  final kanjiMainList = ref.watch(kanjiListProvider);
  final srsLvlList = kanjiMainList
      .where((kanjiItem) => kanjiItem.progressLevel == level)
      .toList();
  return srsLvlList;
});

final templateAddressProvider =
    Provider.autoDispose.family<String, Kanji>((ref, targetKanji) {
  switch (targetKanji.itemType) {
    case "Radical":
      return "assets/images/blue_badge_template.png";
    case "Primitive":
      return targetKanji.characterLook;
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
