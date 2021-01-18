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

  Future<bool> _onBackPressed(Color color) {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            actionsPadding: const EdgeInsets.fromLTRB(0, 0, 65, 20),
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0),
              side: BorderSide(color: Colors.black, width: 2),
            ),
            title: Text(
              'Are you sure?',
              style: TextStyle(
                fontSize: 28,
                fontFamily: 'Anton',
              ),
            ),
            content: Text(
              "You will lose all the progress for the current session!!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: color,
            actions: [
              dialogButton('No', false),
              SizedBox(width: 30),
              dialogButton('Yes', true),
            ],
          ),
        ) ??
        false;
  }

  Widget dialogButton(String displayedText, bool choice) {
    return RaisedButton(
      color: Colors.black,
      onPressed: () => Navigator.of(context).pop(choice),
      child: Text(
        displayedText,
        style: TextStyle(
          fontSize: 38,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _questionQueue = widget.reviewListMap;
    if (_questionQueue.isEmpty == true) {
      return Scaffold();
    }

    return WillPopScope(
      onWillPop: () => _onBackPressed(Theme.of(context).accentColor),
      child: Scaffold(
        appBar: MainAppBar(
          title: 'Review page',
          appBar: AppBar(),
        ),
        body: _queueIndex < _questionQueue.length
            ? RecallScreen(
                questionIndex: _queueIndex,
                questionQueue: _questionQueue,
                undoLastAnswer: _queueIndex < 1 ? null : _undoAnswer,
                answerQuestion: _processAnswer,
              )
            : ResultScreen(
                scoreToDisplay: _sessionScore,
                wrapSession: _wrapSession,
                correctRecallList: _correctRecallList,
                incorrectRecallList: _incorrectRecallList,
              ),
      ),
    );
  }
}
