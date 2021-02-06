import 'package:Kanji_quiz_app/screens/item_detail_screen.dart';
import 'package:Kanji_quiz_app/widgets/shared/kanji_interactive_row.dart';
import 'package:flutter/material.dart';

class SrsLevelColumn extends StatelessWidget {
  final List<dynamic> kanjiMapList;
  final _srsLevelOneIds = List<String>();
  final _srsLevelTwoIds = List<String>();
  final _srsLevelThreeIds = List<String>();
  final _srsLevelFourIds = List<String>();
  final _srsLevelFiveIds = List<String>();

  SrsLevelColumn({
    @required this.kanjiMapList,
  });

  void assignSrsLists() {
    _srsLevelOneIds.clear();
    _srsLevelTwoIds.clear();
    _srsLevelThreeIds.clear();
    _srsLevelFourIds.clear();
    _srsLevelFiveIds.clear();
    kanjiMapList.forEach((kanjiMap) {
      switch (kanjiMap['progressLevel']) {
        case 1:
          _srsLevelOneIds.add(kanjiMap['itemId']);
          break;
        case 2:
          _srsLevelTwoIds.add(kanjiMap['itemId']);
          break;
        case 3:
          _srsLevelThreeIds.add(kanjiMap['itemId']);
          break;
        case 4:
          _srsLevelFourIds.add(kanjiMap['itemId']);
          break;
        case 5:
          _srsLevelFiveIds.add(kanjiMap['itemId']);
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
          widgetHeight: screenHeight * 0.2,
          kanjiIds: _srsLevelOneIds,
          selectHandler: pushToItemScreen,
        ),
        textContainer('SRS Level 2 Items', screenHeight, accentColor),
        KanjiInteractiveRow(
          widgetHeight: screenHeight * 0.2,
          kanjiIds: _srsLevelTwoIds,
          selectHandler: pushToItemScreen,
        ),
        textContainer('SRS Level 3 Items', screenHeight, accentColor),
        KanjiInteractiveRow(
          widgetHeight: screenHeight * 0.2,
          kanjiIds: _srsLevelThreeIds,
          selectHandler: pushToItemScreen,
        ),
        textContainer('SRS Level 4 Items', screenHeight, accentColor),
        KanjiInteractiveRow(
          widgetHeight: screenHeight * 0.2,
          kanjiIds: _srsLevelFourIds,
          selectHandler: pushToItemScreen,
        ),
        textContainer(
          'SRS Level 5 Items (Learned)',
          screenHeight,
          accentColor,
        ),
        KanjiInteractiveRow(
          widgetHeight: screenHeight * 0.2,
          kanjiIds: _srsLevelFiveIds,
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
    var kanjiIndex =
        kanjiMapList.indexWhere((kanjiMap) => kanjiMap['itemId'] == address);

    Navigator.of(context).pushNamed(
      ItemDetailScreen.routeName,
      arguments: kanjiIndex,
    );
  }
}
