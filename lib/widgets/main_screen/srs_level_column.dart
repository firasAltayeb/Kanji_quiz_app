import 'package:kanji_quiz_app/widgets/shared/kanji_interactive_row.dart';
import 'package:kanji_quiz_app/widgets/shared/text_container.dart';
import 'package:kanji_quiz_app/screens/item_detail_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanji_quiz_app/model/kanji_model.dart';
import 'package:flutter/material.dart';
import '../../main_providers.dart';

class SrsLevelColumn extends ConsumerWidget {
  Widget build(BuildContext context, ScopedReader watch) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        TextContainer(
          passedText: 'SRS Level 1 Items',
          screenHeight: screenHeight,
        ),
        KanjiInteractiveRow(
          kanjiList: watch(srsXlvlListProvider(1)),
          widgetHeight: screenHeight * 0.2,
          selectHandler: pushToItemScreen,
        ),
        TextContainer(
          passedText: 'SRS Level 2 Items',
          screenHeight: screenHeight,
        ),
        KanjiInteractiveRow(
          kanjiList: watch(srsXlvlListProvider(2)),
          widgetHeight: screenHeight * 0.2,
          selectHandler: pushToItemScreen,
        ),
        TextContainer(
          passedText: 'SRS Level 3 Items',
          screenHeight: screenHeight,
        ),
        KanjiInteractiveRow(
          kanjiList: watch(srsXlvlListProvider(3)),
          widgetHeight: screenHeight * 0.2,
          selectHandler: pushToItemScreen,
        ),
        TextContainer(
          passedText: 'SRS Level 4 Items',
          screenHeight: screenHeight,
        ),
        KanjiInteractiveRow(
          kanjiList: watch(srsXlvlListProvider(4)),
          widgetHeight: screenHeight * 0.2,
          selectHandler: pushToItemScreen,
        ),
        TextContainer(
          passedText: 'SRS Level 5 Items',
          screenHeight: screenHeight,
        ),
        KanjiInteractiveRow(
          kanjiList: watch(srsXlvlListProvider(5)),
          widgetHeight: screenHeight * 0.2,
          selectHandler: pushToItemScreen,
        ),
        TextContainer(
          passedText: 'Ready to Practice',
          screenHeight: screenHeight,
        ),
        KanjiInteractiveRow(
          kanjiList: watch(srsXlvlListProvider(6)),
          widgetHeight: screenHeight * 0.2,
          selectHandler: pushToItemScreen,
        ),
        TextContainer(
          passedText: 'Learned Items',
          screenHeight: screenHeight,
        ),
        KanjiInteractiveRow(
          kanjiList: watch(srsXlvlListProvider(7)),
          widgetHeight: screenHeight * 0.2,
          selectHandler: pushToItemScreen,
        ),
      ],
    );
  }

  void pushToItemScreen(BuildContext context, Kanji clickedKanji) {
    context.read(targetKanjiProvider).state = clickedKanji;
    Navigator.of(context).pushNamed(ItemDetailScreen.routeName);
  }
}
