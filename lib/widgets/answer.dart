import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function selectHandler;
  final String kanjiAnswer;

  Answer(this.selectHandler, this.kanjiAnswer);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
        ),
        SizedBox(height: 50),
        buttonRow(),
      ],
    );
  }

  Widget buttonRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: 200.0,
          height: 180.0,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 3,
            ),
          ),
          child: RaisedButton(
            color: Colors.red,
            textColor: Colors.white,
            child: Text(
              "Incorrect",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () => selectHandler(0),
          ),
        ),
        Container(
          width: 200.0,
          height: 180.0,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 3,
            ),
          ),
          child: RaisedButton(
            color: Colors.green,
            textColor: Colors.white,
            child: Text(
              "Correct",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () => selectHandler(5),
          ),
        ),
      ],
    );
  }
}
