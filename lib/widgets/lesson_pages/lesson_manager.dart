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

  void _mnemonicProvided() {
    setState(() {
      _queueIndex = _queueIndex + 1;
    });
    print(_queueIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lesson Page'),
        backgroundColor: Colors.black,
      ),
      body: MnemonicPage(
        _learnQueue,
        _queueIndex,
        _mnemonicProvided,
      ),
    );
  }
}
