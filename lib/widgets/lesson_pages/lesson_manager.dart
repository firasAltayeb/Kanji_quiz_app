import 'package:flutter/material.dart';

import 'mnemonic_page.dart';

class LessonManager extends StatefulWidget {
  @override
  _LessonManagerState createState() => _LessonManagerState();
}

class _LessonManagerState extends State<LessonManager> {
  final _learnQueue = const [
    {
      'keyword': 'Oneself',
      'photoAddress': 'assets/images/17_Kanji_xlg.png',
      'buildingBlockOne': 'assets/images/5_Kanji_xl.png',
      'buildingBlockTwo': 'assets/images/11_Kanji_xl.png'
    },
    {
      'keyword': 'Bright',
      'photoAddress': 'assets/images/18_Kanji_xlg.png',
      'buildingBlockOne': 'assets/images/12_Kanji_xl.png',
      'buildingBlockTwo': 'assets/images/13_Kanji_xl.png'
    },
    {
      'keyword': 'Goods',
      'photoAddress': 'assets/images/19_Kanji_xlg.png',
      'buildingBlockOne': 'assets/images/11_Kanji_xl.png',
      'buildingBlockTwo': 'assets/images/11_Kanji_xl.png'
    }
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
