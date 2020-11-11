import 'package:flutter/material.dart';

import 'answer_page.dart';
import 'result_page.dart';
import 'recall_page.dart';

class ReviewManager extends StatefulWidget {
  @override
  _ReviewManagerState createState() => _ReviewManagerState();
}

class _ReviewManagerState extends State<ReviewManager> {
  final _questions = const [
    {'photoAddress': 'assets/images/15_Kanji_xl.png', 'keyword': 'Eye'},
    {'photoAddress': 'assets/images/16_Kanji_xl.png', 'keyword': 'Old'},
    {
      'photoAddress': 'assets/images/18_Kanji_xl.png',
      'keyword': 'BrightBrightBrightBrightBrightBrightBrightBrightBrightBright'
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
    Widget page;
    if (_questionIndex < _questions.length) {
      if (_recallButtonVisible) {
        page = RecallPage(
          questionIndex: _questionIndex,
          questions: _questions,
          hideRecallButton: _hideRecallButton,
        );
      } else {
        page = AnswerPage(
          questionIndex: _questionIndex,
          questions: _questions,
          kanjiAnswer: _questions[_questionIndex]['keyword'],
          selectHandler: _answerQuestion,
        );
      }
    } else {
      page = ResultPage(
        _totalScore,
        _resetQuiz,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Review Page'),
        backgroundColor: Colors.black,
      ),
      body: page,
    );
  }
}
