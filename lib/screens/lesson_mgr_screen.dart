import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/shared/scrollable_container.dart';
import '../widgets/shared/key_text_container.dart';
import '../widgets/shared/building_block_row.dart';
import '../widgets/shared/mnemonic_handler.dart';
import '../widgets/shared/top_kanji_row.dart';
import '../widgets/shared/main_app_bar.dart';
import 'package:flutter/material.dart';
import '../main_providers.dart';

class LessonManager extends ConsumerWidget {
  static const routeName = '/lesson-screen';

  void _nextKanji(BuildContext context, queueIndex, lessonList) {
    if (queueIndex < lessonList.length - 1) {
      context.read(lessonQueueIdxProvider).state++;
    } else {
      context.read(lessonQueueIdxProvider).state = 0;
      lessonList.forEach((element) {
        element.progressLevel = 1;
        element.learningStatus = 'Review';
        element.dateLastLevelChanged = DateTime.now();
        context.read(kanjiListProvider.notifier).editKanji(element);
      });
      Navigator.pop(context);
    }
  }

  void _previousKanji(BuildContext context) {
    context.read(lessonQueueIdxProvider).state--;
  }

  void _showHandler(BuildContext context, bool trueFalse) {
    context.read(btnBottomRowProvider).state = trueFalse;
  }

  Widget build(BuildContext bldCtx, ScopedReader watch) {
    final lessonList = watch(lessonListProvider);
    final queueIndex = watch(lessonQueueIdxProvider).state;
    final showButtonRow = watch(btnBottomRowProvider).state;

    if (lessonList.isEmpty) {
      return Scaffold();
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MainAppBar(
        title: 'Lesson Page',
        appBar: AppBar(),
      ),
      body: Column(
        children: [
          TopKanjiRow(
            targetKanji: lessonList[queueIndex],
            leftWidgetText: "Prev",
            rightWidgetText: "Next",
            leftWidgetHandler:
                queueIndex == 0 ? null : () => _previousKanji(bldCtx),
            rightWidgetHandler: () =>
                _nextKanji(bldCtx, queueIndex, lessonList),
          ),
          SizedBox(
            height: MediaQuery.of(bldCtx).size.height * 0.075,
            child: KeyTextContainer(
              'Keyword: ' + lessonList[queueIndex].keyword,
            ),
          ),
          BuildingBlockRow(lessonList[queueIndex]),
          ScrollableContainer(
            itemDetails: lessonList[queueIndex],
            showHandler: (trueFalse) => _showHandler(bldCtx, trueFalse),
          ),
          Expanded(child: SizedBox()),
          if (showButtonRow)
            MnemonicHandler(
              itemDetails: lessonList[queueIndex],
              showHandler: (trueFalse) => _showHandler(bldCtx, trueFalse),
            ),
        ],
      ),
    );
  }
}
