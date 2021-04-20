import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanji_quiz_app/model/kanji_model.dart';
import 'package:kanji_quiz_app/screens/item_detail_screen.dart';
import 'package:kanji_quiz_app/widgets/shared/kanji_interactive_row.dart';
import 'package:flutter/material.dart';
import '../../main_providers.dart';

class SrsLevelColumn extends ConsumerWidget {
  Widget build(BuildContext context, ScopedReader watch) {
    var accentColor = Theme.of(context).accentColor;
    var screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        textContainer('SRS Level 1 Items', screenHeight, accentColor),
        KanjiInteractiveRow(
          kanjiList: watch(srsLvlListProvider(1)),
          widgetHeight: screenHeight * 0.2,
          selectHandler: pushToItemScreen,
        ),
        textContainer('SRS Level 2 Items', screenHeight, accentColor),
        KanjiInteractiveRow(
          kanjiList: watch(srsLvlListProvider(2)),
          widgetHeight: screenHeight * 0.2,
          selectHandler: pushToItemScreen,
        ),
        textContainer('SRS Level 3 Items', screenHeight, accentColor),
        KanjiInteractiveRow(
          kanjiList: watch(srsLvlListProvider(3)),
          widgetHeight: screenHeight * 0.2,
          selectHandler: pushToItemScreen,
        ),
        textContainer('SRS Level 4 Items', screenHeight, accentColor),
        KanjiInteractiveRow(
          kanjiList: watch(srsLvlListProvider(4)),
          widgetHeight: screenHeight * 0.2,
          selectHandler: pushToItemScreen,
        ),
        textContainer(
          'SRS Level 5 Items (Learned)',
          screenHeight,
          accentColor,
        ),
        KanjiInteractiveRow(
          kanjiList: watch(srsLvlListProvider(5)),
          widgetHeight: screenHeight * 0.2,
          selectHandler: pushToItemScreen,
        ),
      ],
    );
  }

  Widget textContainer(displayedText, height, color) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 3,
        ),
        color: color,
      ),
      padding: const EdgeInsets.all(5),
      child: Text(
        displayedText,
        style: TextStyle(
          fontSize: height * 0.04,
          fontFamily: 'Anton',
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  void pushToItemScreen(BuildContext context, Kanji clickedKanji) {
    context.read(targetKanjiProvider).state = clickedKanji;
    Navigator.of(context).pushNamed(ItemDetailScreen.routeName);
  }
}
