import 'widgets/misc/main_app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'widgets/shared/main_app_bar.dart';
import 'package:Kanji_quiz_app/main_body.dart';
import 'model/kanji_map.dart';

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  Box<dynamic> _kanjiBox;
  List<dynamic> _kanjiMapList;
  var _reviewMap = List<Map<String, Object>>();
  var _lessonMap = List<Map<String, Object>>();

  @override
  void initState() {
    super.initState();
    print('initializing box');
    _kanjiBox = Hive.box('kanjiBox');
    _kanjiMapList = _kanjiBox.get('map');

    if (_kanjiMapList == null) {
      print('kanjimap is null');
      _kanjiMapList = KanjiMap().initialKanjiMap;
      Hive.box('kanjiBox').put('map', _kanjiMapList);
    } else {
      print('kanjimap is not null');
    }
    _allocateMaps();
  }

  void _reAllocateMaps() {
    setState(() {
      _allocateMaps();
      Hive.box('kanjiBox').put('map', _kanjiMapList);
    });
  }

  void _allocateMaps() {
    print('allocate map called');
    _lessonMap.clear();
    _reviewMap.clear();
    for (var i = 0; i < _kanjiMapList.length; i++) {
      if (_kanjiMapList[i]['learningStatus'] == 'Lesson') {
        _kanjiMapList[i] = new Map<String, Object>.from(_kanjiMapList[i]);
        _lessonMap.add(_kanjiMapList[i]);
      } else if (_kanjiMapList[i]['learningStatus'] == 'Review') {
        _kanjiMapList[i] = new Map<String, Object>.from(_kanjiMapList[i]);
        _addToReview(_kanjiMapList[i]);
      }
    }
    print('LessonMap size is ' + '${_lessonMap.length}');
    print('ReviewMap size is ' + '${_reviewMap.length}');
  }

  void _addToReview(dynamic kanjiMap) {
    switch (kanjiMap['progressLevel']) {
      case 1:
        if (kanjiMap['dateLastLevelChanged']
            .isBefore(DateTime.now().subtract(Duration(seconds: 30))))
          _reviewMap.add(kanjiMap);
        break;
      case 2:
        if (kanjiMap['dateLastLevelChanged']
            .isBefore(DateTime.now().subtract(Duration(hours: 12))))
          _reviewMap.add(kanjiMap);
        break;
      case 3:
        if (kanjiMap['dateLastLevelChanged']
            .isBefore(DateTime.now().subtract(Duration(days: 2))))
          _reviewMap.add(kanjiMap);
        break;
      case 4:
        if (kanjiMap['dateLastLevelChanged']
            .isBefore(DateTime.now().subtract(Duration(days: 4))))
          _reviewMap.add(kanjiMap);
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainAppBar(
          title: 'Home Page',
          appBar: AppBar(),
        ),
        drawer: MainAppDrawer(_reAllocateMaps),
        body: MainBody(
          kanjiMapList: _kanjiMapList,
          lessonMap: _lessonMap,
          reviewMap: _reviewMap,
          reAllocateMaps: _reAllocateMaps,
        ));
  }
}
