import 'package:Kanji_quiz_app/result.dart';
import 'package:flutter/material.dart';

import './quiz.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final _questions = const [
    {'questionText': 'assets/images/15_Kanji_xl.png', 'answerText': 'Eye'},
    {'questionText': 'assets/images/16_Kanji_xl.png', 'answerText': 'Old'},
    {'questionText': 'assets/images/18_Kanji_xl.png', 'answerText': 'Bright'}
  ];

  var _showButtonVisible = true;
  var _questionIndex = 0;
  var _totalScore = 0;

  void _hideShowButton() {
    setState(() {
      _showButtonVisible = false;
    });
  }

  void _answerQuestion(int score) {
    _totalScore += score;

    setState(() {
      _showButtonVisible = true;
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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Kanji Quiz App'),
        ),
        body: _questionIndex < _questions.length
            ? Quiz(
                answerQuestion: _answerQuestion,
                questionIndex: _questionIndex,
                questions: _questions,
                showButtonClicked: _showButtonVisible,
                showButtonClicker: _hideShowButton,
              )
            : Result(
                _totalScore,
                _resetQuiz,
              ),
      ),
    );
  }
}
