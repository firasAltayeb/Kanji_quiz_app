import 'package:Kanji_quiz_app/widgets/shared/top_kanji_row.dart';
import 'package:Kanji_quiz_app/widgets/review/choose_answer_button.dart';
import 'package:Kanji_quiz_app/widgets/review/show_answer_button.dart';
import 'package:flutter/material.dart';

class RecallPage extends StatefulWidget {
  final int questionIndex;
  final Function answerQuestion;
  final Function undoLastAnswer;
  final List<Map<String, Object>> questionQueue;

  RecallPage({
    @required this.questionQueue,
    @required this.questionIndex,
    @required this.undoLastAnswer,
    @required this.answerQuestion,
  });

  @override
  _RecallPageState createState() => _RecallPageState();
}

class _RecallPageState extends State<RecallPage> {
  var _recallButtonVisible = true;

  void _flipRecallButton() {
    setState(() {
      _recallButtonVisible = !_recallButtonVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    var _itemCounter =
        '${(widget.questionIndex + 1)}/${widget.questionQueue.length}';
    var _questionItem = widget.questionQueue[widget.questionIndex];

    return Column(
      children: [
        ButtonKanjiRow(
          kanjiSpriteAddress: _questionItem['colorPhotoAddress'],
          leftWidgetText: _itemCounter,
          rightWidgetText: "Undo",
          leftWidgerHandler: null,
          rightWidgerHandler: widget.undoLastAnswer,
        ),
        Expanded(child: SizedBox()),
        infoBox(context),
        Expanded(child: SizedBox()),
        _recallButtonVisible
            ? ShowAnswerButton(selectHandler: _flipRecallButton)
            : Row(
                children: [
                  ChooseAnswerButton(
                    buttonColor: Colors.green,
                    buttonText: "Correct",
                    selectChoice: true,
                    showRecallButton: _flipRecallButton,
                    answerQuestion: widget.answerQuestion,
                    questionItem: _questionItem,
                  ),
                  ChooseAnswerButton(
                    buttonColor: Colors.red,
                    buttonText: "Incorrect",
                    selectChoice: false,
                    showRecallButton: _flipRecallButton,
                    answerQuestion: widget.answerQuestion,
                    questionItem: _questionItem,
                  ),
                ],
              ),
      ],
    );
  }

  Widget infoBox(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.height * 0.125,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 3,
          ),
          color:
              _recallButtonVisible ? Colors.red : Theme.of(context).accentColor,
        ),
        padding: const EdgeInsets.all(10),
        child: FittedBox(
          fit: _recallButtonVisible ? BoxFit.fitWidth : BoxFit.fill,
          child: _recallButtonVisible
              ? Text('Can you recall this character?',
                  textAlign: TextAlign.center)
              : checkText(),
        ),
      ),
    );
  }

  RichText checkText() {
    return new RichText(
      text: new TextSpan(
        style: new TextStyle(
          color: Colors.black,
        ),
        children: <TextSpan>[
          new TextSpan(text: 'The correct keyword is: '),
          new TextSpan(
            text: '${widget.questionQueue[widget.questionIndex]['keyword']}',
            style: new TextStyle(fontWeight: FontWeight.bold),
          ),
          new TextSpan(text: '. \n Did you remember correctly?'),
        ],
      ),
    );
  }
}
