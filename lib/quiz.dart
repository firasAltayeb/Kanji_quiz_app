import 'package:flutter/material.dart';

import './question.dart';
import './answer.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;
  final Function showButtonClicker;
  final bool showButtonClicked;

  Quiz({
    @required this.questions,
    @required this.questionIndex,
    @required this.answerQuestion,
    @required this.showButtonClicked,
    @required this.showButtonClicker,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Question(
            questions[questionIndex]['questionText'],
          ),
          showButtonClicked
              ? ButtonTheme(
                  minWidth: 400.0,
                  height: 200.0,
                  child: RaisedButton(
                    color: Colors.yellow,
                    textColor: Colors.black,
                    child: Text("Show Answer"),
                    onPressed: showButtonClicker,
                  ),
                )
              : Answer(answerQuestion)
        ],
      ),
    );
  }
}
