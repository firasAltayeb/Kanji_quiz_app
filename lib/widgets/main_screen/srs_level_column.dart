import 'package:Kanji_quiz_app/screens/item_detail_screen.dart';
import 'package:Kanji_quiz_app/widgets/shared/kanji_interactive_row.dart';
import 'package:flutter/material.dart';

class SrsLevelColumn extends StatelessWidget {
  final List<dynamic> kanjiMapList;
  final _srsLevelOneMap = List<String>();
  final _srsLevelTwoMap = List<String>();
  final _srsLevelThreeMap = List<String>();
  final _srsLevelFourMap = List<String>();
  final _srsLevelFiveMap = List<String>();

  SrsLevelColumn({
    @required this.kanjiMapList,
  });

  void assignSrsLists() {
    _srsLevelOneMap.clear();
    _srsLevelTwoMap.clear();
    _srsLevelThreeMap.clear();
    _srsLevelFourMap.clear();
    _srsLevelFiveMap.clear();
    kanjiMapList.forEach((kanjiMap) {
      switch (kanjiMap['progressLevel']) {
        case 1:
          _srsLevelOneMap.add(kanjiMap['itemId']);
          break;
        case 2:
          _srsLevelTwoMap.add(kanjiMap['itemId']);
          break;
        case 3:
          _srsLevelThreeMap.add(kanjiMap['itemId']);
          break;
        case 4:
          _srsLevelFourMap.add(kanjiMap['itemId']);
          break;
        case 5:
          _srsLevelFiveMap.add(kanjiMap['itemId']);
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
          kanjiIds: _srsLevelOneMap,
          selectHandler: pushToItemScreen,
        ),
        textContainer('SRS Level 2 Items', screenHeight, accentColor),
        KanjiInteractiveRow(
          widgetHeight: screenHeight * 0.2,
          kanjiIds: _srsLevelTwoMap,
          selectHandler: pushToItemScreen,
        ),
        textContainer('SRS Level 3 Items', screenHeight, accentColor),
        KanjiInteractiveRow(
          widgetHeight: screenHeight * 0.2,
          kanjiIds: _srsLevelThreeMap,
          selectHandler: pushToItemScreen,
        ),
        textContainer('SRS Level 4 Items', screenHeight, accentColor),
        KanjiInteractiveRow(
          widgetHeight: screenHeight * 0.2,
          kanjiIds: _srsLevelFourMap,
          selectHandler: pushToItemScreen,
        ),
        textContainer(
          'SRS Level 5 Items (Learned)',
          screenHeight,
          accentColor,
        ),
        KanjiInteractiveRow(
          widgetHeight: screenHeight * 0.2,
          kanjiIds: _srsLevelFiveMap,
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
