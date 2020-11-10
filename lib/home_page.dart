import 'package:Kanji_quiz_app/widgets/lesson/lesson_manager.dart';
import 'package:Kanji_quiz_app/widgets/review/review_manager.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return mainBody(context);
  }

  Widget mainBody(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            progressButton(context, "Lesson", "10", navigateToLessonPage),
            progressButton(context, "Review", "30", navigateToReviewPage),
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
