import 'package:kanji_quiz_app/widgets/shared/item_interactive_row.dart';
import 'package:kanji_quiz_app/widgets/shared/text_container.dart';
import 'package:kanji_quiz_app/screens/item_detail_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanji_quiz_app/model/study_item_model.dart';
import 'package:flutter/material.dart';
import '../../main_providers.dart';

class SrsLevelColumn extends ConsumerWidget {
  Widget build(BuildContext context, ScopedReader watch) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        TextContainer(
          passedText: 'Review Level 1 Items',
          screenHeight: screenHeight,
        ),
        ItemInteractiveRow(
          itemList: watch(srsXlvlListProvider(1)),
          widgetHeight: screenHeight * 0.2,
          selectHandler: pushToItemScreen,
        ),
        TextContainer(
          passedText: 'Review Level 2 Items',
          screenHeight: screenHeight,
        ),
        ItemInteractiveRow(
          itemList: watch(srsXlvlListProvider(2)),
          widgetHeight: screenHeight * 0.2,
          selectHandler: pushToItemScreen,
        ),
        TextContainer(
          passedText: 'Review Level 3 Items',
          screenHeight: screenHeight,
        ),
        ItemInteractiveRow(
          itemList: watch(srsXlvlListProvider(3)),
          widgetHeight: screenHeight * 0.2,
          selectHandler: pushToItemScreen,
        ),
        TextContainer(
          passedText: 'Practice Level 1 Items',
          screenHeight: screenHeight,
        ),
        ItemInteractiveRow(
          itemList: watch(srsXlvlListProvider(4)),
          widgetHeight: screenHeight * 0.2,
          selectHandler: pushToItemScreen,
        ),
        TextContainer(
          passedText: 'Practice Level 2 Items',
          screenHeight: screenHeight,
        ),
        ItemInteractiveRow(
          itemList: watch(srsXlvlListProvider(5)),
          widgetHeight: screenHeight * 0.2,
          selectHandler: pushToItemScreen,
        ),
        TextContainer(
          passedText: 'Practice Level 3 Items',
          screenHeight: screenHeight,
        ),
        ItemInteractiveRow(
          itemList: watch(srsXlvlListProvider(6)),
          widgetHeight: screenHeight * 0.2,
          selectHandler: pushToItemScreen,
        ),
        TextContainer(
          passedText: 'Learned Items',
          screenHeight: screenHeight,
        ),
        ItemInteractiveRow(
          itemList: watch(srsXlvlListProvider(7)),
          widgetHeight: screenHeight * 0.2,
          selectHandler: pushToItemScreen,
        ),
      ],
    );
  }

  void pushToItemScreen(BuildContext context, StudyItem clickedKanji) {
    context.read(targetItemProvider).state = clickedKanji;
    Navigator.of(context).pushNamed(ItemDetailScreen.routeName);
  }
}
