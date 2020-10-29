import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function selectHandler;

  Answer(this.selectHandler);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ButtonTheme(
          minWidth: 200.0,
          height: 200.0,
          child: RaisedButton(
            color: Colors.red,
            textColor: Colors.white,
            child: Text("Incorrect"),
            onPressed: () => selectHandler(0),
          ),
        ),
        ButtonTheme(
          minWidth: 200.0,
          height: 200.0,
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
