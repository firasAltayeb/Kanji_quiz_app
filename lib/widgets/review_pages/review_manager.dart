import 'package:flutter/material.dart';

import 'answer_page.dart';
import 'result_page.dart';
import 'recall_page.dart';

class ReviewManager extends StatefulWidget {
  final Function reAllocateMaps;
  final List<Map<String, String>> reviewMap;

  const ReviewManager(this.reAllocateMaps, this.reviewMap);

  @override
  _ReviewManagerState createState() => _ReviewManagerState();
}

class _ReviewManagerState extends State<ReviewManager> {
  var _recallButtonVisible = true;
  var _queueIndex = 0;
  var _totalScore = 0;

  void _hideRecallButton() {
    setState(() {
      _recallButtonVisible = false;
    });
  }

  void _answerQuestion(bool answerChoice) {
    if (answerChoice) {
      _totalScore += 5;
      widget.reviewMap[_queueIndex]['learningStatus'] = 'Pratice';
    } else {
      widget.reviewMap[_queueIndex]['learningStatus'] = 'Lesson';
    }
    setState(() {
      _recallButtonVisible = true;
      _queueIndex = _queueIndex + 1;
    });
  }

  void _resetQuiz() {
    _queueIndex = 0;
    _totalScore = 0;
    widget.reAllocateMaps();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    Widget page;
    final _learnQueue = widget.reviewMap;

    if (_queueIndex < _learnQueue.length) {
      if (_recallButtonVisible) {
        page = RecallPage(
          questionIndex: _queueIndex,
          questionQueue: _learnQueue,
          hideRecallButton: _hideRecallButton,
        );
      } else {
        page = AnswerPage(
          questionIndex: _queueIndex,
          questionQueue: _learnQueue,
          kanjiAnswer: _learnQueue[_queueIndex]['keyword'],
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
