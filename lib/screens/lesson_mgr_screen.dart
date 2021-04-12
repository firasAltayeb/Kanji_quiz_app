import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/lesson/scrollable_container.dart';
import '../widgets/shared/key_text_container.dart';
import '../widgets/lesson/building_block_row.dart';
import '../widgets/lesson/mnemonic_handler.dart';
import '../widgets/shared/top_kanji_row.dart';
import '../widgets/shared/main_app_bar.dart';
import 'package:flutter/material.dart';
import '../main_providers.dart';

class LessonManager extends StatefulWidget {
  static const routeName = '/lesson-screen';

  @override
  _LessonManagerState createState() => _LessonManagerState();
}

class _LessonManagerState extends State<LessonManager> {
  var _queueIndex = 0;
  var _lessonList = [];

  void _nextKanji() {
    if (_queueIndex + 1 < _lessonList.length) {
      setState(() {
        _queueIndex = _queueIndex + 1;
      });
    } else {
      _lessonList.forEach((element) {
        element.progressLevel = 1;
        element.learningStatus = 'Review';
        element.dateLastLevelChanged = DateTime.now();
      });
      Navigator.pop(context);
    }
  }

  void _previousKanji() {
    setState(() {
      _queueIndex = _queueIndex - 1;
    });
  }

  void _updateMnemonicField(String input) {
    if (input == null || input != '')
      setState(() {
        _lessonList[_queueIndex].mnemonicStory = input;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MainAppBar(
        title: 'Lesson Page',
        appBar: AppBar(),
      ),
      body: Consumer(builder: (context, watch, _) {
        final kanjiList = watch(kanjiListProvider);
        final lessonList = watch(lessonListProvider);
        final showButtonRow = watch(btnBottomRowProvider).state;
        _lessonList = lessonList;
        return Column(
          children: [
            TopKanjiRow(
              kanjiId: lessonList[_queueIndex].characterLook,
              kanjiList: kanjiList,
              leftWidgetText: "Prev",
              rightWidgetText: "Next",
              leftWidgetHandler: _queueIndex == 0 ? null : _previousKanji,
              rightWidgetHandler: _nextKanji,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.075,
              child: KeyTextContainer(
                'Keyword: ' + lessonList[_queueIndex].keyword,
              ),
            ),
            BuildingBlockRow(
              kanjiList,
              lessonList[_queueIndex],
            ),
            ScrollableContainer(
              itemDetails: lessonList[_queueIndex],
              updateHandler: _updateMnemonicField,
              showHandler: () {
                context.read(btnBottomRowProvider).state = true;
              },
            ),
            Expanded(child: SizedBox()),
            if (showButtonRow)
              MnemonicHandler(
                itemDetails: lessonList[_queueIndex],
                updateHandler: _updateMnemonicField,
                showHandler: () {
                  context.read(btnBottomRowProvider).state = true;
                },
              ),
          ],
        );
      }),
    );
  }
}
