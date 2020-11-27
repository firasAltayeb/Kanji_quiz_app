import 'package:flutter/material.dart';

import 'fetch_button.dart';
import 'badges_container.dart';
import 'mnemonic_field.dart';

class LessonManager extends StatefulWidget {
  @override
  _LessonManagerState createState() => _LessonManagerState();
}

class _LessonManagerState extends State<LessonManager> {
  final _learnQueue = const [
    {
      'keyword': 'Oneself',
      'frameNumber': '17',
      'photoAddress': 'assets/images/17_Kanji_xlg.png',
      'buildingBlockOne': 'assets/images/5_Kanji_xl.png',
      'buildingBlockTwo': 'assets/images/11_Kanji_xl.png'
    },
    {
      'keyword': 'Bright',
      'frameNumber': '20',
      'photoAddress': 'assets/images/18_Kanji_xlg.png',
      'buildingBlockOne': 'assets/images/12_Kanji_xl.png',
      'buildingBlockTwo': 'assets/images/13_Kanji_xl.png'
    },
    {
      'keyword': 'Goods',
      'frameNumber': '23',
      'photoAddress': 'assets/images/19_Kanji_xlg.png',
      'buildingBlockOne': 'assets/images/11_Kanji_xl.png',
      'buildingBlockTwo': 'assets/images/11_Kanji_xl.png'
    }
  ];

  var _queueIndex = 0;
  var _initialTextCleared = false;

  void _nextKanji() {
    if (_queueIndex == 2) {
      Navigator.pop(context);
    } else {
      setState(() {
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
