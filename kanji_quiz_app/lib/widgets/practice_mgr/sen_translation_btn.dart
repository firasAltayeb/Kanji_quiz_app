import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../model/translation_question.dart';
import '../../model/study_item_model.dart';
import '../../helper_functions.dart';
import '../../main_providers.dart';

class TranslationOptionBtn extends ConsumerWidget {
  final Color answerColor;
  final List<bool> ansChoiceList;
  final List<StudyItem> practiceList;
  final TranslationQusAnswer questionAnswer;

  TranslationOptionBtn(
    this.answerColor,
    this.practiceList,
    this.ansChoiceList,
    this.questionAnswer,
  );

  void _recordAnswer(BuildContext ctx, answerChoice, queueIndex) {
    ctx.read(answerChoiceListProvider).state.add(answerChoice);
    if (answerChoice) {
      ctx.read(sessionScoreProvider).state += 5;
      ctx.read(correctRecallListProvider).state.add(practiceList[queueIndex]);
    } else {
      ctx.read(incorrectRecallListProvider).state.add(practiceList[queueIndex]);
    }
    //check whether currecnt item is last in the list
    if (queueIndex < practiceList.length - 1) {
      ctx.read(sentenceQueueIdxProvider).state = 1;
      ctx.read(practiceQueueIdxProvider).state++;
    } else {
      wrapPracticeSession(ctx, ansChoiceList, practiceList);
    }
  }

  Widget build(BuildContext context, ScopedReader watch) {
    final practiceQueueIdx = watch(practiceQueueIdxProvider).state;
    final answeredRevealed = watch(answeredRevealedProvider).state;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        HapticFeedback.vibrate();
        context.read(answeredRevealedProvider).state = !answeredRevealed;

        if (answeredRevealed) {
          if (questionAnswer.accuracy == 100) {
            _recordAnswer(context, true, practiceQueueIdx);
          } else {
            _recordAnswer(context, false, practiceQueueIdx);
          }
          context.read(answeredRevealedProvider).state = !answeredRevealed;
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Ink(
          padding: const EdgeInsets.fromLTRB(5, 2.5, 5, 2.5),
          width: screenWidth * 0.95,
          height: screenHeight * 0.08,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 3,
            ),
            color:
                !answeredRevealed ? Theme.of(context).accentColor : answerColor,
          ),
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              questionAnswer.answerText,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
