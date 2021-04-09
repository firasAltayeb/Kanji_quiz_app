import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:kanji_quiz_app/screens/item_detail_screen.dart';
import 'package:kanji_quiz_app/screens/lesson_mgr_screen.dart';
import 'package:kanji_quiz_app/screens/review_mgr_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:kanji_quiz_app/model/progress_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'model/progress_model.dart';
import 'main_screen.dart';

void main() async {
  String timezone;
  try {
    timezone = await FlutterNativeTimezone.getLocalTimezone();
  } on PlatformException {
    timezone = 'Failed to get the timezone.';
  }
  runApp(ProviderScope(child: MyApp(timezone)));
}

final progressProvider = FutureProvider<List<Progress>>((ref) async {
  if (!await Permission.storage.isGranted) {
    await Permission.storage.request();
  }
  return readProgressUpdate();
});

class MyApp extends ConsumerWidget {
  final String timezone;
  List<Progress> _reviewList = [];
  List<Progress> _lessonList = [];

  MyApp(this.timezone);

  void _reassignList(kanjiList) async {
    var status = await Permission.storage.status;
    if (status.isGranted) {
      print("status.isGranted ${status.isGranted}");
      writeProgressUpdate(kanjiList);
    }
    _allocateLists(kanjiList);
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

  void _addToReview(Progress kanjiItem) {
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

  Widget build(BuildContext context, ScopedReader watch) {
    print('Material app is built');
    AsyncValue<List<Progress>> progressList = watch(progressProvider);

    return progressList.when(
      data: (progressData) {
        _reassignList(progressData);
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
                  kanjiList: progressData,
                  lessonList: _lessonList,
                  reviewList: _reviewList,
                  reassignLists: () => {},
                ),
            LessonManager.routeName: (ctx) => LessonManager(
                  kanjiList: progressData,
                  lessonList: _lessonList,
                  reassignList: () => {},
                ),
            ReviewManager.routeName: (ctx) => ReviewManager(
                  kanjiList: progressData,
                  reviewList: _reviewList,
                  reassignList: () => {},
                ),
            ItemDetailScreen.routeName: (ctx) => ItemDetailScreen(
                  kanjiList: progressData,
                  currentTimeZone: "",
                  reassignList: () => {},
                ),
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Text('Error: $err'),
    );
  }
}
