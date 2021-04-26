import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../main_providers.dart';

class ItemDifficultyRow extends ConsumerWidget {
  Widget build(BuildContext context, ScopedReader watch) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    final targetK = watch(targetKanjiProvider).state;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: screenHeight * 0.05,
          width: screenWidth * 0.6,
          child: FittedBox(
            fit: BoxFit.fill,
            child: Text(
              'Item difficulty is: ${targetK.difficultyMeaning()}',
              style: TextStyle(
                fontFamily: 'Anton',
              ),
            ),
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
                if (targetK.chosenDifficulty > 1) {
                  targetK.chosenDifficulty--;
                  context.read(targetKanjiProvider).state = targetK;
                  context.read(kanjiListProvider.notifier).editKanji(targetK);
                  context.read(kanjiListProvider.notifier).saveProgress();
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
                if (targetK.chosenDifficulty < 4) {
                  targetK.chosenDifficulty++;
                  context.read(targetKanjiProvider).state = targetK;
                  context.read(kanjiListProvider.notifier).editKanji(targetK);
                  context.read(kanjiListProvider.notifier).saveProgress();
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
