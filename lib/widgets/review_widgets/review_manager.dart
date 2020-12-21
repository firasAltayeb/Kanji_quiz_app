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

  void _answerQuestion(bool answerChoice, BuildContext context) {
    Map<String, Object> reviewMap = widget.reviewListMap[_queueIndex];
    print('current items[progressLevel] is ${reviewMap['progressLevel']}');
    String itemId = reviewMap['kanjiId'];
    int currentProgressLevel = reviewMap['progressLevel'];
    if (answerChoice) {
      _sessionScore += 5;
      _correctRecallList.add(reviewMap['colorPhotoAddress']);
      if (currentProgressLevel < 5)
        reviewMap['progressLevel'] = ++currentProgressLevel;
      var dialogText = '$itemId\'s progress level is now $currentProgressLevel';
      _openCustomDialog(context, dialogText, Colors.green);
      //reviewMap['learningStatus'] = 'Pratice';
    } else {
      if (currentProgressLevel > 1)
        reviewMap['progressLevel'] = --currentProgressLevel;
      var dialogText = '$itemId progress level is now $currentProgressLevel';
      _openCustomDialog(context, dialogText, Colors.red);
      //reviewMap['learningStatus'] = 'Lesson';
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

  void _openCustomDialog(
      BuildContext context, String dialogText, Color dialogColor) {
    showGeneralDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.2),
      barrierDismissible: true,
      barrierLabel: '',
      pageBuilder: (context, animation1, animation2) {
        return null;
      },
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              backgroundColor: dialogColor,
              shape:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
              content: Text(
                dialogText,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 100),
    );
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
