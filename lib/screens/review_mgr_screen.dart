import 'package:Kanji_quiz_app/model/kanji_model.dart';

import '../widgets/review/result_review_page.dart';
import '../widgets/review/recall_review_page.dart';
import '../widgets/misc/back_pressed_alert.dart';
import '../widgets/shared/main_app_bar.dart';
import 'package:flutter/material.dart';

class ReviewManager extends StatefulWidget {
  static const routeName = '/review-screen';

  final Function reassignLists;
  final List<Kanji> reviewList;

  ReviewManager({@required this.reassignLists, @required this.reviewList});

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
      _correctRecallList.add(widget.reviewList[_queueIndex].itemId);
    } else {
      _incorrectRecallList.add(widget.reviewList[_queueIndex].itemId);
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
      Kanji reviewedItem = widget.reviewList[index];
      int currentProgressLevel = reviewedItem.progressLevel;
      reviewedItem.dateLastLevelChanged = DateTime.now();

      if (_answerChoiceList[index]) {
        if (currentProgressLevel < 4) {
          reviewedItem.progressLevel = currentProgressLevel + 1;
        } else {
          reviewedItem.learningStatus = 'Pratice';
        }
      } else {
        if (currentProgressLevel > 1)
          reviewedItem.progressLevel = currentProgressLevel - 1;
      }
    }

    widget.reassignLists();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    print('Review mgr build called');
    final _questionQueue = widget.reviewList;
    if (_questionQueue.isEmpty == true) {
      return Scaffold();
    }

    return WillPopScope(
      onWillPop: () =>
          BackPressedAlert().dialog(
            parentCtx: context,
            alertMsg: "Your progress will be lost!!",
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
                wrapSession: _wrapSession,
                scoreToDisplay: _sessionScore,
                correctRecallList: _correctRecallList,
                incorrectRecallList: _incorrectRecallList,
              ),
      ),
    );
  }
}
