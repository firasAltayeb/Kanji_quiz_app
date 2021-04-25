import 'package:kanji_quiz_app/widgets/main_screen/srs_level_column.dart';
import 'package:kanji_quiz_app/widgets/main_screen/main_drawer.dart';
import 'package:kanji_quiz_app/widgets/shared/main_app_bar.dart';
import 'package:kanji_quiz_app/screens/practice_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanji_quiz_app/main_providers.dart';
import 'screens/lesson_mgr_screen.dart';
import 'screens/review_mgr_screen.dart';
import 'package:flutter/material.dart';
import 'model/kanji_model.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    print('Main body build is called');

    return Scaffold(
      appBar: MainAppBar(
        passedTitle: 'Home',
        appBar: AppBar(),
      ),
      drawer: SizedBox(
        width: screenWidth * 0.65,
        child: MainAppDrawer(),
      ),
      body: Consumer(builder: (buildContext, watch, _) {
        final lessonList = watch(lessonListProvider);
        final reviewList = watch(reviewReadyListProvider);
        final pracitceList = watch(practiceListProvider);
        final lsnqueueIdx = watch(lessonQueueIdxProvider).state;
        final revnqueueIdx = watch(reviewQueueIdxProvider).state;
        final pracnqueueIdx = watch(practiceQueueIdxProvider).state;
        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * 0.1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _screenNavigateColumn(
                      buildContext,
                      screenHeight,
                      screenWidth,
                      "Lesson",
                      lessonList,
                      LessonManager.routeName,
                      lsnqueueIdx),
                  _screenNavigateColumn(
                      buildContext,
                      screenHeight,
                      screenWidth,
                      "Review",
                      reviewList,
                      ReviewManager.routeName,
                      revnqueueIdx),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.1,
              ),
              _screenNavigateColumn(
                  buildContext,
                  screenHeight,
                  screenWidth * 2,
                  "Practice",
                  pracitceList,
                  PracticeManager.routeName,
                  pracnqueueIdx),
              SizedBox(
                height: screenHeight * 0.1,
              ),
              SrsLevelColumn()
            ],
          ),
        );
      }),
    );
  }

  Widget _screenNavigateColumn(BuildContext bldCtx, screenHeight, screenWidth,
      label, List<Kanji> kanjiList, routeName, queueIdx) {
    return Column(
      children: [
        Text(
          label + ": " + '${kanjiList.length}',
          style: TextStyle(
            fontSize: screenHeight * 0.04,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: screenHeight * 0.02,
        ),
        Container(
          width: screenWidth * 0.4,
          child: ElevatedButton(
            child: Text(
              'Start',
              style: TextStyle(
                fontSize: screenHeight * 0.04,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            onPressed: kanjiList.length == 0
                ? null
                : () {
                    bldCtx.read(targetKanjiProvider).state =
                        kanjiList[queueIdx];
                    Navigator.of(bldCtx)
                        .pushNamed(routeName, arguments: kanjiList);
                  },
          ),
        ),
      ],
    );
  }
}
