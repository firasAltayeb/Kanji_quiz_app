import '../model/back_pressed_alert.dart';
import '../widgets/shared/main_app_bar.dart';
import 'package:flutter/material.dart';

import '../widgets/review/result_review_page.dart';
import '../widgets/review/recall_review_page.dart';

class ReviewManager extends StatefulWidget {
  static const routeName = '/review-screen';

  final Function reAllocateMaps;
  final List<Map<String, Object>> reviewListMap;

  const ReviewManager(this.reAllocateMaps, this.reviewListMap);

  @override
  _ReviewManagerState createState() => _ReviewManagerState();
}

class _ReviewManagerState extends State<ReviewManager> {
  var _incorrectRecallList = List<String>();
  var _correctRecallList = List<String>();
  var _answerChoiceList = List<bool>();
  var _sessionScore = 0;
  var _queueIndex = 0;

  void _recordAnswer(bool answerChoice) {
    _answerChoiceList.add(answerChoice);
    print('choice list: $_answerChoiceList');

    if (answerChoice) {
      _sessionScore += 5;
      _correctRecallList
          .add(widget.reviewListMap[_queueIndex]['colorPhotoAddress']);
    } else {
      _incorrectRecallList
          .add(widget.reviewListMap[_queueIndex]['colorPhotoAddress']);
    }
    setState(() {
      _queueIndex = _queueIndex + 1;
    });
  }

  void _undoAnswer() {
    if (_answerChoiceList[_queueIndex - 1]) {
      _sessionScore -= 5;
      _correctRecallList.removeLast();
    } else {
      _incorrectRecallList.removeLast();
    }
    _answerChoiceList.removeLast();
    print('choice list: $_answerChoiceList');

    setState(() {
      _queueIndex = _queueIndex - 1;
    });
  }

  void _wrapSession() {
    for (var index = 0; index < _answerChoiceList.length; index++) {
      Map<String, Object> reviewMap = widget.reviewListMap[index];
      int currentProgressLevel = reviewMap['progressLevel'];
      reviewMap['dateLastLevelChanged'] = DateTime.now();

      if (_answerChoiceList[index]) {
        if (currentProgressLevel < 4) {
          reviewMap['progressLevel'] = currentProgressLevel + 1;
        } else {
          reviewMap['learningStatus'] = 'Pratice';
        }
      } else {
        if (currentProgressLevel > 1)
          reviewMap['progressLevel'] = currentProgressLevel - 1;
      }
    }

    widget.reAllocateMaps();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final _questionQueue = widget.reviewListMap;
    if (_questionQueue.isEmpty == true) {
      return Scaffold();
    }

    return WillPopScope(
      onWillPop: () =>
          BackPressedAlert().dialog(
            parentContext: context,
            alertMessage: "Your progress will be lost!!",
          ) ??
          false,
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
                answerQuestion: _recordAnswer,
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
