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
  var _answerChoiceList = List<bool>();
  var _sessionScore = 0;
  var _queueIndex = 0;

  void _processAnswer(bool answerChoice, BuildContext context) {
    Map<String, Object> reviewMap = widget.reviewListMap[_queueIndex];
    int currentProgressLevel = reviewMap['progressLevel'];

    _answerChoiceList.add(answerChoice);
    print('_answerChoiceList is $_answerChoiceList');

    if (answerChoice) {
      _sessionScore += 5;
      _correctRecallList.add(reviewMap['colorPhotoAddress']);
      if (currentProgressLevel < 4) {
        reviewMap['progressLevel'] = currentProgressLevel + 1;
      } else {
        reviewMap['learningStatus'] = 'Pratice';
      }
    } else {
      _incorrectRecallList.add(reviewMap['colorPhotoAddress']);

      if (currentProgressLevel > 1)
        reviewMap['progressLevel'] = currentProgressLevel - 1;
    }
    setState(() {
      _queueIndex = _queueIndex + 1;
    });
  }

  void _undoAnswer() {
    Map<String, Object> reviewMap = widget.reviewListMap[_queueIndex - 1];
    int currentProgressLevel = reviewMap['progressLevel'];

    if (_answerChoiceList[_queueIndex - 1]) {
      _sessionScore -= 5;
      _correctRecallList.removeLast();
      if (currentProgressLevel > 1)
        reviewMap['progressLevel'] = currentProgressLevel - 1;
    } else {
      _incorrectRecallList.removeLast();
      if (currentProgressLevel > 1 && currentProgressLevel < 5)
        reviewMap['progressLevel'] = currentProgressLevel + 1;
    }
    _answerChoiceList.removeLast();
    print('_answerChoiceList is $_answerChoiceList');

    setState(() {
      _queueIndex = _queueIndex - 1;
    });
  }

  void _wrapSession() {
    _queueIndex = 0;
    _sessionScore = 0;
    _updateLevelChangeDate();
    widget.reAllocateMaps();
    Navigator.pop(context);
  }

  void _updateLevelChangeDate() {
    widget.reviewListMap.forEach((element) {
      element['dateLastLevelChanged'] = DateTime.now();
    });
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text("NO"),
              ),
              SizedBox(height: 16),
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(true),
                child: Text("YES"),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final _questionQueue = widget.reviewListMap;
    if (_questionQueue.isEmpty == true) {
      return Scaffold();
    }

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
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
      ),
    );
  }
}
