import 'package:Kanji_quiz_app/screens/item_detail_screen.dart';
import 'package:Kanji_quiz_app/screens/lesson_mgr_screen.dart';
import 'package:Kanji_quiz_app/screens/review_mgr_screen.dart';

import 'main_screen.dart';
import 'model/kanji_map.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  await Hive.openBox('kanjiBox');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
            .isBefore(DateTime.now().subtract(Duration(seconds: 4))))
          _reviewMap.add(kanjiMap);
        break;
      case 2:
        if (kanjiMap['dateLastLevelChanged']
            .isBefore(DateTime.now().subtract(Duration(seconds: 12))))
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

  void _resetItem(Map<String, Object> itemDetails) {
    setState(() {
      itemDetails['learningStatus'] = 'Lesson';
      itemDetails['progressLevel'] = '0';
      itemDetails['mnemonicStory'] = '';
      _reAllocateMaps();
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kanji Quiz App',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        accentColor: Colors.yellow[700],
        fontFamily: 'Lato',
        appBarTheme: AppBarTheme(color: Colors.black),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            side: BorderSide(width: 3, color: Colors.black),
            primary: Colors.yellow[700],
            padding: const EdgeInsets.all(10),
            minimumSize: Size(30, 30),
            onPrimary: Colors.black,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => MainScreen(
              kanjiMapList: _kanjiMapList,
              lessonMap: _lessonMap,
              reviewMap: _reviewMap,
              reAllocateMaps: _reAllocateMaps,
            ),
        LessonManager.routeName: (ctx) =>
            LessonManager(_reAllocateMaps, _lessonMap),
        ReviewManager.routeName: (ctx) =>
            ReviewManager(_reAllocateMaps, _reviewMap),
        ItemDetailScreen.routeName: (ctx) {
          return ItemDetailScreen(
            reAllocateMaps: _reAllocateMaps,
            kanjiMapList: _kanjiMapList,
            resetItemStatus: _resetItem,
          );
        }
      },
    );
  }
}
