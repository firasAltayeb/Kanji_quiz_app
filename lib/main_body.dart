import 'package:Kanji_quiz_app/widgets/misc/srs_level_column.dart';
import 'package:flutter/material.dart';
import 'screens/lesson_mgr_screen.dart';
import 'screens/review_mgr_screen.dart';

class MainBody extends StatelessWidget {
  final Function reAllocateMaps;
  final List<dynamic> kanjiMapList;
  final List<Map<String, Object>> lessonMap;
  final List<Map<String, Object>> reviewMap;

  MainBody({
    @required this.lessonMap,
    @required this.reviewMap,
    @required this.kanjiMapList,
    @required this.reAllocateMaps,
  });

  Future navigateToLessonPage(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LessonManager(reAllocateMaps, lessonMap),
      ),
    );
  }

  Future navigateToReviewPage(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReviewManager(reAllocateMaps, reviewMap),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('Main body build is called');
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              progressColumn(
                  context, "Lesson", lessonMap.length, navigateToLessonPage),
              progressColumn(
                  context, "Review", reviewMap.length, navigateToReviewPage),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          SrsLevelColumn(kanjiMapList: kanjiMapList)
        ],
      ),
    );
  }

  Widget progressColumn(
      context, String label, int mapLength, Function navigate) {
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
        Container(
          width: MediaQuery.of(context).size.height * 0.2,
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            border: Border.all(
              color: Colors.black,
              width: 3,
            ),
          ),
          child: FlatButton(
            textColor: Colors.black,
            child: Text(
              'Start',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.04,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            onPressed: mapLength == 0 ? null : () => navigate(context),
          ),
        )
      ],
    );
  }
}
