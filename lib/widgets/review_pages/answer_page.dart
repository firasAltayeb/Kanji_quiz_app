import 'package:flutter/material.dart';

class AnswerPage extends StatelessWidget {
  final Function selectHandler;
  final String kanjiAnswer;

  final List<Map<String, Object>> questions;
  final int questionIndex;

  AnswerPage({
    @required this.selectHandler,
    @required this.kanjiAnswer,
    @required this.questionIndex,
    @required this.questions,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          topRow(context),
          infoBox(context),
          SizedBox(height: 40),
          Row(
            children: [
              answerButton(context, Colors.green, "Correct", 5),
              answerButton(context, Colors.red, "Incorrect", 0),
            ],
          ),
        ],
      ),
    );
  }

  Widget topRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 40, 0),
          child: Text(
            '1/10',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        kanjiPicture(context),
        FlatButton(
          padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
          textColor: Colors.black,
          child: Text(
            "Undo",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          onPressed: null,
        ),
      ],
    );
  }

  Widget kanjiPicture(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.5,
      width: MediaQuery.of(context).size.width / 2,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            questions[questionIndex]['kanjiPicture'],
          ),
          fit: BoxFit.fill,
        ),
      ),
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
        color: Colors.yellow,
      ),
      padding: EdgeInsets.all(10),
      child: Text(
        'The correct keyword is: $kanjiAnswer' +
            '. \n Did you remember correctly?',
        style: TextStyle(fontSize: 25),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget answerButton(
      BuildContext context, Color color, String label, int resultModifier) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height / 3,
      decoration: BoxDecoration(
        color: color,
        border: Border(
          top: BorderSide(width: 3.0, color: Colors.black),
          left: BorderSide(width: 1.0, color: Colors.black),
          right: BorderSide(width: 1.0, color: Colors.black),
          bottom: BorderSide(width: 3.0, color: Colors.black),
        ),
      ),
      child: FlatButton(
        textColor: Colors.white,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () => selectHandler(resultModifier),
      ),
    );
  }
}
