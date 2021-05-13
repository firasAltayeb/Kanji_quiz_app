import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../model/translation_question.dart';
import '../../model/kanji_model.dart';
import '../../main_providers.dart';

class TranslationOptionBtn extends ConsumerWidget {
  final Color answerColor;
  final List<Kanji> practiceList;
  final TranslationQusAnswer questionAnswer;

  TranslationOptionBtn(
    this.answerColor,
    this.practiceList,
    this.questionAnswer,
  );

  Widget build(BuildContext context, ScopedReader watch) {
    final practiceQueueIdx = watch(practiceQueueIdxProvider).state;
    final sentenceAnswered = watch(sentenceAnsweredProvider).state;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        if (sentenceAnswered) {
          if (practiceQueueIdx < practiceList.length - 1) {
            context.read(sentenceQueueIdxProvider).state = 1;
            context.read(targetKanjiProvider).state =
                practiceList[practiceQueueIdx + 1];
            context.read(practiceQueueIdxProvider).state++;
            context.read(sentenceAnsweredProvider).state = !sentenceAnswered;
          } else {
            context.read(sentenceQueueIdxProvider).state = 1;
            context.read(practiceQueueIdxProvider).state = 0;
            Navigator.of(context).pop();
          }
        }
        if (questionAnswer.accuracy == 100) {
          HapticFeedback.vibrate();
          context.read(sentenceAnsweredProvider).state = !sentenceAnswered;
        } else if (questionAnswer.accuracy >= 60 &&
            questionAnswer.accuracy <= 80) {
          HapticFeedback.heavyImpact();
          context.read(sentenceAnsweredProvider).state = !sentenceAnswered;
        } else if (questionAnswer.accuracy >= 40 &&
            questionAnswer.accuracy <= 60) {
          HapticFeedback.mediumImpact();
          context.read(sentenceAnsweredProvider).state = !sentenceAnswered;
        } else if (questionAnswer.accuracy >= 0 &&
            questionAnswer.accuracy <= 40) {
          HapticFeedback.lightImpact();
          context.read(sentenceAnsweredProvider).state = !sentenceAnswered;
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
                !sentenceAnswered ? Theme.of(context).accentColor : answerColor,
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
