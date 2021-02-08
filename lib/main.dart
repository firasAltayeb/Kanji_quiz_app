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
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
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
    //_allocateLists();
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
    _timezone = timezone;
  }

  void _reassignList(kanjiList) {
    writeProgressUpdate(kanjiList);

    setState(() {
      _allocateLists(kanjiList);
    });
  }

  void _allocateLists(kanjiList) {
    _lessonList.clear();
    _reviewList.clear();
    for (var i = 0; i < kanjiList.length; i++) {
      if (kanjiList[i].learningStatus == 'Lesson') {
        _lessonList.add(kanjiList[i]);
      } else if (kanjiList[i].learningStatus == 'Review') {
        _addToReview(kanjiList[i]);
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

  Widget build(BuildContext context) {
    print('Material app is built');
    List<Kanji> kanjiList;
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
      home: FutureBuilder<List<Kanji>>(
        future: readProgressUpdate(),
        builder: (context, list) {
          if (list.hasData) {
            kanjiList = list.data;
            _allocateLists(kanjiList);
          }

          return list.hasData
              ? MainScreen(
                  kanjiList: list.data,
                  lessonList: _lessonList,
                  reviewList: _reviewList,
                  reassignLists: () => _reassignList(list.data),
                )
              : Center(child: CircularProgressIndicator());
        },
      ),
      routes: {
        LessonManager.routeName: (ctx) => LessonManager(
            lessonList: _lessonList,
            reassignList: () => _reassignList(kanjiList)),
        ReviewManager.routeName: (ctx) => ReviewManager(
            reviewList: _reviewList,
            reassignList: () => _reassignList(kanjiList)),
        ItemDetailScreen.routeName: (ctx) => ItemDetailScreen(
              kanjiList: kanjiList,
              currentTimeZone: _timezone,
              reassignList: () => _reassignList(kanjiList),
            ),
      },
    );
  }
}
