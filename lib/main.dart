import 'dart:convert';

import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:Kanji_quiz_app/screens/item_detail_screen.dart';
import 'package:Kanji_quiz_app/screens/lesson_mgr_screen.dart';
import 'package:Kanji_quiz_app/screens/review_mgr_screen.dart';
import 'package:Kanji_quiz_app/model/kanji_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'model/kanji_model.dart';
import 'main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print('retrieving json data');
  List<Kanji> kanjiList = await loadKanjiList();
  print('finished retrieving json');
  runApp(MyApp(kanjiList));
}

class MyApp extends StatefulWidget {
  final List<Kanji> kanjiList;

  MyApp(this.kanjiList);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _reviewList = List<Kanji>();
  var _lessonList = List<Kanji>();
  String _timezone = 'Unknown';

  @override
  void initState() {
    super.initState();
    _allocateLists();
    _initTimeZone();
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

  void _reassignLists([List<Kanji> kanjiList]) {
    // if (kanjiList != null) {
    //   Map<String, dynamic> map = Kanji().toJson();
    //   String encoded = jsonEncode(map);
    //   print(encoded);
    // }

    setState(() {
      _allocateLists();
    });
  }

  void _allocateLists() {
    _lessonList.clear();
    _reviewList.clear();
    for (var i = 0; i < widget.kanjiList.length; i++) {
      if (widget.kanjiList[i].learningStatus == 'Lesson') {
        _lessonList.add(widget.kanjiList[i]);
      } else if (widget.kanjiList[i].learningStatus == 'Review') {
        _addToReview(widget.kanjiList[i]);
      }
    }
    print('allocate lists called');
    print('LessonList size is ' + '${_lessonList.length}');
    print('ReviewList size is ' + '${_reviewList.length}');
  }

  void _addToReview(Kanji kanjiItem) {
    switch (kanjiItem.progressLevel) {
      case 1:
        if (kanjiItem.dateLastLevelChanged
            .isBefore(DateTime.now().subtract(Duration(seconds: 4))))
          _reviewList.add(kanjiItem);
        break;
      case 2:
        if (kanjiItem.dateLastLevelChanged
            .isBefore(DateTime.now().subtract(Duration(hours: 12))))
          _reviewList.add(kanjiItem);
        break;
      case 3:
        if (kanjiItem.dateLastLevelChanged
            .isBefore(DateTime.now().subtract(Duration(days: 2))))
          _reviewList.add(kanjiItem);
        break;
      case 4:
        if (kanjiItem.dateLastLevelChanged
            .isBefore(DateTime.now().subtract(Duration(days: 4))))
          _reviewList.add(kanjiItem);
        break;
      default:
        break;
    }
  }

  void _resetItem(Map<String, Object> itemDetails) {
    itemDetails['learningStatus'] = 'Lesson';
    itemDetails['progressLevel'] = '0';
    itemDetails['mnemonicStory'] = '';
    _reassignLists();
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
              kanjiList: widget.kanjiList,
              lessonList: _lessonList,
              reviewList: _reviewList,
              reassignLists: _reassignLists,
            ),
        LessonManager.routeName: (ctx) => LessonManager(
              reassignList: _reassignLists,
              lessonList: _lessonList,
            ),
        ReviewManager.routeName: (ctx) => ReviewManager(
              reassignLists: _reassignLists,
              reviewList: _reviewList,
            ),
        ItemDetailScreen.routeName: (ctx) => ItemDetailScreen(
              kanjiList: widget.kanjiList,
              reassignLists: _reassignLists,
              resetItemStatus: _resetItem,
              currentTimeZone: _timezone,
            ),
      },
    );
  }
}
