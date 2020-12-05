import 'package:flutter/material.dart';

import 'fetch_button.dart';
import 'mnemonic_field.dart';
import 'badges_container.dart';

class LessonManager extends StatefulWidget {
  final Function reAllocateMaps;
  final List<Map<String, String>> lessonMap;

  const LessonManager(this.reAllocateMaps, this.lessonMap);

  @override
  _LessonManagerState createState() => _LessonManagerState();
}

class _LessonManagerState extends State<LessonManager> {
  var _queueIndex = 0;
  var _initialTextCleared = false;
  var _textFieldtemp = '';

  void _nextKanji([String mnemonic]) {
    if (_queueIndex + 1 == widget.lessonMap.length) {
      // print('if _queueIndex is $_queueIndex');
      //print(widget.lessonMap[_queueIndex]);
      if (mnemonic != null)
        widget.lessonMap[_queueIndex]['mnemonicStory'] = mnemonic;

      widget.lessonMap[_queueIndex]['learningStatus'] = 'Review';
      widget.reAllocateMaps();
      Navigator.pop(context);
    } else {
      setState(() {
        // print('else _queueIndex is $_queueIndex');
        // print(widget.lessonMap[_queueIndex]);
        if (mnemonic != null)
          widget.lessonMap[_queueIndex]['mnemonicStory'] = mnemonic;

        widget.lessonMap[_queueIndex]['learningStatus'] = 'Review';
        _queueIndex = _queueIndex + 1;
      });
    }
  }

  void _previousKanji() {
    if (_queueIndex == 0) {
      Navigator.pop(context);
    } else {
      setState(() {
        _queueIndex = _queueIndex - 1;
      });
    }
  }

  void _clearInitialText() {
    if (_initialTextCleared == false) {
      setState(() {
        _initialTextCleared = true;
      });
    }
  }

  void _updateTempText(String text) {
    setState(() {
      _textFieldtemp = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _learnQueue = widget.lessonMap;
    return _learnQueue.isEmpty == true
        ? Scaffold()
        : Scaffold(
            appBar: AppBar(
              title: Text('Lesson Page'),
              backgroundColor: Colors.black,
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.search_rounded,
                    color: Colors.white,
                    size: MediaQuery.of(context).size.height * 0.05,
                  ),
                  onPressed: null,
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  BadgesContainer(
                    learnQueue: _learnQueue,
                    queueIndex: _queueIndex,
                    nextKanji: _nextKanji,
                    previousKanji: _previousKanji,
                  ),
                  MnemonicField(
                    lessonMap: _learnQueue,
                    queueIndex: _queueIndex,
                    nextKanji: _nextKanji,
                    initialtextCleared: _initialTextCleared,
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
