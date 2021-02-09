import 'package:Kanji_quiz_app/widgets/review/correct_incorrect_button.dart';
import 'package:Kanji_quiz_app/widgets/review/show_answer_button.dart';
import 'package:Kanji_quiz_app/widgets/shared/top_kanji_row.dart';
import 'package:Kanji_quiz_app/model/kanji_model.dart';
import 'package:flutter/material.dart';

class RecallPage extends StatefulWidget {
  final int questionIndex;
  final List<Kanji> questionQueue;
  final Function answerQuestion;
  final Function undoLastAnswer;

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

  String determineTemplateAddress() {
    switch (widget.questionQueue[widget.questionIndex].itemType) {
      case "Radical":
        return "assets/images/blue_badge_template.png";
      case "Primitive":
        return widget.questionQueue[widget.questionIndex].badgePhotoAddress;
      default:
        return "assets/images/red_badge_template.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    var _itemCounter =
        '${(widget.questionIndex + 1)}/${widget.questionQueue.length}';
    var _questionItem = widget.questionQueue[widget.questionIndex];
    var undoAction = widget.questionIndex < 1
        ? null
        : () {
            _recallButtonVisible = true;
            widget.undoLastAnswer();
          };
    var badgeTemplateAddress = determineTemplateAddress();

    return Column(
      children: [
        TopKanjiRow(
          kanjiId: _questionItem.itemId,
          templateAddress: badgeTemplateAddress,
          leftWidgetText: _itemCounter,
          rightWidgetText: "Undo",
          leftWidgetHandler: null,
          rightWidgetHandler: undoAction,
        ),
        Expanded(child: SizedBox()),
        infoBox(context),
        Expanded(child: SizedBox()),
        _recallButtonVisible
            ? ShowAnswerButton(_flipRecallButton)
            : Row(
                children: [
                  CorrectIncorrectButton(
                    selectChoice: true,
                    showRecallButton: _flipRecallButton,
                    answerQuestion: widget.answerQuestion,
                    questionItem: _questionItem,
                  ),
                  CorrectIncorrectButton(
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
    return Container(
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.95,
      height: MediaQuery.of(context).size.height * 0.125,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 3,
        ),
        color: _recallButtonVisible
            ? Colors.red[400]
            : Theme.of(context).accentColor,
      ),
      child: FittedBox(
        fit: _recallButtonVisible ? BoxFit.fitWidth : BoxFit.fill,
        child: _recallButtonVisible
            ? Text(
                'Can you recall this character?',
                textAlign: TextAlign.center,
              )
            : keywordRichText(),
      ),
    );
  }

  RichText keywordRichText() {
    return new RichText(
      text: new TextSpan(
        style: new TextStyle(
          color: Colors.black,
        ),
        children: <TextSpan>[
          new TextSpan(text: 'The correct keyword is: '),
          new TextSpan(
            text: '${widget.questionQueue[widget.questionIndex].keyword}',
            style: new TextStyle(fontWeight: FontWeight.bold),
          ),
          new TextSpan(text: '. \n Did you remember correctly?'),
        ],
      ),
    );
  }
}
