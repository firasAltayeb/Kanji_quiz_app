import 'package:Kanji_quiz_app/screens/item_detail_screen.dart';
import 'package:Kanji_quiz_app/widgets/shared/kanji_interactive_row.dart';
import 'package:flutter/material.dart';

class SrsLevelColumn extends StatelessWidget {
  final List<dynamic> kanjiMapList;
  final srsLevelOneMap = List<String>();
  final srsLevelTwoMap = List<String>();
  final srsLevelThreeMap = List<String>();
  final srsLevelFourMap = List<String>();
  final srsLevelFiveMap = List<String>();

  SrsLevelColumn({
    @required this.kanjiMapList,
  });

  void assignSrsLists() {
    srsLevelOneMap.clear();
    srsLevelTwoMap.clear();
    srsLevelThreeMap.clear();
    srsLevelFourMap.clear();
    srsLevelFiveMap.clear();
    kanjiMapList.forEach((kanjiMap) {
      switch (kanjiMap['progressLevel']) {
        case 1:
          srsLevelOneMap.add(kanjiMap['colorPhotoAddress']);
          break;
        case 2:
          srsLevelTwoMap.add(kanjiMap['colorPhotoAddress']);
          break;
        case 3:
          srsLevelThreeMap.add(kanjiMap['colorPhotoAddress']);
          break;
        case 4:
          srsLevelFourMap.add(kanjiMap['colorPhotoAddress']);
          break;
        case 5:
          srsLevelFiveMap.add(kanjiMap['colorPhotoAddress']);
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
          kanjiAddresses: srsLevelOneMap,
          selectHandler: pushToItemScreen,
        ),
        textContainer('SRS Level 2 Items', screenHeight, accentColor),
        KanjiInteractiveRow(
          widgetHeight: screenHeight * 0.2,
          kanjiAddresses: srsLevelTwoMap,
          selectHandler: pushToItemScreen,
        ),
        textContainer('SRS Level 3 Items', screenHeight, accentColor),
        KanjiInteractiveRow(
          widgetHeight: screenHeight * 0.2,
          kanjiAddresses: srsLevelThreeMap,
          selectHandler: pushToItemScreen,
        ),
        textContainer('SRS Level 4 Items', screenHeight, accentColor),
        KanjiInteractiveRow(
          widgetHeight: screenHeight * 0.2,
          kanjiAddresses: srsLevelFourMap,
          selectHandler: pushToItemScreen,
        ),
        textContainer(
          'SRS Level 5 Items (Learned)',
          screenHeight,
          accentColor,
        ),
        KanjiInteractiveRow(
          widgetHeight: screenHeight * 0.2,
          kanjiAddresses: srsLevelFiveMap,
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
    var kanjiIndex = kanjiMapList
        .indexWhere((kanjiMap) => kanjiMap['colorPhotoAddress'] == address);

    Navigator.of(context).pushNamed(
      ItemDetailScreen.routeName,
      arguments: kanjiIndex,
    );
  }
}
