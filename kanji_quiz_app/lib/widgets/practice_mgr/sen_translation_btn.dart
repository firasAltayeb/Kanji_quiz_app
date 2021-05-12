import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanji_quiz_app/model/kanji_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../main_providers.dart';

enum HabticLevels {
  Vibrate,
  Heavy,
  Medium,
  Light,
}

class TranslationOptionBtn extends ConsumerWidget {
  final List<Kanji> practiceList;
  final HabticLevels habticLevel;

  TranslationOptionBtn(
    this.practiceList,
    this.habticLevel,
  );

  Widget build(BuildContext context, ScopedReader watch) {
    final practiceQueueIdx = watch(practiceQueueIdxProvider).state;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        switch (habticLevel) {
          case HabticLevels.Vibrate:
            HapticFeedback.vibrate();
            break;
          case HabticLevels.Heavy:
            HapticFeedback.heavyImpact();
            break;
          case HabticLevels.Medium:
            HapticFeedback.mediumImpact();
            break;
          case HabticLevels.Light:
            HapticFeedback.lightImpact();
            break;
        }
        if (practiceQueueIdx < practiceList.length - 1) {
          context.read(sentenceQueueIdxProvider).state = 1;
          context.read(targetKanjiProvider).state =
              practiceList[practiceQueueIdx + 1];
          context.read(practiceQueueIdxProvider).state++;
        } else {
          context.read(sentenceQueueIdxProvider).state = 1;
          context.read(practiceQueueIdxProvider).state = 0;
          Navigator.of(context).pop();
        }
      },
      child: Ink(
        padding: const EdgeInsets.fromLTRB(5, 2.5, 5, 2.5),
        width: screenWidth * 0.95,
        height: screenHeight * 0.08,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 3,
          ),
          color: Theme.of(context).accentColor,
        ),
        child: FittedBox(
          fit: BoxFit.fill,
          child: Text(
            "extracted sentence translation \n answer button option",
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
