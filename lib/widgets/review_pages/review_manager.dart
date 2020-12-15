import 'package:Kanji_quiz_app/widgets/misc_pages/main_app_bar.dart';
import 'package:flutter/material.dart';

import 'result_page.dart';
import 'recall_page.dart';

class ReviewManager extends StatefulWidget {
  final Function reAllocateMaps;
  final List<Map<String, Object>> reviewMap;

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
    final _learnQueue = widget.reviewMap;
    if (_learnQueue.isEmpty == true) {
      return Scaffold();
    }

    return Scaffold(
      appBar: MainAppBar(
        title: 'Review page',
        appBar: AppBar(),
      ),
      body: _queueIndex < _learnQueue.length
          ? RecallPage(
              questionIndex: _queueIndex,
              questionQueue: _learnQueue,
              hideRecallButton: _hideRecallButton,
              answerQuestion: _answerQuestion,
              recallButtonVisible: _recallButtonVisible,
            )
          : ResultPage(
              _totalScore,
              _resetQuiz,
            ),
    );
  }
}
