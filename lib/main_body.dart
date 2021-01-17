import 'package:flutter/material.dart';
import 'screens/lesson_mgr_screen.dart';
import 'screens/review_mgr_screen.dart';
import 'widgets/shared/kanji_interactive_row.dart';

class MainBody extends StatelessWidget {
  final Function reAllocateMaps;
  final List<dynamic> kanjiMap;
  final List<Map<String, Object>> lessonMap;
  final List<Map<String, Object>> reviewMap;
  final srsLevelOneMap = List<String>();
  final srsLevelTwoMap = List<String>();
  final srsLevelThreeMap = List<String>();
  final srsLevelFourMap = List<String>();
  final srsLevelFiveMap = List<String>();

  MainBody({
    @required this.kanjiMap,
    @required this.lessonMap,
    @required this.reviewMap,
    @required this.reAllocateMaps,
  });

  Future navigateToLessonPage(context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LessonManager(reAllocateMaps, lessonMap),
      ),
    );
  }

  Future navigateToReviewPage(context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReviewManager(reAllocateMaps, reviewMap),
      ),
    );
  }

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
    print('Main body build is called');
    assignSrsLists();
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              progressButton(
                  context, "Lesson", lessonMap.length, navigateToLessonPage),
              progressButton(
                  context, "Review", reviewMap.length, navigateToReviewPage),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          textContainer('SRS Level 1 Items', context),
          KanjiInteractiveRow(
            widgetHeight: MediaQuery.of(context).size.height * 0.2,
            kanjiAddresses: srsLevelOneMap,
          ),
          textContainer('SRS Level 2 Items', context),
          KanjiInteractiveRow(
            widgetHeight: MediaQuery.of(context).size.height * 0.2,
            kanjiAddresses: srsLevelTwoMap,
          ),
          textContainer('SRS Level 3 Items', context),
          KanjiInteractiveRow(
            widgetHeight: MediaQuery.of(context).size.height * 0.2,
            kanjiAddresses: srsLevelThreeMap,
          ),
          textContainer('SRS Level 4 Items', context),
          KanjiInteractiveRow(
            widgetHeight: MediaQuery.of(context).size.height * 0.2,
            kanjiAddresses: srsLevelFourMap,
          ),
          textContainer('SRS Level 5 Items (Learned)', context),
          KanjiInteractiveRow(
            widgetHeight: MediaQuery.of(context).size.height * 0.2,
            kanjiAddresses: srsLevelFiveMap,
          ),
        ],
      ),
    );
  }

  Widget progressButton(
      context, String label, int progress, Function navigate) {
    return Column(
      children: [
        Text(
          label + ": " + '$progress',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.04,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Container(
          width: MediaQuery.of(context).size.height * 0.2,
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            border: Border.all(
              color: Colors.black,
              width: 3,
            ),
          ),
          child: FlatButton(
            textColor: Colors.black,
            child: Text('Start',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.04,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center),
            onPressed: progress == 0 ? null : () => navigate(context),
          ),
        )
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
