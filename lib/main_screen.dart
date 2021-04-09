import 'package:kanji_quiz_app/widgets/main_screen/main_drawer.dart';
import 'package:kanji_quiz_app/widgets/main_screen/srs_level_column.dart';
import 'package:kanji_quiz_app/widgets/shared/main_app_bar.dart';
import 'package:flutter/material.dart';
import 'screens/lesson_mgr_screen.dart';
import 'screens/review_mgr_screen.dart';
import 'model/kanji_model.dart';

class MainScreen extends StatelessWidget {
  final List<Kanji> kanjiList;
  final List<Kanji> lessonList;
  final List<Kanji> reviewList;
  final Function reassignList;

  MainScreen({
    @required this.kanjiList,
    @required this.lessonList,
    @required this.reviewList,
    @required this.reassignList,
  });

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
        child: MainAppDrawer(reassignList),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                progressColumn(context, screenHeight, "Lesson",
                    lessonList.length, LessonManager.routeName),
                progressColumn(context, screenHeight, "Review",
                    reviewList.length, ReviewManager.routeName),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.1,
            ),
            SrsLevelColumn(kanjiList: kanjiList)
          ],
        ),
      ),
    );
  }

  Widget progressColumn(context, screenHeight, label, listLength, routeName) {
    return Column(
      children: [
        Text(
          label + ": " + '$listLength',
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
            onPressed: listLength == 0
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
