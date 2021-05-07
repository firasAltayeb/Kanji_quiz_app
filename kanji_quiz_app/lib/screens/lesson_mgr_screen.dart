import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanji_quiz_app/model/kanji_model.dart';
import '../widgets/shared/scrollable_container.dart';
import '../widgets/lesson_mgr/lesson_app_bar.dart';
import '../widgets/shared/key_text_container.dart';
import '../widgets/shared/building_block_row.dart';
import '../widgets/shared/item_bottom_row.dart';
import '../widgets/shared/top_kanji_row.dart';
import 'package:flutter/material.dart';
import '../helper_functions.dart';
import '../main_providers.dart';

class LessonManager extends ConsumerWidget {
  static const routeName = '/lesson-screen';

  void _nextKanji(BuildContext context, queueIndex, lessonList) {
    if (queueIndex < lessonList.length - 1) {
      context.read(targetKanjiProvider).state = lessonList[queueIndex + 1];
      context.read(lessonQueueIdxProvider).state++;
    } else {
      wrapLessonSession(context, lessonList, queueIndex);
    }
  }

  void _previousKanji(BuildContext context, queueIndex, lessonList) {
    if (queueIndex > 0) {
      context.read(targetKanjiProvider).state = lessonList[queueIndex - 1];
      context.read(lessonQueueIdxProvider).state--;
    }
  }

  void _showHandler(BuildContext context, bool trueFalse) {
    context.read(btnBottomRowProvider).state = trueFalse;
  }

  Widget build(BuildContext context, ScopedReader watch) {
    List<Kanji> _lessonList = ModalRoute.of(context).settings.arguments;
    final _showButtonRow = watch(btnBottomRowProvider).state;
    final _queueIndex = watch(lessonQueueIdxProvider).state;
    final _showAlert = watch(showAlertProvider).state;

    print('Lesson mgr build called');

    if (_lessonList.isEmpty) {
      return Scaffold();
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: LessonAppBar(
        appBar: AppBar(),
        showAlert: _showAlert,
        lessonList: _lessonList,
        lsnQueueIdx: _queueIndex,
      ),
      body: GestureDetector(
        onHorizontalDragEnd: (DragEndDetails details) {
          if (details.primaryVelocity > 0) {
            _previousKanji(context, _queueIndex, _lessonList);
            print("Swiped left in lesson screen");
          } else if (details.primaryVelocity < 0) {
            _nextKanji(context, _queueIndex, _lessonList);
            print("Swiped right in lesson screen");
          }
        },
        child: Column(
          children: [
            TopKanjiRow(
              leftWidgetText: "Prev",
              rightWidgetText: "Next",
              leftWidgetHandler: _queueIndex == 0
                  ? null
                  : () => _previousKanji(context, _queueIndex, _lessonList),
              rightWidgetHandler: () =>
                  _nextKanji(context, _queueIndex, _lessonList),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.075,
              child: KeyTextContainer(
                'Keyword: ' + _lessonList[_queueIndex].keyword,
              ),
            ),
            BuildingBlockRow(),
            ScrollableContainer(
              showHandler: (trueFalse) => _showHandler(context, trueFalse),
            ),
            Expanded(child: SizedBox()),
            if (_showButtonRow)
              ItemBottomRow(
                lsnQueueIdx: _queueIndex,
                lessonList: _lessonList,
                showResetButton: false,
                showHandler: (trueFalse) => _showHandler(context, trueFalse),
              ),
          ],
        ),
      ),
    );
  }
}
