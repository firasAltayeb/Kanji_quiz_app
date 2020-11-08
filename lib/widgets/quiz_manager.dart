import 'package:flutter/material.dart';

import 'result_page.dart';
import 'quiz_page.dart';

class QuizManager extends StatefulWidget {
  @override
  _QuizManagerState createState() => _QuizManagerState();
}

class _QuizManagerState extends State<QuizManager> {
  final _questions = const [
    {'questionText': 'assets/images/15_Kanji_xl.png', 'answerText': 'Eye'},
    {'questionText': 'assets/images/16_Kanji_xl.png', 'answerText': 'Old'},
    {'questionText': 'assets/images/18_Kanji_xl.png', 'answerText': 'Bright'}
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
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _questionIndex < _questions.length
        ? QuizPage(
            answerQuestion: _answerQuestion,
            questionIndex: _questionIndex,
            questions: _questions,
            showButtonClicked: _recallButtonVisible,
            showButtonClicker: _hideRecallButton,
          )
        : ResultPage(
            _totalScore,
            _resetQuiz,
          );
  }
}
