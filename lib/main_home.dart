import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import './widgets/misc_widgets/main_app_bar.dart';
import 'package:Kanji_quiz_app/main_body.dart';
import 'model/kanji_map.dart';

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  Box<dynamic> _kanjiBox;
  List<dynamic> _kanjiMap;
  var _reviewMap = List<Map<String, Object>>();
  var _lessonMap = List<Map<String, Object>>();

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

  void _reAllocateMaps() {
    setState(() {
      _allocateMaps();
      Hive.box('kanjiBox').put('map', _kanjiMap);
    });
  }

  void _allocateMaps() {
    print('allocation start');
    _lessonMap.clear();
    _reviewMap.clear();
    for (var i = 0; i < _kanjiMap.length; i++) {
      if (_kanjiMap[i]['learningStatus'] == 'Lesson') {
        _kanjiMap[i] = new Map<String, Object>.from(_kanjiMap[i]);
        _lessonMap.add(_kanjiMap[i]);
      } else if (_kanjiMap[i]['learningStatus'] == 'Review') {
        _kanjiMap[i] = new Map<String, Object>.from(_kanjiMap[i]);
        _reviewMap.add(_kanjiMap[i]);
      }
    }
    print('LessonMap size is ' + '${_lessonMap.length}');
    print('ReviewMap size is ' + '${_reviewMap.length}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainAppBar(
          title: 'Kanji App',
          appBar: AppBar(),
        ),
        body: MainBody(
          kanjiMap: _kanjiMap,
          lessonMap: _lessonMap,
          reviewMap: _reviewMap,
          reAllocateMaps: _reAllocateMaps,
        ));
  }
}
