import 'package:kanji_quiz_app/model/progress_model.dart';
import 'package:kanji_quiz_app/screens/item_detail_screen.dart';
import 'package:kanji_quiz_app/widgets/shared/kanji_interactive_row.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SrsLevelColumn extends StatelessWidget {
  final List<Progress> kanjiList;
  List<String> _srsLevelOneIds = [];
  List<String> _srsLevelTwoIds = [];
  List<String> _srsLevelThreeIds = [];
  List<String> _srsLevelFourIds = [];
  List<String> _srsLevelFiveIds = [];

  SrsLevelColumn({
    @required this.kanjiList,
  });

  void assignSrsLists() {
    _srsLevelOneIds.clear();
    _srsLevelTwoIds.clear();
    _srsLevelThreeIds.clear();
    _srsLevelFourIds.clear();
    _srsLevelFiveIds.clear();
    kanjiList.forEach((item) {
      switch (item.progressLevel) {
        case 1:
          _srsLevelOneIds.add(item.characterLook);
          break;
        case 2:
          _srsLevelTwoIds.add(item.characterLook);
          break;
        case 3:
          _srsLevelThreeIds.add(item.characterLook);
          break;
        case 4:
          _srsLevelFourIds.add(item.characterLook);
          break;
        case 5:
          _srsLevelFiveIds.add(item.characterLook);
          break;
        default:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    assignSrsLists();
    var accentColor = Theme.of(context).accentColor;
    var screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        textContainer('SRS Level 1 Items', screenHeight, accentColor),
        KanjiInteractiveRow(
          kanjiList: kanjiList,
          widgetHeight: screenHeight * 0.2,
          itemIds: _srsLevelOneIds,
          selectHandler: pushToItemScreen,
        ),
        textContainer('SRS Level 2 Items', screenHeight, accentColor),
        KanjiInteractiveRow(
          kanjiList: kanjiList,
          widgetHeight: screenHeight * 0.2,
          itemIds: _srsLevelTwoIds,
          selectHandler: pushToItemScreen,
        ),
        textContainer('SRS Level 3 Items', screenHeight, accentColor),
        KanjiInteractiveRow(
          kanjiList: kanjiList,
          widgetHeight: screenHeight * 0.2,
          itemIds: _srsLevelThreeIds,
          selectHandler: pushToItemScreen,
        ),
        textContainer('SRS Level 4 Items', screenHeight, accentColor),
        KanjiInteractiveRow(
          kanjiList: kanjiList,
          widgetHeight: screenHeight * 0.2,
          itemIds: _srsLevelFourIds,
          selectHandler: pushToItemScreen,
        ),
        textContainer(
          'SRS Level 5 Items (Learned)',
          screenHeight,
          accentColor,
        ),
        KanjiInteractiveRow(
          kanjiList: kanjiList,
          widgetHeight: screenHeight * 0.2,
          itemIds: _srsLevelFiveIds,
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

  void pushToItemScreen(BuildContext context, String address) {
    var kanjiIndex = kanjiList
        .indexWhere((reviewedItem) => reviewedItem.characterLook == address);

    Navigator.of(context).pushNamed(
      ItemDetailScreen.routeName,
      arguments: kanjiIndex,
    );
  }
}
