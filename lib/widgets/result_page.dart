import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final int resultScore;
  final Function resetHandler;

  ResultPage(this.resultScore, this.resetHandler);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          resultScore.toString(),
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        RaisedButton(
          child: Text('Restart Quiz'),
          textColor: Colors.blue,
          onPressed: resetHandler,
        ),
      ],
    );
  }
}
