import '../widgets/shared/key_text_container.dart';
import '../widgets/shared/main_app_bar.dart';
import '../widgets/shared/top_kanji_row.dart';
import 'package:flutter/material.dart';
import '../widgets/lesson/fetch_button.dart';
import '../widgets/lesson/mnemonic_field.dart';
import '../widgets/lesson/building_block_row.dart';

class LessonManager extends StatefulWidget {
  final Function reAllocateMaps;
  final List<Map<String, Object>> lessonMap;

  const LessonManager(this.reAllocateMaps, this.lessonMap);

  @override
  _LessonManagerState createState() => _LessonManagerState();
}

class _LessonManagerState extends State<LessonManager> {
  var _queueIndex = 0;
  var _clearTempText = false;
  var _textFieldtemp = '';

  void _nextKanji() {
    widget.lessonMap[_queueIndex]['progressLevel'] = 1;
    widget.lessonMap[_queueIndex]['learningStatus'] = 'Review';
    widget.lessonMap[_queueIndex]['dateLastLevelChanged'] = DateTime.now();
    if (_queueIndex + 1 == widget.lessonMap.length) {
      widget.reAllocateMaps();
      Navigator.pop(context);
    } else {
      setState(() {
        if (_textFieldtemp.isNotEmpty)
          widget.lessonMap[_queueIndex]['mnemonicStory'] = _textFieldtemp;

        _queueIndex = _queueIndex + 1;
        _clearTempText = false;
        _textFieldtemp = '';
      });
    }
  }

  void _previousKanji() {
    if (_queueIndex == 0) {
      Navigator.pop(context);
    } else {
      setState(() {
        if (_textFieldtemp.isNotEmpty)
          widget.lessonMap[_queueIndex]['mnemonicStory'] = _textFieldtemp;

        _queueIndex = _queueIndex - 1;
        _clearTempText = false;
        _textFieldtemp = '';
      });
    }
  }

  void _clearInitialText() {
    if (_clearTempText == false)
      setState(() {
        _clearTempText = true;
      });
  }

  void _updateTempText(String text) {
    _textFieldtemp = text;
  }

  @override
  Widget build(BuildContext context) {
    final _learnQueue = widget.lessonMap;
    return _learnQueue.isEmpty == true
        ? Scaffold()
        : Scaffold(
            appBar: MainAppBar(
              title: 'Lesson Page',
              appBar: AppBar(),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  TopKanjiRow(
                    kanjiSpriteAddress: _learnQueue[_queueIndex]
                        ['greyPhotoAddress'],
                    leftWidgetText: "Prev",
                    rightWidgetText: "Next",
                    leftWidgetHandler: _queueIndex == 0 ? null : _previousKanji,
                    rightWidgetHandler: _nextKanji,
                  ),
                  KeyTextContainer(
                    passedText:
                        'Keyword: ' + _learnQueue[_queueIndex]['keyword'],
                  ),
                  BuildingBlockRow(
                    kanjiMap: _learnQueue[_queueIndex],
                  ),
                  MnemonicField(
                    lessonMap: _learnQueue[_queueIndex],
                    nextKanji: _nextKanji,
                    clearText: _clearTempText,
                    clearInitialText: _clearInitialText,
                    textFieldtemp: _textFieldtemp,
                    updateTempText: _updateTempText,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.0125,
                  ),
                  FetchButton(
                    learnQueue: _learnQueue,
                    queueIndex: _queueIndex,
                  ),
                ],
              ),
            ),
          );
  }
}