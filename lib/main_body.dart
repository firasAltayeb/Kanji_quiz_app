import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'widgets/lesson_pages/lesson_manager.dart';
import 'widgets/review_pages/review_manager.dart';

class MainBody extends StatelessWidget {
  final Function allocateMaps;
  final List<dynamic> kanjiMap;
  final List<Map<String, String>> lessonMap;
  final List<Map<String, String>> reviewMap;

  MainBody({
    @required this.kanjiMap,
    @required this.lessonMap,
    @required this.reviewMap,
    @required this.allocateMaps,
  });

  Future navigateToLessonPage(context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LessonManager(allocateMaps, kanjiMap, lessonMap),
      ),
    );
  }

  Future navigateToReviewPage(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ReviewManager()));
  }

  @override
  Widget build(BuildContext context) {
    // Map<String, String> initalMap = {
    //   'keyword': 'Goods',
    //   'frameNumber': '23',
    //   'learningStatus': 'Lesson',
    //   'photoAddress': 'assets/images/19_Kanji_xlg.png',
    //   'buildingBlockOne': 'assets/images/11_Kanji_xl.png',
    //   'buildingBlockTwo': 'assets/images/11_Kanji_xl.png'
    // };

    // kanjiMap[0]['keyword'] = 'kanjiMap0';
    // kanjiMap[1]['keyword'] = 'kanjiMap1';
    //Hive.box('kanjiBox').put('map', lessonMap);

    // print('kanjibox is ' + '${Hive.box('kanjiBox').get('map')}');
    // print(Hive.box('kanjiBox').get('map').length);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            progressButton(
                context, "Lesson", '${lessonMap.length}', navigateToLessonPage),
            progressButton(
                context, "Review", '${reviewMap.length}', navigateToReviewPage),
          ],
        ),
      ],
    );
  }

  Widget progressButton(
      context, String label, String progress, Function navigate) {
    return Column(
      children: [
        Text(
          label + ": " + progress,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.04,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.yellow,
            border: Border.all(
              color: Colors.black,
              width: 3,
            ),
          ),
          child: FlatButton(
            textColor: Colors.black,
            child: Text('Start',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.03,
                ),
                textAlign: TextAlign.center),
            onPressed: () {
              navigate(context);
            },
          ),
        )
      ],
    );
  }
}
