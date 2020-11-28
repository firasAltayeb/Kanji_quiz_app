import 'package:Kanji_quiz_app/model/kanji_map.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'widgets/lesson_pages/lesson_manager.dart';
import 'widgets/review_pages/review_manager.dart';

class MainBody extends StatefulWidget {
  @override
  _MainBodyState createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  var kanjiMap = Hive.box('kanjiMap').get('map') == null
      ? KanjiMap().initialKanjiMap
      : Hive.box('kanjiMap').get('map');

  @override
  Widget build(BuildContext context) {
    print('The kanji map is ' + kanjiMap.toString());

    Map<String, String> initalMap = {
      'keyword': 'Oneself',
      'frameNumber': '17',
      'photoAddress': 'assets/images/17_Kanji_xlg.png',
      'buildingBlockOne': 'assets/images/5_Kanji_xl.png',
      'buildingBlockTwo': 'assets/images/11_Kanji_xl.png'
    };

    var lessonCount = kanjiMap.length.toString();

    kanjiMap.add(initalMap);

    Hive.box('kanjiMap').put('map', kanjiMap);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            progressButton(
                context, "Lesson", lessonCount, navigateToLessonPage),
            progressButton(context, "Review", "4", navigateToReviewPage),
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

  Future navigateToLessonPage(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LessonManager()));
  }

  Future navigateToReviewPage(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ReviewManager()));
  }
}
