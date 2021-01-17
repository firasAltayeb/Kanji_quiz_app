import 'package:Kanji_quiz_app/screens/item_detail_screen.dart';
import 'package:Kanji_quiz_app/widgets/shared/kanji_interactive_row.dart';
import 'package:flutter/material.dart';

class SrsLevelColumn extends StatelessWidget {
  final List<dynamic> kanjiMap;
  final srsLevelOneMap = List<String>();
  final srsLevelTwoMap = List<String>();
  final srsLevelThreeMap = List<String>();
  final srsLevelFourMap = List<String>();
  final srsLevelFiveMap = List<String>();

  Future pushToItemScreen(context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ItemDetailScreen(),
      ),
    );
  }

  SrsLevelColumn({
    @required this.kanjiMap,
  });

  void assignSrsLists() {
    for (int index = 0; index < kanjiMap.length; index++) {
      print('index is $index');
      switch (kanjiMap[index]['progressLevel']) {
        case 1:
          srsLevelOneMap.add(kanjiMap[index]['colorPhotoAddress']);
          break;
        case 2:
          srsLevelTwoMap.add(kanjiMap[index]['colorPhotoAddress']);
          break;
        case 3:
          srsLevelThreeMap.add(kanjiMap[index]['colorPhotoAddress']);
          break;
        case 4:
          srsLevelFourMap.add(kanjiMap[index]['colorPhotoAddress']);
          break;
        case 5:
          srsLevelFiveMap.add(kanjiMap[index]['colorPhotoAddress']);
          break;
        default:
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    assignSrsLists();
    return Column(
      children: [
        textContainer('SRS Level 1 Items', context),
        KanjiInteractiveRow(
          widgetHeight: MediaQuery.of(context).size.height * 0.2,
          kanjiAddresses: srsLevelOneMap,
          selectHandler: pushToItemScreen,
        ),
        textContainer('SRS Level 2 Items', context),
        KanjiInteractiveRow(
          widgetHeight: MediaQuery.of(context).size.height * 0.2,
          kanjiAddresses: srsLevelTwoMap,
          selectHandler: pushToItemScreen,
        ),
        textContainer('SRS Level 3 Items', context),
        KanjiInteractiveRow(
          widgetHeight: MediaQuery.of(context).size.height * 0.2,
          kanjiAddresses: srsLevelThreeMap,
          selectHandler: pushToItemScreen,
        ),
        textContainer('SRS Level 4 Items', context),
        KanjiInteractiveRow(
          widgetHeight: MediaQuery.of(context).size.height * 0.2,
          kanjiAddresses: srsLevelFourMap,
          selectHandler: pushToItemScreen,
        ),
        textContainer('SRS Level 5 Items (Learned)', context),
        KanjiInteractiveRow(
          widgetHeight: MediaQuery.of(context).size.height * 0.2,
          kanjiAddresses: srsLevelFiveMap,
          selectHandler: pushToItemScreen,
        ),
      ],
    );
  }

  Widget textContainer(String txt, BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 3,
        ),
        color: Theme.of(context).accentColor,
      ),
      padding: const EdgeInsets.all(5),
      child: Text(
        txt,
        style: TextStyle(
          fontSize: 25,
          fontFamily: 'Anton',
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}
