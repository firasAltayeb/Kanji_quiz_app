import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'widgets/screen_main/overall_progress_container.dart';
import 'widgets/screen_main/badge_collection_column.dart';
import 'widgets/screen_main/main_app_bar.dart';
import 'widgets/screen_main/main_drawer.dart';
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
        final senQueueIdx = watch(sentenceQueueIdxProvider).state;
        final lsnQueueIndex = watch(lessonQueueIdxProvider).state;
        final revQueueIndex = watch(reviewQueueIdxProvider).state;
        final pracitceList = watch(inPracticeListProvider);
        final reviewList = watch(reviewReadyListProvider);
        final lessonList = watch(inLessonListProvider);
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: screenHeight * 0.03,
                color: Colors.grey[300],
              ),
              bookChapterIndicatorTxt(screenWidth),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _screenNavigateColumn(
                    routeName: LessonManager.routeName,
                    widgetHeight: screenHeight,
                    widgetWidth: screenWidth,
                    queueIdx: lsnQueueIndex,
                    itemList: lessonList,
                    ctx: consumerCtx,
                    label: "To study",
                    extraIdx: 0,
                  ),
                  _screenNavigateColumn(
                    routeName: ReviewManager.routeName,
                    widgetHeight: screenHeight,
                    widgetWidth: screenWidth,
                    queueIdx: revQueueIndex,
                    itemList: reviewList,
                    ctx: consumerCtx,
                    label: "To review",
                    extraIdx: 0,
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
                  routeName: PracticeManager.routeName,
                  widgetWidth: screenWidth * 2,
                  widgetHeight: screenHeight,
                  itemList: pracitceList,
                  queueIdx: pracQueueIdx,
                  extraIdx: senQueueIdx,
                  label: "To practice",
                  ctx: consumerCtx,
                ),
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              if (allProgVisible) OverallProgressContainer(),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              if (lvlColumnVisible) BadgeCollectionColumn()
            ],
          ),
        );
      }),
    );
  }

  Widget bookChapterIndicatorTxt(double screenWidth) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: screenWidth * 0.04,
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(
            text: 'Remembering The Kanji: ',
            style: TextStyle(
              fontStyle: FontStyle.italic,
            ),
          ),
          TextSpan(
            text: "Lesson 7",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _screenNavigateColumn({
    List<StudyItem> itemList,
    double widgetHeight,
    double widgetWidth,
    BuildContext ctx,
    String routeName,
    String label,
    int queueIdx,
    int extraIdx,
  }) {
    return Column(
      children: [
        Text(
          label + ": " + '${itemList.length}',
          style: TextStyle(
            fontSize: widgetHeight * 0.03,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: widgetHeight * 0.02,
        ),
        Container(
          height: widgetHeight * 0.08,
          width: widgetWidth * 0.35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            gradient: LinearGradient(
              colors: [
                Colors.yellow[700],
                Colors.orange[400],
              ],
            ),
          ),
          child: ElevatedButton(
            child: Text(
              queueIdx != 0 || extraIdx > 1
                  ? "Resume Session"
                  : "Start Session",
              style: TextStyle(
                fontSize: label == "Practice"
                    ? widgetHeight * 0.035
                    : widgetHeight * 0.03,
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
