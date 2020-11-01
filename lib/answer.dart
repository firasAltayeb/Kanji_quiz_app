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
            border: Border.all(color: Colors.black87, width: 3),
            color: Colors.yellow,
          ),
          child: Text(
            'The correct keyword is: ' +
                kanjiAnswer +
                '. \n Did you remember correctly?',
            style: TextStyle(fontSize: 25),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 50),
        //buttonRow(),
      ],
    );

    Widget buttonRow() {
      return Row(
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
      );
    }
  }
}
