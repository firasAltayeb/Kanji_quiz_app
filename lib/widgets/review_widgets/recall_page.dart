import 'package:Kanji_quiz_app/widgets/misc_widgets/kanji_top_row.dart';
import 'package:Kanji_quiz_app/widgets/review_widgets/choose_answer_button.dart';
import 'package:Kanji_quiz_app/widgets/review_widgets/show_answer_button.dart';
import 'package:flutter/material.dart';

class RecallPage extends StatelessWidget {
  final List<Map<String, Object>> questionQueue;
  final int questionIndex;

  final Function hideRecallButton;
  final Function answerQuestion;
  final bool recallButtonVisible;

  RecallPage({
    @required this.answerQuestion,
    @required this.questionQueue,
    @required this.questionIndex,
    @required this.hideRecallButton,
    @required this.recallButtonVisible,
  });

  @override
  Widget build(BuildContext context) {
    var itemCounter = '${(questionIndex + 1)}/${questionQueue.length}';
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
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        infoBox(context),
        Expanded(child: SizedBox()),
        recallButtonVisible
            ? ShowAnswerButton(selectHandler: hideRecallButton)
            : Row(
                children: [
                  ChooseAnswerButton(
                    buttonColor: Colors.green,
                    buttonText: "Correct",
                    selectChoice: true,
                    selectHandler: answerQuestion,
                  ),
                  ChooseAnswerButton(
                    buttonColor: Colors.red,
                    buttonText: "Incorrect",
                    selectChoice: false,
                    selectHandler: answerQuestion,
                  ),
                ],
              ),
      ],
    );
  }

  Widget infoBox(BuildContext context) {
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
        child: recallButtonVisible
            ? Text('Can you recall this character?',
                textAlign: TextAlign.center)
            : checkText(),
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
            text: '${questionQueue[questionIndex]['keyword']}',
            style: new TextStyle(fontWeight: FontWeight.bold),
          ),
          new TextSpan(text: '. \n Did you remember correctly?'),
        ],
      ),
    );
  }
}
