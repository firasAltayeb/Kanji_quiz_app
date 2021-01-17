import 'package:Kanji_quiz_app/widgets/shared/main_app_bar.dart';
import 'package:flutter/material.dart';

import 'result_review_screen.dart';
import 'recall_review_screen.dart';

class ReviewManager extends StatefulWidget {
  final Function reAllocateMaps;
  final List<Map<String, Object>> reviewListMap;

  const ReviewManager(this.reAllocateMaps, this.reviewListMap);

  @override
  _ReviewManagerState createState() => _ReviewManagerState();
}

class _ReviewManagerState extends State<ReviewManager> {
  var _correctRecallList = List<String>();
  var _incorrectRecallList = List<String>();
  var _sessionScore = 0;
  var _queueIndex = 0;

  void _processAnswer(bool answerChoice, BuildContext context) {
    Map<String, Object> reviewMap = widget.reviewListMap[_queueIndex];
    int currentProgressLevel = reviewMap['progressLevel'];
    if (answerChoice) {
      _sessionScore += 5;
      print('answerChoice is $answerChoice');
      reviewMap['learningStatus'] = 'Pratice';
      _correctRecallList.add(reviewMap['colorPhotoAddress']);

      if (currentProgressLevel < 5)
        reviewMap['progressLevel'] = currentProgressLevel + 1;
    } else {
      print('answerChoice is $answerChoice');
      reviewMap['learningStatus'] = 'Review+';
      _incorrectRecallList.add(reviewMap['colorPhotoAddress']);

      if (currentProgressLevel > 1)
        reviewMap['progressLevel'] = currentProgressLevel - 1;
    }
    print(
        '${reviewMap['itemId']} progress level is now ${reviewMap['progressLevel']}');

    setState(() {
      _queueIndex = _queueIndex + 1;
    });
  }

  void _undoAnswer() {
    Map<String, Object> reviewMap = widget.reviewListMap[_queueIndex - 1];
    int currentProgressLevel = reviewMap['progressLevel'];
    if (reviewMap['learningStatus'] == 'Pratice') {
      _sessionScore -= 5;
      print('_answerChoice is ${reviewMap['learningStatus']}');
      _correctRecallList.removeLast();
      if (currentProgressLevel > 1)
        reviewMap['progressLevel'] = currentProgressLevel - 1;
    } else {
      print('_answerChoice is ${reviewMap['learningStatus']}');
      _incorrectRecallList.removeLast();
      if (currentProgressLevel > 1 && currentProgressLevel < 5)
        reviewMap['progressLevel'] = currentProgressLevel + 1;
    }
    print(
        '${reviewMap['itemId']} progress level is now ${reviewMap['progressLevel']}');

    setState(() {
      _queueIndex = _queueIndex - 1;
    });
  }

  void _wrapSession() {
    _queueIndex = 0;
    _sessionScore = 0;
    widget.reAllocateMaps();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final _questionQueue = widget.reviewListMap;
    if (_questionQueue.isEmpty == true) {
      return Scaffold();
    }

    return Scaffold(
      appBar: MainAppBar(
        title: 'Review page',
        appBar: AppBar(),
      ),
      body: _queueIndex < _questionQueue.length
          ? RecallPage(
              questionIndex: _queueIndex,
              questionQueue: _questionQueue,
              undoLastAnswer: _queueIndex < 1 ? null : _undoAnswer,
              answerQuestion: _processAnswer,
            )
          : ResultPage(
              scoreToDisplay: _sessionScore,
              wrapSession: _wrapSession,
              correctRecallList: _correctRecallList,
              incorrectRecallList: _incorrectRecallList,
            ),
    );
  }
}
