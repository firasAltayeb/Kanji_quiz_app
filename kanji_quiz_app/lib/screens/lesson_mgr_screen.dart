import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../widgets/shared/scrollable_container.dart';
import '../widgets/lesson_mgr/lesson_app_bar.dart';
import '../widgets/shared/key_text_container.dart';
import '../widgets/shared/building_block_row.dart';
import '../widgets/shared/bottom_row_buttons.dart';
import '../widgets/shared/top_picture_row.dart';
import '../model/study_item_model.dart';
import '../helper_functions.dart';
import '../main_providers.dart';

class LessonManager extends ConsumerWidget {
  static const routeName = '/lesson-screen';

  void _nextKanji(BuildContext context, queueIndex, lessonList) {
    if (queueIndex < lessonList.length - 1) {
      context.read(targetItemProvider).state = lessonList[queueIndex + 1];
      context.read(lessonQueueIdxProvider).state++;
    } else {
      wrapLessonSession(context, lessonList, queueIndex);
    }
  }

  void _previousKanji(BuildContext context, queueIndex, lessonList) {
    if (queueIndex > 0) {
      context.read(targetItemProvider).state = lessonList[queueIndex - 1];
      context.read(lessonQueueIdxProvider).state--;
    }
  }

  void _showHandler(BuildContext context, bool value) {
    context.read(btnBottomRowProvider).state = value;
  }

  Widget build(BuildContext context, ScopedReader watch) {
    List<StudyItem> _lessonList = ModalRoute.of(context).settings.arguments;
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
                _lessonList[_queueIndex].itemType == "Hiragana" ||
                        _lessonList[_queueIndex].itemType == "Katakana"
                    ? 'Reading: ' + _lessonList[_queueIndex].itemReadings[0]
                    : 'Keyword: ' + _lessonList[_queueIndex].keyword,
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
                itemDetailScreen: false,
                showBottomRow: (value) => _showHandler(context, value),
              ),
          ],
        ),
      ),
    );
  }
}
