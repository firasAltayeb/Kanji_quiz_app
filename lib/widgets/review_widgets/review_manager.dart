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
  var _recallButtonVisible = true;
  var _sessionScore = 0;
  var _queueIndex = 0;

  void _hideRecallButton() {
    setState(() {
      _recallButtonVisible = false;
    });
  }

  void _answerQuestion(bool answerChoice) {
    Map<String, Object> reviewMap = widget.reviewListMap[_queueIndex];
    //print('reviewMap[progressLevel] is ${reviewMap['progressLevel']}');
    // int currentProgressLevel =
    //     int.parse(reviewMap['progressLevel']) ?? reviewMap['progressLevel'];
    if (answerChoice) {
      _sessionScore += 5;
      _correctRecallList.add(reviewMap['colorPhotoAddress']);
      // reviewMap['progressLevel'] = currentProgressLevel++;
      reviewMap['learningStatus'] = 'Pratice';
    } else {
      _incorrectRecallList.add(reviewMap['colorPhotoAddress']);
      // reviewMap['progressLevel'] = currentProgressLevel--;
      reviewMap['learningStatus'] = 'Lesson';
    }
    setState(() {
      _recallButtonVisible = true;
      _queueIndex = _queueIndex + 1;
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
              hideRecallButton: _hideRecallButton,
              answerQuestion: _answerQuestion,
              recallButtonVisible: _recallButtonVisible,
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
