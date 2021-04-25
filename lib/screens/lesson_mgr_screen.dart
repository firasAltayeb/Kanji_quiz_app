import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanji_quiz_app/model/kanji_model.dart';
import '../widgets/shared/scrollable_container.dart';
import '../widgets/shared/key_text_container.dart';
import '../widgets/shared/building_block_row.dart';
import '../widgets/shared/item_bottom_row.dart';
import '../widgets/shared/top_kanji_row.dart';
import '../widgets/shared/main_app_bar.dart';
import 'package:flutter/material.dart';
import '../main_providers.dart';

class LessonManager extends StatelessWidget {
  static const routeName = '/lesson-screen';

  void _nextKanji(BuildContext context, queueIndex, lessonList) {
    if (queueIndex < lessonList.length - 1) {
      context.read(targetKanjiProvider).state = lessonList[queueIndex + 1];
      context.read(lessonQueueIdxProvider).state++;
    } else {
      context.read(lessonQueueIdxProvider).state = 0;
      lessonList.forEach((element) {
        element.progressLevel = 1;
        element.learningStatus = 'Review';
        element.dateLastLevelChanged = DateTime.now();
        context.read(kanjiListProvider.notifier).editKanji(element);
      });
      context.read(kanjiListProvider.notifier).saveProgress();
      Navigator.pop(context);
    }
  }

  void _previousKanji(BuildContext context, queueIndex, lessonList) {
    context.read(targetKanjiProvider).state = lessonList[queueIndex - 1];
    context.read(lessonQueueIdxProvider).state--;
  }

  void _showHandler(BuildContext context, bool trueFalse) {
    context.read(btnBottomRowProvider).state = trueFalse;
  }

  Widget build(BuildContext context) {
    List<Kanji> _lessonList = ModalRoute.of(context).settings.arguments;

    if (_lessonList.isEmpty) {
      return Scaffold();
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MainAppBar(
        passedTitle: 'Lesson',
        appBar: AppBar(),
      ),
      body: Consumer(builder: (bldCtx, watch, _) {
        final _queueIndex = watch(lessonQueueIdxProvider).state;
        final _showButtonRow = watch(btnBottomRowProvider).state;
        return Column(
          children: [
            TopKanjiRow(
              leftWidgetText: "Prev",
              rightWidgetText: "Next",
              leftWidgetHandler: _queueIndex == 0
                  ? null
                  : () => _previousKanji(bldCtx, _queueIndex, _lessonList),
              rightWidgetHandler: () =>
                  _nextKanji(bldCtx, _queueIndex, _lessonList),
            ),
            SizedBox(
              height: MediaQuery.of(bldCtx).size.height * 0.075,
              child: KeyTextContainer(
                'Keyword: ' + _lessonList[_queueIndex].keyword,
              ),
            ),
            BuildingBlockRow(),
            ScrollableContainer(
              showHandler: (trueFalse) => _showHandler(bldCtx, trueFalse),
            ),
            Expanded(child: SizedBox()),
            if (_showButtonRow)
              MnemonicHandler(
                showHandler: (trueFalse) => _showHandler(bldCtx, trueFalse),
              ),
          ],
        );
      }),
    );
  }
}
