import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:Kanji_quiz_app/main_body.dart';
import 'widgets/misc_pages/user_page.dart';
import 'model/kanji_map.dart';

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  Box<dynamic> _kanjiBox;
  List<dynamic> _kanjiMap;
  var _reviewMap = List<Map<String, String>>();
  var _lessonMap = List<Map<String, String>>();

  void _allocateMaps() {
    print('allocation start');
    var stringMap;
    _lessonMap.clear();
    _reviewMap.clear();
    for (var i = 0; i < _kanjiMap.length; i++) {
      if (_kanjiMap[i]['learningStatus'] == 'Review') {
        stringMap = new Map<String, String>.from(_kanjiMap[i]);
        _reviewMap.add(stringMap);
      } else {
        stringMap = new Map<String, String>.from(_kanjiMap[i]);
        _lessonMap.add(stringMap);
      }
    }
    print('LessonMap size is ' + '${_lessonMap.length}');
    print('ReviewMap size is ' + '${_reviewMap.length}');
  }

  @override
  void initState() {
    print('initializing box');
    super.initState();
    _kanjiBox = Hive.box('kanjiBox');
    _kanjiMap = _kanjiBox.get('map');

    if (_kanjiMap == null) {
      print('kanjimap is null');
      _kanjiMap = KanjiMap().initialKanjiMap;
      Hive.box('kanjiBox').put('map', _kanjiMap);
    } else {
      print('kanjimap is not null');
    }
    _allocateMaps();
  }

  @override
  Widget build(BuildContext context) {
    print('Home build is called');
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Kanji Quiz App'),
          actions: [
            IconButton(
              icon: Icon(
                Icons.search_rounded,
                color: Colors.white,
                size: MediaQuery.of(context).size.height * 0.05,
              ),
              onPressed: null,
            ),
            IconButton(
              icon: Icon(
                Icons.account_circle_outlined,
                color: Colors.white,
                size: MediaQuery.of(context).size.height * 0.05,
              ),
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => UserPage())),
            ),
          ],
        ),
        body: MainBody(
          kanjiMap: _kanjiMap,
          lessonMap: _lessonMap,
          reviewMap: _reviewMap,
          allocateMaps: _allocateMaps,
        ));
  }
}
