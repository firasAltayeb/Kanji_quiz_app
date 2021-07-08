import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:kanji_quiz_app/widgets/review/correct_incorrect_button.dart';
import 'package:kanji_quiz_app/widgets/review/show_answer_button.dart';
import 'package:kanji_quiz_app/widgets/shared/top_picture_row.dart';
import 'package:kanji_quiz_app/model/study_item_model.dart';
import '../../main_providers.dart';

class RecallPage extends ConsumerWidget {
  final List<StudyItem> reviewQueue;
  final Function undoLastAnswer;
  final int queueIndex;

  RecallPage({
    @required this.undoLastAnswer,
    @required this.reviewQueue,
    @required this.queueIndex,
  });

  void _recordAnswer(BuildContext ctx, answerChoice) {
    ctx.read(answerChoiceListProvider).state.add(answerChoice);

    if (answerChoice) {
      ctx.read(sessionScoreProvider).state += 5;
      ctx.read(correctRecallListProvider).state.add(reviewQueue[queueIndex]);
    } else {
      ctx.read(incorrectRecallListProvider).state.add(reviewQueue[queueIndex]);
    }
    ctx.read(reviewQueueIdxProvider).state++;
  }

  Widget build(BuildContext bldCtx, ScopedReader watch) {
    final _showBtnVisible = watch(showAnsBtnVisibleProvider).state;
    final _itemCounter = '${(queueIndex + 1)}/${reviewQueue.length}';
    final _targetItem = reviewQueue[queueIndex];

    var screenHeight = MediaQuery.of(bldCtx).size.height;
    var screenWidth = MediaQuery.of(bldCtx).size.width;

    return Column(
      children: [
        Container(height: screenHeight * 0.03, color: Colors.grey[300]),
        TopKanjiRow(
          targetItem: _targetItem,
          leftWidgetText: _itemCounter,
          rightWidgetText: "Undo",
          leftWidgetHandler: null,
          rightWidgetHandler: queueIndex < 1
              ? null
              : () {
                  bldCtx.read(showAnsBtnVisibleProvider).state = true;
                  undoLastAnswer();
                },
        ),
        Expanded(child: SizedBox()),
        _infoBox(_showBtnVisible, screenHeight, screenWidth),
        Expanded(child: SizedBox()),
        _showBtnVisible
            ? ShowAnswerButton()
            : Row(
                children: [
                  CorrectIncorrectButton(
                    selectChoice: true,
                    targetItem: _targetItem,
                    answerQuestion: (answer) => _recordAnswer(bldCtx, answer),
                  ),
                  CorrectIncorrectButton(
                    selectChoice: false,
                    targetItem: _targetItem,
                    answerQuestion: (answer) => _recordAnswer(bldCtx, answer),
                  ),
                ],
              ),
      ],
    );
  }

  Widget _infoBox(showBtnVisible, screenHeight, screenWidth) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: screenHeight * 0.125,
      width: screenWidth * 0.95,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 3,
        ),
        color: showBtnVisible ? Colors.red[400] : Colors.yellow[700],
      ),
      child: FittedBox(
        fit: showBtnVisible ? BoxFit.fitWidth : BoxFit.fill,
        child: showBtnVisible
            ? Text(
                'Can you recall this character?',
                textAlign: TextAlign.center,
              )
            : _keywordRichText(),
      ),
    );
  }

  RichText _keywordRichText() {
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
