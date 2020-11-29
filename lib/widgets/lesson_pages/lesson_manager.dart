import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'fetch_button.dart';
import 'mnemonic_field.dart';
import 'badges_container.dart';

class LessonManager extends StatefulWidget {
  final Function allocateMaps;
  final List<dynamic> kanjiMap;
  final List<Map<String, String>> lessonMap;

  const LessonManager(this.allocateMaps, this.kanjiMap, this.lessonMap);

  @override
  _LessonManagerState createState() => _LessonManagerState();
}

class _LessonManagerState extends State<LessonManager> {
  var _queueIndex = 0;
  var _initialTextCleared = false;

  void _nextKanji() {
    if (_queueIndex == 2) {
      widget.allocateMaps();
      Navigator.pop(context);
    } else {
      setState(() {
        print(widget.lessonMap[_queueIndex]);
        print(widget.kanjiMap);

        int index = widget.kanjiMap.indexOf(widget.lessonMap[_queueIndex]);
        print(index);
        widget.kanjiMap[index]['learningStatus'] = 'Review';
        Hive.box('kanjiBox').put('map', widget.kanjiMap);

        _initialTextCleared = false;
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

  @override
  Widget build(BuildContext context) {
    final _learnQueue = widget.lessonMap;
    return Scaffold(
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
              learnQueue: _learnQueue,
              queueIndex: _queueIndex,
              nextKanji: _nextKanji,
              initialtextCleared: _initialTextCleared,
              clearInitialText: _clearInitialText,
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
