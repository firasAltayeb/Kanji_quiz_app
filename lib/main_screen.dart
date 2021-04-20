import 'package:kanji_quiz_app/widgets/main_screen/srs_level_column.dart';
import 'package:kanji_quiz_app/widgets/main_screen/main_drawer.dart';
import 'package:kanji_quiz_app/widgets/shared/main_app_bar.dart';
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
        title: 'Home Page',
        appBar: AppBar(),
      ),
      drawer: SizedBox(
        width: screenWidth * 0.65,
        child: MainAppDrawer(),
      ),
      body: Consumer(builder: (bldContext, watch, _) {
        final lessonList = watch(lessonListProvider);
        final reviewList = watch(reviewListProvider);
        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * 0.1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  progressColumn(bldContext, screenHeight, "Lesson", lessonList,
                      LessonManager.routeName),
                  progressColumn(bldContext, screenHeight, "Review", reviewList,
                      ReviewManager.routeName),
                ],
              ),
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

  Widget progressColumn(BuildContext bldCtx, screenHeight, label,
      List<Kanji> kanjiList, routeName) {
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
        SizedBox(
          width: screenHeight * 0.2,
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
                    bldCtx.read(targetKanjiProvider).state = kanjiList[0];
                    Navigator.of(bldCtx)
                        .pushNamed(routeName, arguments: kanjiList);
                  },
          ),
        ),
      ],
    );
  }
}
