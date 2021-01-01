import 'package:flutter/material.dart';
import 'widgets/lesson_widgets/lesson_mgr_screen.dart';
import 'widgets/review_widgets/review_mgr_screen.dart';

class MainBody extends StatelessWidget {
  final Function reAllocateMaps;
  final List<dynamic> kanjiMap;
  final List<Map<String, Object>> lessonMap;
  final List<Map<String, Object>> reviewMap;

  MainBody({
    @required this.kanjiMap,
    @required this.lessonMap,
    @required this.reviewMap,
    @required this.reAllocateMaps,
  });

  Future navigateToLessonPage(context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LessonManager(reAllocateMaps, lessonMap),
      ),
    );
  }

  Future navigateToReviewPage(context) async {
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            progressButton(
                context, "Lesson", lessonMap.length, navigateToLessonPage),
            progressButton(
                context, "Review", reviewMap.length, navigateToReviewPage),
          ],
        ),
      ],
    );
  }

  Widget progressButton(
      context, String label, int progress, Function navigate) {
    return Column(
      children: [
        Text(
          label + ": " + '$progress',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.04,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.yellow,
            border: Border.all(
              color: Colors.black,
              width: 3,
            ),
          ),
          child: FlatButton(
              textColor: Colors.black,
              child: Text('Start',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.03,
                  ),
                  textAlign: TextAlign.center),
              onPressed: progress == 0 ? null : () => navigate(context)),
        )
      ],
    );
  }
}
