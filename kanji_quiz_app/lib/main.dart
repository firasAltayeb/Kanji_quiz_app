import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:kanji_quiz_app/screens/extra_badges_screen.dart';
import 'package:kanji_quiz_app/main_providers.dart';
import 'screens/item_detail_screen.dart';
import 'screens/review_mgr_screen.dart';
import 'screens/lesson_mgr_screen.dart';
import 'screens/user_page_screen.dart';
import 'screens/practice_screen.dart';
import 'model/progress_model.dart';
import 'main_screen.dart';

void main() async {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  Widget build(BuildContext context, ScopedReader watch) {
    print('Material app is built');
    AsyncValue<List<Progress>> progressList = watch(progressProvider);

    return progressList.when(
      data: (_) {
        return MaterialApp(
          title: 'Kanji Quiz App',
          themeMode: ThemeMode.dark,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            primaryIconTheme: IconThemeData(
              color: Colors.black,
            ),
            primaryTextTheme: TextTheme(
              headline6: TextStyle(
                color: Colors.black,
              ),
            ),
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.orange[400],
              brightness: Brightness.dark,
            ),
            accentColor: Colors.yellow[700],
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                elevation: 5,
                side: BorderSide(width: 1, color: Colors.black),
                minimumSize: Size(30, 30),
                onPrimary: Colors.black,
                primary: Colors.transparent,
                shadowColor: Colors.transparent,
              ),
            ),
          ),
          initialRoute: '/',
          routes: {
            '/': (ctx) => MainScreen(),
            UserPage.routeName: (_) => UserPage(),
            LessonManager.routeName: (_) => LessonManager(),
            ReviewManager.routeName: (_) => ReviewManager(),
            PracticeManager.routeName: (_) => PracticeManager(),
            ItemDetailScreen.routeName: (_) => ItemDetailScreen(),
            ExtraBadgesScreen.routeName: (_) => ExtraBadgesScreen(),
          },
        );
      },
      loading: () => Container(
        decoration: new BoxDecoration(color: Colors.orange[400]),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (err, stack) => Text('Error: $err'),
    );
  }
}
