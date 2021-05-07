import 'package:kanji_quiz_app/screens/item_detail_screen.dart';
import 'package:kanji_quiz_app/screens/user_page_screen.dart';
import 'package:kanji_quiz_app/screens/review_mgr_screen.dart';
import 'package:kanji_quiz_app/screens/lesson_mgr_screen.dart';
import 'package:kanji_quiz_app/screens/practice_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanji_quiz_app/main_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
            accentColor: Colors.yellow[700],
            fontFamily: 'Lato',
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.black,
              brightness: Brightness.dark,
            ),
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
            '/': (ctx) => MainScreen(),
            UserPage.routeName: (_) => UserPage(),
            LessonManager.routeName: (_) => LessonManager(),
            ReviewManager.routeName: (_) => ReviewManager(),
            PracticeManager.routeName: (_) => PracticeManager(),
            ItemDetailScreen.routeName: (_) => ItemDetailScreen(
                  currentTimeZone: "",
                ),
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Text('Error: $err'),
    );
  }
}