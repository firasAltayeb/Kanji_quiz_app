import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../widgets/shared/scrollable_container.dart';
import '../widgets/screen_lesson/lesson_app_bar.dart';
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
      context.read(lessonQueueIdxProvider).state++;
    } else {
      wrapLessonSession(context, lessonList, queueIndex);
    }
  }

  void _previousKanji(BuildContext context, queueIndex, lessonList) {
    if (queueIndex > 0) {
      context.read(lessonQueueIdxProvider).state--;
    }
  }

  Widget build(BuildContext context, ScopedReader watch) {
    List<StudyItem> _lessonList = ModalRoute.of(context).settings.arguments;
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;
    final _showButtonRow = watch(showBottomRowProvider).state;
    final _queueIndex = watch(lessonQueueIdxProvider).state;
    final _showAlert = watch(showAlertProvider).state;
    final _targetItem = _lessonList[_queueIndex];

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
      body: Column(
        children: [
          Container(height: _screenHeight * 0.03, color: Colors.grey[300]),
          TopKanjiRow(
            leftWidgetText: "Prev",
            rightWidgetText: "Next",
            targetItem: _targetItem,
            leftWidgetHandler: _queueIndex == 0
                ? null
                : () => _previousKanji(context, _queueIndex, _lessonList),
            rightWidgetHandler: () =>
                _nextKanji(context, _queueIndex, _lessonList),
          ),
          KeyTextContainer(
            passedFunction: () => editDataHandler(
              studyItem: _targetItem,
              buildContext: context,
              forKeyword: true,
            ),
            widgetHeight: _screenHeight * 0.07,
            targetItem: _targetItem,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: BuildingBlockRow(
              screenWidth: _screenWidth,
              screenHeight: _screenHeight,
              targetItem: _targetItem,
            ),
          ),
          ScrollableContainer(
            targetItem: _targetItem,
          ),
          Expanded(child: SizedBox()),
          if (_showButtonRow)
            ItemBottomRow(
              lsnQueueIdx: _queueIndex,
              lessonList: _lessonList,
              itemDetailScreen: false,
            ),
        ],
      ),
    );
  }
}
