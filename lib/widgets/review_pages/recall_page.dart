import 'package:Kanji_quiz_app/widgets/misc_pages/kanji_top_row.dart';
import 'package:flutter/material.dart';

class RecallPage extends StatelessWidget {
  final List<Map<String, Object>> questionQueue;
  final int questionIndex;

  final Function hideRecallButton;
  final Function selectHandler;
  final bool recallButtonVisible;

  RecallPage({
    @required this.selectHandler,
    @required this.questionQueue,
    @required this.questionIndex,
    @required this.hideRecallButton,
    @required this.recallButtonVisible,
  });

  @override
  Widget build(BuildContext context) {
    var itemCounter =
        (questionIndex + 1).toString() + '/ ${questionQueue.length}';
    var spriteAddress = questionQueue[questionIndex]['colorPhotoAddress'];

    return Column(
      children: [
        KanjiTopRow(
          kanjiSpriteAddress: spriteAddress,
          leftWidgetText: itemCounter,
          rightWidgetText: "Undo",
          leftWidgerHandler: null,
          rightWidgerHandler: null,
        ),
        infoBox(context),
        Expanded(child: SizedBox()),
        recallButtonVisible
            ? recallButtonWidget(context)
            : Row(
                children: [
                  answerButton(context, Colors.green, "Correct", true),
                  answerButton(context, Colors.red, "Incorrect", false),
                ],
              ),
      ],
    );
  }

  Widget infoBox(BuildContext context) {
    var keyword = questionQueue[questionIndex]['keyword'];
    var infoText = recallButtonVisible
        ? 'Can you recall this character?'
        : 'The correct keyword is: $keyword' +
            '. \n Did you remember correctly?';

    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      height: MediaQuery.of(context).size.height * 0.125,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 3,
        ),
        color: recallButtonVisible ? Colors.red : Colors.yellow,
      ),
      padding: const EdgeInsets.all(10),
      child: FittedBox(
        fit: recallButtonVisible ? BoxFit.fitWidth : BoxFit.fill,
        child: Text(infoText, textAlign: TextAlign.center),
      ),
    );
  }

  Widget recallButtonWidget(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.38,
      decoration: BoxDecoration(
        color: Colors.yellow,
        border: Border.all(
          color: Colors.black,
          width: 3,
        ),
      ),
      child: FlatButton(
        textColor: Colors.black,
        child: Text(
          "Show Answer",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: hideRecallButton,
      ),
    );
  }

  Widget answerButton(
      BuildContext context, Color color, String label, bool answer) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.height * 0.38,
      decoration: BoxDecoration(
        color: color,
        border: Border(
          top: BorderSide(width: 3.0, color: Colors.black),
          left: BorderSide(width: 1.0, color: Colors.black),
          right: BorderSide(width: 1.0, color: Colors.black),
          bottom: BorderSide(width: 3.0, color: Colors.black),
        ),
      ),
      child: FlatButton(
        textColor: Colors.white,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () => selectHandler(answer),
      ),
    );
  }
}
