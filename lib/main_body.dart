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
  var _kanjiMap = Hive.box('kanjiMap').get('map');
  var _lessonMap = List<Map<String, String>>();
  var _reviewMap = List<Map<String, String>>();

  Future navigateToLessonPage(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LessonManager()));
  }

  Future navigateToReviewPage(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ReviewManager()));
  }

  void allocateMaps() {
    for (var i = 0; i < _kanjiMap.length; i++) {
      if (_kanjiMap[i]['learningStatus'] == 'Lesson') {
        var myMap = new Map<String, String>.from(_kanjiMap[i]);
        _lessonMap.add(myMap);
      } else {
        var myMap = new Map<String, String>.from(_kanjiMap[i]);
        _reviewMap.add(myMap);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_kanjiMap == null) {
      print('hive is null');
      _kanjiMap = KanjiMap().initialKanjiMap;
      Hive.box('kanjiMap').put('map', _kanjiMap);
    } else {
      print('hive is not null');
    }

    allocateMaps();

    //print('The kanji map is ' + _kanjiMap.toString());

    // Map<String, String> initalMap = {
    //   'keyword': 'Goods',
    //   'frameNumber': '23',
    //   'learningStatus': 'Review',
    //   'photoAddress': 'assets/images/19_Kanji_xlg.png',
    //   'buildingBlockOne': 'assets/images/11_Kanji_xl.png',
    //   'buildingBlockTwo': 'assets/images/11_Kanji_xl.png'
    // };

    // _kanjiMap.add(initalMap);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            progressButton(context, "Lesson", _lessonMap.length.toString(),
                navigateToLessonPage),
            progressButton(context, "Review", _reviewMap.length.toString(),
                navigateToReviewPage),
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
