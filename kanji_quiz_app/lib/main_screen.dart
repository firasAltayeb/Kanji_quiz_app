import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:kanji_quiz_app/main_providers.dart';
import 'widgets/main_screen/srs_level_column.dart';
import 'widgets/main_screen/home_app_bar.dart';
import 'widgets/main_screen/main_drawer.dart';
import 'screens/lesson_mgr_screen.dart';
import 'screens/review_mgr_screen.dart';
import 'screens/practice_screen.dart';
import 'model/learning_item_model.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    print('Main body build is called');

    return Scaffold(
      appBar: HomeAppBar(
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
        final lvlColumnVisible = watch(lvlColumnVisibleProvider).state;
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
              Listener(
                onPointerMove: (moveEvent) {
                  if (moveEvent.delta.dy > 0) {
                    context.read(syncNowProvider).state++;
                    print("swipe down");
                  }
                },
                child: _screenNavigateColumn(
                    buildContext,
                    screenHeight,
                    screenWidth * 2,
                    "Practice",
                    pracitceList,
                    PracticeManager.routeName,
                    pracnqueueIdx),
              ),
              SizedBox(
                height: screenHeight * 0.1,
              ),
              if (lvlColumnVisible) SrsLevelColumn()
            ],
          ),
        );
      }),
    );
  }

  Widget _screenNavigateColumn(BuildContext bldCtx, screenHeight, screenWidth,
      label, List<LearningItem> kanjiList, routeName, queueIdx) {
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
                    bldCtx.read(targetItemProvider).state = kanjiList[queueIdx];
                    Navigator.of(bldCtx)
                        .pushNamed(routeName, arguments: kanjiList);
                  },
          ),
        ),
      ],
    );
  }
}
