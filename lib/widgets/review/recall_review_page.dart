import 'package:kanji_quiz_app/widgets/review/correct_incorrect_button.dart';
import 'package:kanji_quiz_app/widgets/review/show_answer_button.dart';
import 'package:kanji_quiz_app/widgets/shared/top_kanji_row.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanji_quiz_app/model/kanji_model.dart';
import 'package:flutter/material.dart';
import '../../main_providers.dart';

class RecallPage extends ConsumerWidget {
  final int queueIndex;
  final List<Kanji> reviewQueue;
  final Function undoLastAnswer;

  RecallPage({
    @required this.queueIndex,
    @required this.reviewQueue,
    @required this.undoLastAnswer,
  });

  void _recordAnswer(BuildContext ctx, answerChoice) {
    ctx.read(answerChoiceListProvider).state.add(answerChoice);

    if (answerChoice) {
      ctx.read(sessionScoreProvider).state += 5;
      ctx.read(correctRecallListProvider).state.add(reviewQueue[queueIndex]);
    } else {
      ctx.read(incorrectRecallListProvider).state.add(reviewQueue[queueIndex]);
    }
    if (queueIndex < reviewQueue.length - 1)
      ctx.read(targetKanjiProvider).state = reviewQueue[queueIndex + 1];
    ctx.read(reviewQueueIdxProvider).state++;
  }

  Widget build(BuildContext bldCtx, ScopedReader watch) {
    final _recallButtonVisible = watch(recallButtonVisibleProvider).state;
    final _itemCounter = '${(queueIndex + 1)}/${reviewQueue.length}';

    return Column(
      children: [
        TopKanjiRow(
          leftWidgetText: _itemCounter,
          rightWidgetText: "Undo",
          leftWidgetHandler: null,
          rightWidgetHandler: queueIndex < 1
              ? null
              : () {
                  bldCtx.read(recallButtonVisibleProvider).state = true;
                  undoLastAnswer();
                },
        ),
        Expanded(child: SizedBox()),
        infoBox(bldCtx, _recallButtonVisible),
        Expanded(child: SizedBox()),
        _recallButtonVisible
            ? ShowAnswerButton()
            : Row(
                children: [
                  CorrectIncorrectButton(
                    selectChoice: true,
                    answerQuestion: (answer) => _recordAnswer(bldCtx, answer),
                  ),
                  CorrectIncorrectButton(
                    selectChoice: false,
                    answerQuestion: (answer) => _recordAnswer(bldCtx, answer),
                  ),
                ],
              ),
      ],
    );
  }

  Widget infoBox(BuildContext context, recallBtnVisible) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.95,
      height: MediaQuery.of(context).size.height * 0.125,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 3,
        ),
        color:
            recallBtnVisible ? Colors.red[400] : Theme.of(context).accentColor,
      ),
      child: FittedBox(
        fit: recallBtnVisible ? BoxFit.fitWidth : BoxFit.fill,
        child: recallBtnVisible
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
            text: '${reviewQueue[queueIndex].keyword}',
            style: new TextStyle(fontWeight: FontWeight.bold),
          ),
          new TextSpan(text: '. \n Did you remember correctly?'),
        ],
      ),
    );
  }
}
