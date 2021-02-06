import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:Kanji_quiz_app/screens/item_detail_screen.dart';
import 'package:Kanji_quiz_app/screens/lesson_mgr_screen.dart';
import 'package:Kanji_quiz_app/screens/review_mgr_screen.dart';
import 'package:Kanji_quiz_app/model/kanji_services.dart';
import 'package:flutter/services.dart';
import 'model/kanji_model.dart';
import 'model/kanji_map.dart';

import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'main_screen.dart';

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
  List<Kanji> _kanjiList;
  Box<dynamic> _kanjiBox;
  List<dynamic> _kanjiMapList;
  String _timezone = 'Unknown';
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
    _initTimeZone();
    _retrieveJsonData();
  }

  Future<void> _retrieveJsonData() async {
    _kanjiList = await loadKanjiList();
    print(_kanjiList[1].buildingBlocks);
  }

  Future<void> _initTimeZone() async {
    String timezone;
    try {
      timezone = await FlutterNativeTimezone.getLocalTimezone();
    } on PlatformException {
      timezone = 'Failed to get the timezone.';
    }

    if (!mounted) return;

    setState(() {
      _timezone = timezone;
    });
  }

  void _reAllocateMaps() {
    setState(() {
      _allocateMaps();
      Hive.box('kanjiBox').put('map', _kanjiMapList);
    });
  }

  void _allocateMaps() {
    _lessonMap.clear();
    _reviewMap.clear();
    for (var i = 0; i < _kanjiMapList.length; i++) {
      if (_kanjiMapList[i]['dateLastLevelChanged'] == '') {
        _kanjiMapList[i]['dateLastLevelChanged'] =
            DateTime.now().subtract(Duration(days: 5));
        print(_kanjiMapList[i]);
      }
      if (_kanjiMapList[i]['learningStatus'] == 'Lesson') {
        _kanjiMapList[i] = new Map<String, Object>.from(_kanjiMapList[i]);
        _lessonMap.add(_kanjiMapList[i]);
      } else if (_kanjiMapList[i]['learningStatus'] == 'Review') {
        _kanjiMapList[i] = new Map<String, Object>.from(_kanjiMapList[i]);
        _addToReview(_kanjiMapList[i]);
      }
    }
    print('allocate map called');
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

  void _resetItem(Map<String, Object> itemDetails) {
    itemDetails['learningStatus'] = 'Lesson';
    itemDetails['progressLevel'] = '0';
    itemDetails['mnemonicStory'] = '';
    _reAllocateMaps();
  }

  Widget build(BuildContext context) {
    print('Material app is built');
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
        LessonManager.routeName: (ctx) => LessonManager(
              reAllocateMaps: _reAllocateMaps,
              lessonMap: _lessonMap,
            ),
        ReviewManager.routeName: (ctx) => ReviewManager(
              reAllocateMaps: _reAllocateMaps,
              reviewListMap: _reviewMap,
            ),
        ItemDetailScreen.routeName: (ctx) => ItemDetailScreen(
              reAllocateMaps: _reAllocateMaps,
              kanjiMapList: _kanjiMapList,
              resetItemStatus: _resetItem,
              currentTimeZone: _timezone,
            ),
      },
    );
  }
}
