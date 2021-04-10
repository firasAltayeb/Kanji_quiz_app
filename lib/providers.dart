import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanji_quiz_app/model/kanji_list.dart';
import 'model/kanji_static_data.dart';
import 'model/progress_services.dart';
import 'model/progress_model.dart';
import 'model/kanji_model.dart';

final progressProvider = FutureProvider<List<Progress>>((ref) async {
  if (!await Permission.storage.isGranted) {
    await Permission.storage.request();
  }
  final progressList = await readProgressUpdate();
  ref.watch(kanjiListProvider.notifier).updateProgress(progressList);

  return progressList;
});

final kanjiListProvider = StateNotifierProvider<KanjiList, List<Kanji>>((ref) {
  return KanjiList(kanjiStaticData);
});
