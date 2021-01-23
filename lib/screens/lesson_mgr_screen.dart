import '../widgets/lesson/scrollable_container.dart';
import '../widgets/shared/key_text_container.dart';
import '../widgets/lesson/building_block_row.dart';
import '../widgets/lesson/mnemonic_handler.dart';
import '../widgets/shared/top_kanji_row.dart';
import '../widgets/shared/main_app_bar.dart';

import 'package:flutter/material.dart';

class LessonManager extends StatefulWidget {
  static const routeName = '/lesson-screen';

  final Function reAllocateMaps;
  final List<Map<String, Object>> lessonMap;

  LessonManager(this.reAllocateMaps, this.lessonMap);

  @override
  _LessonManagerState createState() => _LessonManagerState();
}

class _LessonManagerState extends State<LessonManager> {
  var _queueIndex = 0;

  void _nextKanji() {
    if (_queueIndex + 1 < widget.lessonMap.length) {
      setState(() {
        _queueIndex = _queueIndex + 1;
      });
    } else {
      widget.lessonMap.forEach((element) {
        element['progressLevel'] = 1;
        element['learningStatus'] = 'Review';
        element['dateLastLevelChanged'] = DateTime.now();
      });
      widget.reAllocateMaps();
      Navigator.pop(context);
    }
  }

  void _previousKanji() {
    setState(() {
      _queueIndex = _queueIndex - 1;
    });
  }

  void updateMnemonicField(String input) {
    if (input == null || input != '')
      setState(() {
        widget.lessonMap[_queueIndex]['mnemonicStory'] = input;
        widget.reAllocateMaps();
      });
  }

  @override
  Widget build(BuildContext context) {
    final _learnQueue = widget.lessonMap;
    if (_learnQueue.isEmpty == true) {
      return Scaffold();
    }

    return Scaffold(
      appBar: MainAppBar(
        title: 'Lesson Page',
        appBar: AppBar(),
      ),
      body: Column(
        children: [
          TopKanjiRow(
            kanjiSpriteAddress: _learnQueue[_queueIndex]['greyPhotoAddress'],
            leftWidgetText: "Prev",
            rightWidgetText: "Next",
            leftWidgetHandler: _queueIndex == 0 ? null : _previousKanji,
            rightWidgetHandler: _nextKanji,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.075,
            child: KeyTextContainer(
              'Keyword: ' + _learnQueue[_queueIndex]['keyword'],
            ),
          ),
          Expanded(child: SizedBox()),
          BuildingBlockRow(_learnQueue[_queueIndex]),
          Expanded(child: SizedBox()),
          ScrollableContainer(_learnQueue[_queueIndex]),
          Expanded(child: SizedBox()),
          MnemonicHandler(
            _learnQueue[_queueIndex],
            updateMnemonicField,
          ),
        ],
      ),
    );
  }
}
