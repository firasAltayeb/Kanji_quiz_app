import 'package:Kanji_quiz_app/widgets/misc/main_app_drawer.dart';
import 'package:Kanji_quiz_app/widgets/misc/srs_level_column.dart';
import 'package:Kanji_quiz_app/widgets/shared/main_app_bar.dart';
import 'package:flutter/material.dart';
import 'screens/lesson_mgr_screen.dart';
import 'screens/review_mgr_screen.dart';

class MainScreen extends StatelessWidget {
  final Function reAllocateMaps;
  final List<dynamic> kanjiMapList;
  final List<Map<String, Object>> lessonMap;
  final List<Map<String, Object>> reviewMap;

  MainScreen({
    @required this.lessonMap,
    @required this.reviewMap,
    @required this.kanjiMapList,
    @required this.reAllocateMaps,
  });

  @override
  Widget build(BuildContext context) {
    print('Main body build is called');
    return Scaffold(
      appBar: MainAppBar(
        title: 'Home Page',
        appBar: AppBar(),
      ),
      drawer: MainAppDrawer(reAllocateMaps),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                progressColumn(context, "Lesson", lessonMap.length,
                    LessonManager.routeName),
                progressColumn(context, "Review", reviewMap.length,
                    ReviewManager.routeName),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            SrsLevelColumn(kanjiMapList: kanjiMapList)
          ],
        ),
      ),
    );
  }

  Widget progressColumn(
      context, String label, int mapLength, String routeName) {
    return Column(
      children: [
        Text(
          label + ": " + '$mapLength',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.04,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.height * 0.2,
          child: ElevatedButton(
            child: Text(
              'Start',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.04,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            onPressed: mapLength == 0
                ? null
                : () {
                    Navigator.of(context).pushNamed(routeName);
                  },
          ),
        ),
      ],
    );
  }
}
