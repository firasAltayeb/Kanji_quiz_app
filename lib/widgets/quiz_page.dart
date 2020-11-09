import 'package:flutter/material.dart';

class QuizPage extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function hideRecallButton;

  QuizPage({
    @required this.questions,
    @required this.questionIndex,
    @required this.hideRecallButton,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: 250.0,
          width: 200.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                questions[questionIndex]['questionText'],
              ),
              fit: BoxFit.fill,
            ),
          ),
        ),
        SizedBox(height: 100),
        showButtonWidget(context)
      ],
    );
  }

  Widget showButtonWidget(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2.5,
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
        onPressed: hideRecallButton,
      ),
    );
  }
}
