import 'package:Kanji_quiz_app/widgets/misc_widgets/main_app_bar.dart';
import 'package:flutter/material.dart';

import 'result_page.dart';
import 'recall_page.dart';

class ReviewManager extends StatefulWidget {
  final Function reAllocateMaps;
  final List<Map<String, Object>> reviewListMap;

  const ReviewManager(this.reAllocateMaps, this.reviewListMap);

  @override
  _ReviewManagerState createState() => _ReviewManagerState();
}

class _ReviewManagerState extends State<ReviewManager> {
  List<String> _correctRecallList = List<String>();
  List<String> _incorrectRecallList = List<String>();
  var _sessionScore = 0;
  var _queueIndex = 0;
  var _answerChoice;

  void _answerQuestion(bool answerChoice, BuildContext context) {
    Map<String, Object> reviewMap = widget.reviewListMap[_queueIndex];
    int currentProgressLevel = reviewMap['progressLevel'];
    _answerChoice = answerChoice;
    if (_answerChoice) {
      print('_answerChoice is $_answerChoice');
      _sessionScore += 5;
      _correctRecallList.add(reviewMap['colorPhotoAddress']);
      if (currentProgressLevel < 5)
        reviewMap['progressLevel'] = currentProgressLevel + 1;
      //reviewMap['learningStatus'] = 'Pratice';
    } else {
      print('_answerChoice is $_answerChoice');
      _incorrectRecallList.add(reviewMap['colorPhotoAddress']);
      if (currentProgressLevel > 1)
        reviewMap['progressLevel'] = currentProgressLevel - 1;
      //reviewMap['learningStatus'] = 'Lesson';
    }
    setState(() {
      _queueIndex = _queueIndex + 1;
    });
  }

  void _undoAnswer() {
    Map<String, Object> reviewMap = widget.reviewListMap[_queueIndex - 1];
    int currentProgressLevel = reviewMap['progressLevel'];
    var itemId = reviewMap['kanjiId'];
    if (_answerChoice == true) {
      print('$itemId progress level is now $currentProgressLevel');
      _correctRecallList.removeAt(_queueIndex - 1);
      if (currentProgressLevel > 0)
        reviewMap['progressLevel'] = currentProgressLevel - 1;
    } else {
      _incorrectRecallList.removeAt(_queueIndex - 1);
      print('$itemId progress level is now $currentProgressLevel');
      if (currentProgressLevel < 5)
        reviewMap['progressLevel'] = currentProgressLevel + 1;
    }
    setState(() {
      _queueIndex = _queueIndex - 1;
    });
  }

  void _resetQuiz() {
    _queueIndex = 0;
    _sessionScore = 0;
    widget.reAllocateMaps();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final _learnQueue = widget.reviewListMap;
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
              undoLastAnswer: _queueIndex < 1 ? null : _undoAnswer,
              answerQuestion: _answerQuestion,
            )
          : ResultPage(
              scoreToDisplay: _sessionScore,
              resetHandler: _resetQuiz,
              correctRecallList: _correctRecallList,
              incorrectRecallList: _incorrectRecallList,
            ),
    );
  }
}
