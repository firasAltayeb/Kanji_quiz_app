import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/lesson/scrollable_container.dart';
import '../widgets/shared/key_text_container.dart';
import '../widgets/lesson/building_block_row.dart';
import '../widgets/lesson/mnemonic_handler.dart';
import '../widgets/shared/top_kanji_row.dart';
import '../widgets/shared/main_app_bar.dart';
import 'package:flutter/material.dart';
import '../main_providers.dart';

class LessonManager extends ConsumerWidget {
  static const routeName = '/lesson-screen';

  Widget build(BuildContext context, ScopedReader watch) {
    final kanjiList = watch(kanjiListProvider);
    final lessonList = watch(lessonListProvider);
    final queueIndex = watch(queueIndexProvider).state;
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
            kanjiId: lessonList[queueIndex].characterLook,
            kanjiList: kanjiList,
            leftWidgetText: "Prev",
            rightWidgetText: "Next",
            leftWidgetHandler: queueIndex == 0
                ? null
                : () {
                    context.read(queueIndexProvider).state--;
                  },
            rightWidgetHandler: () {
              if (queueIndex < lessonList.length - 1) {
                print("queue index is ${lessonList.length}");
                context.read(queueIndexProvider).state++;
                print("queue index increased to $queueIndex");
              } else {
                lessonList.forEach((element) {
                  element.progressLevel = 1;
                  element.learningStatus = 'Review';
                  element.dateLastLevelChanged = DateTime.now();
                  context.read(kanjiListProvider.notifier).editKanji(element);
                });
                Navigator.pop(context);
              }
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.075,
            child: KeyTextContainer(
              'Keyword: ' + lessonList[queueIndex].keyword,
            ),
          ),
          BuildingBlockRow(
            kanjiList,
            lessonList[queueIndex],
          ),
          ScrollableContainer(
            itemDetails: lessonList[queueIndex],
            showHandler: (trueFalse) {
              context.read(btnBottomRowProvider).state = trueFalse;
            },
          ),
          Expanded(child: SizedBox()),
          if (showButtonRow)
            MnemonicHandler(
              itemDetails: lessonList[queueIndex],
              showHandler: (trueFalse) {
                context.read(btnBottomRowProvider).state = trueFalse;
              },
            ),
        ],
      ),
    );
  }
}
