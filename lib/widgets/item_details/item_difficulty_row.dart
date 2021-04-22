import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../main_providers.dart';

class ItemDifficultyRow extends ConsumerWidget {
  Widget build(BuildContext context, ScopedReader watch) {
    var screenHeight = MediaQuery.of(context).size.height;
    final targetKanji = watch(targetKanjiProvider).state;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'Item difficulty is: ${targetKanji.difficultyMeaning()}',
          style: TextStyle(
            fontSize: screenHeight * 0.035,
            fontFamily: 'Anton',
          ),
        ),
        CircleAvatar(
          radius: (screenHeight * 0.03) + 6,
          backgroundColor: Colors.black,
          child: CircleAvatar(
            radius: (screenHeight * 0.03) + 4,
            backgroundColor: Colors.green,
            child: IconButton(
              onPressed: () {
                if (targetKanji.chosenDifficulty > 1) {
                  targetKanji.chosenDifficulty--;

                  context.read(targetKanjiProvider).state = targetKanji;
                  context
                      .read(kanjiListProvider.notifier)
                      .editKanji(targetKanji);
                }
              },
              iconSize: screenHeight * 0.04,
              icon: Icon(
                Icons.arrow_downward,
                color: Colors.white,
              ),
            ),
          ),
        ),
        CircleAvatar(
          radius: (screenHeight * 0.03) + 6,
          backgroundColor: Colors.black,
          child: CircleAvatar(
            radius: (screenHeight * 0.03) + 4,
            backgroundColor: Colors.red,
            child: IconButton(
              onPressed: () {
                if (targetKanji.chosenDifficulty < 4) {
                  targetKanji.chosenDifficulty++;
                  context.read(targetKanjiProvider).state = targetKanji;
                  context
                      .read(kanjiListProvider.notifier)
                      .editKanji(targetKanji);
                }
              },
              iconSize: screenHeight * 0.04,
              icon: Icon(
                Icons.arrow_upward,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
