import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'widgets/screen_main/overall_progress_container.dart';
import 'widgets/screen_main/interactive_row_column.dart';
import 'widgets/screen_main/main_screen_app_bar.dart';
import 'widgets/screen_main/main_screen_drawer.dart';
import 'screens/lesson_mgr_screen.dart';
import 'screens/review_mgr_screen.dart';
import 'screens/practice_screen.dart';
import 'model/study_item_model.dart';
import 'main_providers.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    print('Main body build is called');

    return Scaffold(
      appBar: MainScreenAppBar(
        appBar: AppBar(),
      ),
      drawer: SizedBox(
        width: screenWidth * 0.65,
        child: MainAppDrawer(),
      ),
      body: Consumer(builder: (consumerCtx, watch, _) {
        final allProgVisible = watch(overallProgressVisibleProvider).state;
        final lvlColumnVisible = watch(lvlColumnVisibleProvider).state;
        final pracQueueIdx = watch(practiceQueueIdxProvider).state;
        final lsnQueueIndex = watch(lessonQueueIdxProvider).state;
        final revQueueIndex = watch(reviewQueueIdxProvider).state;
        final reviewList = watch(reviewReadyListProvider);
        final pracitceList = watch(practiceListProvider);
        final lessonList = watch(lessonListProvider);
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: screenHeight * 0.03,
                color: Colors.grey[300],
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _screenNavigateColumn(
                    consumerCtx,
                    screenHeight,
                    screenWidth,
                    "Lesson",
                    lessonList,
                    LessonManager.routeName,
                    lsnQueueIndex,
                  ),
                  _screenNavigateColumn(
                    consumerCtx,
                    screenHeight,
                    screenWidth,
                    "Review",
                    reviewList,
                    ReviewManager.routeName,
                    revQueueIndex,
                  ),
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
                  consumerCtx,
                  screenHeight,
                  screenWidth * 2,
                  "Practice",
                  pracitceList,
                  PracticeManager.routeName,
                  pracQueueIdx,
                ),
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              if (allProgVisible) OverallProgressContainer(),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              if (lvlColumnVisible) InteractiveRowColumn()
            ],
          ),
        );
      }),
    );
  }

  Widget _screenNavigateColumn(BuildContext ctx, screenHeight, screenWidth,
      label, List<StudyItem> itemList, routeName, queueIdx) {
    return Column(
      children: [
        Text(
          label + ": " + '${itemList.length}',
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
              queueIdx == 0 ? "Start " : "Resume " + "Session",
              style: TextStyle(
                fontSize: screenHeight * 0.04,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            onPressed: itemList.length == 0
                ? null
                : () {
                    HapticFeedback.vibrate();
                    Navigator.of(ctx).pushNamed(routeName, arguments: itemList);
                  },
          ),
        ),
      ],
    );
  }
}
