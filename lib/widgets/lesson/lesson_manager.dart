import 'package:flutter/material.dart';

class LessonManager extends StatefulWidget {
  @override
  _LessonManagerState createState() => _LessonManagerState();
}

class _LessonManagerState extends State<LessonManager> {
  final _questions = const [
    {'questionText': 'assets/images/15_Kanji_xl.png', 'answerText': 'Eye'},
    {'questionText': 'assets/images/16_Kanji_xl.png', 'answerText': 'Old'},
    {
      'questionText': 'assets/images/18_Kanji_xl.png',
      'answerText':
          'BrightBrightBrightBrightBrightBrightBrightBrightBrightBright'
    }
  ];

  var _recallButtonVisible = true;

  var _questionIndex = 0;

  var _totalScore = 0;

  void _hideRecallButton() {
    setState(() {
      _recallButtonVisible = false;
    });
  }

  void _answerQuestion(int score) {
    _totalScore += score;

    setState(() {
      _recallButtonVisible = true;
      _questionIndex = _questionIndex + 1;
    });
    print(_questionIndex);
  }

  void _resetQuiz() {
    _questionIndex = 0;
    _totalScore = 0;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sub Page'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          RaisedButton(
            child: Text('Restart Quiz'),
            textColor: Colors.blue,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Text('Sub Page'),
        ],
      ),
    );
  }
}
