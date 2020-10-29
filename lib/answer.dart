import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function selectHandler;
  final String kanjiAnswer;

  Answer(this.selectHandler, this.kanjiAnswer);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          kanjiAnswer,
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 100),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ButtonTheme(
              minWidth: 200.0,
              height: 180.0,
              child: RaisedButton(
                color: Colors.red,
                textColor: Colors.white,
                child: Text("Incorrect"),
                onPressed: () => selectHandler(0),
              ),
            ),
            ButtonTheme(
              minWidth: 200.0,
              height: 180.0,
              child: RaisedButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text("Correct"),
                onPressed: () => selectHandler(5),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
