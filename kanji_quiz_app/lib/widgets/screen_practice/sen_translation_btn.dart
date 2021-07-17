import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../model/translation_question.dart';
import '../../model/study_item_model.dart';
import '../../helper_functions.dart';
import '../../main_providers.dart';

class TranslationOptionBtn extends ConsumerWidget {
  final TranslationQusAnswer questionAnswer;
  final List<StudyItem> practiceList;
  final List<bool> sessionChoices;
  final Color answerColor;

  TranslationOptionBtn({
    @required this.questionAnswer,
    @required this.sessionChoices,
    @required this.practiceList,
    @required this.answerColor,
  });

  void _recordAnswer(BuildContext ctx, answerChoice, queueIndex) {
    ctx.read(sessionChoicesListProvider).state.add(answerChoice);
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
      wrapPracticeSession(ctx, sessionChoices, practiceList);
    }
  }

  Widget build(BuildContext ctx, ScopedReader watch) {
    final practiceQueueIdx = watch(practiceQueueIdxProvider).state;
    final answeredRevealed = watch(answeredRevealedProvider).state;
    final screenHeight = MediaQuery.of(ctx).size.height;
    final screenWidth = MediaQuery.of(ctx).size.width;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () {
          HapticFeedback.vibrate();
          ctx.read(answeredRevealedProvider).state = !answeredRevealed;

          if (answeredRevealed) {
            if (questionAnswer.accuracy == 100) {
              _recordAnswer(ctx, true, practiceQueueIdx);
            } else {
              _recordAnswer(ctx, false, practiceQueueIdx);
            }
            ctx.read(answeredRevealedProvider).state = !answeredRevealed;
          }
        },
        child: Ink(
          padding: const EdgeInsets.fromLTRB(5, 2.5, 5, 2.5),
          width: screenWidth * 0.95,
          height: screenHeight * 0.08,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            color: !answeredRevealed ? Theme.of(ctx).accentColor : answerColor,
          ),
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              questionAnswer.containableTxt(),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
