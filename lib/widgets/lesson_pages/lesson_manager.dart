import 'package:flutter/material.dart';

import 'mnemonic_page.dart';

class LessonManager extends StatefulWidget {
  @override
  _LessonManagerState createState() => _LessonManagerState();
}

class _LessonManagerState extends State<LessonManager> {
  final _learnQueue = const [
    {'photoAddress': 'assets/images/15_Kanji_xl.png', 'keyword': 'Eye'},
    {'photoAddress': 'assets/images/16_Kanji_xl.png', 'keyword': 'Old'},
    {'photoAddress': 'assets/images/18_Kanji_xl.png', 'keyword': 'Bright'}
  ];

  var _queueIndex = 0;

  void _nextKanji() {
    if (_queueIndex == 2) {
      Navigator.pop(context);
    } else {
      setState(() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lesson Page'),
        backgroundColor: Colors.black,
      ),
      body: MnemonicPage(
        learnQueue: _learnQueue,
        queueIndex: _queueIndex,
        nextKanji: _nextKanji,
        previousKanji: _previousKanji,
      ),
    );
  }
}
