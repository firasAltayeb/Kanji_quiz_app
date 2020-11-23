import 'package:flutter/material.dart';

import 'widgets/lesson_pages/lesson_manager.dart';
import 'widgets/review_pages/review_manager.dart';

class MainBody extends StatefulWidget {
  @override
  _MainBodyState createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            progressButton(context, "Lesson", "3", navigateToLessonPage),
            progressButton(context, "Review", "4", navigateToReviewPage),
          ],
        ),
      ],
    );
  }

  Widget progressButton(
      context, String label, String progress, Function navigate) {
    return Column(
      children: [
        Text(
          label + ": " + progress,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 50,
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
            child: Text(label,
                style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
            onPressed: () {
              navigate(context);
            },
          ),
        )
      ],
    );
  }

  Future navigateToLessonPage(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LessonManager()));
  }

  Future navigateToReviewPage(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ReviewManager()));
  }
}
