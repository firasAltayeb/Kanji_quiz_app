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
        kanjiPicture(context),
        infoBox(context),
        SizedBox(
          height: MediaQuery.of(context).size.height / 40,
        ),
        recallButtonWidget(context)
      ],
    );
  }

  Widget infoBox(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 3,
        ),
        color: Colors.red,
      ),
      padding: EdgeInsets.all(10),
      child: Text(
        'Can you recall this character?',
        style: TextStyle(fontSize: 25),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget kanjiPicture(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.5,
      width: MediaQuery.of(context).size.width / 2,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            questions[questionIndex]['questionText'],
          ),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget recallButtonWidget(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3,
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
