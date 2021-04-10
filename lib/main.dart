import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:kanji_quiz_app/screens/item_detail_screen.dart';
import 'package:kanji_quiz_app/screens/lesson_mgr_screen.dart';
import 'package:kanji_quiz_app/screens/review_mgr_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanji_quiz_app/providers.dart';
import 'package:flutter/material.dart';
import 'model/progress_model.dart';
import 'main_screen.dart';

void main() async {
  String timezone = await getTimezone();
  runApp(ProviderScope(child: MyApp(timezone)));
}

Future<String> getTimezone() async {
  String timezone;
  try {
    timezone = await FlutterNativeTimezone.getLocalTimezone();
  } catch (e) {
    print('Could not get the local timezone');
  }
  return timezone;
}

class MyApp extends ConsumerWidget {
  final String timezone;

  MyApp(this.timezone);

  Widget build(BuildContext context, ScopedReader watch) {
    print('Material app is built');
    AsyncValue<List<Progress>> progressList = watch(progressProvider);
    final kanjiListState = watch(kanjiListProvider);
    // final kanjiListNotifier = watch(kanjiListProvider.notifier);

    return progressList.when(
      data: (_) {
        // kanjiListNotifier.updateProgress(progressData);
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
                  kanjiList: kanjiListState,
                  lessonList:
                      context.read(kanjiListProvider.notifier).lessonList,
                  reviewList:
                      context.read(kanjiListProvider.notifier).reviewList,
                  reassignList: () {},
                ),
            LessonManager.routeName: (ctx) => LessonManager(
                  kanjiList: kanjiListState,
                  lessonList:
                      context.read(kanjiListProvider.notifier).lessonList,
                  reassignList: () {},
                ),
            ReviewManager.routeName: (ctx) => ReviewManager(
                  kanjiList: kanjiListState,
                  reviewList:
                      context.read(kanjiListProvider.notifier).reviewList,
                  reassignList: () {},
                ),
            ItemDetailScreen.routeName: (ctx) => ItemDetailScreen(
                  kanjiList: kanjiListState,
                  currentTimeZone: timezone,
                  reassignList: () {},
                ),
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Text('Error: $err'),
    );
  }
}
