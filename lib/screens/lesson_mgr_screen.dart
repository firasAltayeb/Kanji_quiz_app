import '../widgets/lesson/mnemonic_container.dart';
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

  LessonManager({
    @required this.reAllocateMaps,
    @required this.lessonMap,
  });

  @override
  _LessonManagerState createState() => _LessonManagerState();
}

class _LessonManagerState extends State<LessonManager> {
  var _queueIndex = 0;
  var _showHandler = true;

  void _nextKanji() {
    if (_queueIndex + 1 < widget.lessonMap.length) {
      setState(() {
        _queueIndex = _queueIndex + 1;
      });
    } else {
      widget.lessonMap.forEach((element) {
        element['progressLevel'] = 1;
        element['learningStatus'] = 'Review';
        //element['dateLastLevelChanged'] = DateTime.now();
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

  void _updateMnemonicField(String input) {
    if (input == null || input != '')
      setState(() {
        widget.lessonMap[_queueIndex]['mnemonicStory'] = input;
        widget.reAllocateMaps();
      });
  }

  void _hideMnemonicHandler() {
    setState(() {
      _showHandler = !_showHandler;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _learnQueue = widget.lessonMap;
    if (_learnQueue.isEmpty == true) {
      return Scaffold();
    }

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: MainAppBar(
        title: 'Lesson Page',
        appBar: AppBar(),
      ),
      body: Column(
        children: [
          TopKanjiRow(
            kanjiId: _learnQueue[_queueIndex]['itemId'],
            templateAddress: "assets/images/Colorless_template_xl.png",
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
          BuildingBlockRow(_learnQueue[_queueIndex]),
          ScrollableContainer(
            itemDetails: _learnQueue[_queueIndex],
            updateHandler: _updateMnemonicField,
            hideShowHandler: _hideMnemonicHandler,
          ),
          Expanded(child: SizedBox()),
          if (_showHandler)
            MnemonicHandler(
              itemDetails: _learnQueue[_queueIndex],
              updateHandler: _updateMnemonicField,
              hideShowHandler: _hideMnemonicHandler,
            ),
        ],
      ),
    );
  }
}
