import 'package:flutter/material.dart';

import 'widgets/question.dart';
import 'widgets/answer.dart';

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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Question(
            questions[questionIndex]['questionText'],
          ),
          showButtonClicked
              ? showButtonWidget()
              : Answer(answerQuestion, questions[questionIndex]['answerText'])
        ],
      ),
    );
  }

  Widget showButtonWidget() {
    return Container(
      width: 400,
      height: 250,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 3,
        ),
      ),
      child: RaisedButton(
        color: Colors.yellow,
        textColor: Colors.black,
        child: Text(
          "Show Answer",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: showButtonClicker,
      ),
    );
  }
}
