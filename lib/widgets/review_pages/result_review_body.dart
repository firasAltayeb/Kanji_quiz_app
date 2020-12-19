import 'package:Kanji_quiz_app/widgets/misc_pages/kanji_block_row.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final int scoreToDisplay;
  final Function resetHandler;
  final List<String> correctRecallList;
  final List<String> incorrectRecallList;

  ResultPage({
    @required this.resetHandler,
    @required this.scoreToDisplay,
    @required this.correctRecallList,
    @required this.incorrectRecallList,
  });

  @override
  Widget build(BuildContext context) {
    double spaceWidth = MediaQuery.of(context).size.width;
    double spaceHeight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Your session score is ${scoreToDisplay.toString()}',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        Container(
          height: spaceHeight * 0.19,
          width: correctRecallList.length > 2 ? spaceWidth : spaceWidth / 2,
          child: KanjiBlockRow(correctRecallList),
        ),
        SizedBox(
          height: spaceHeight * 0.05,
          width: spaceWidth,
        ),
        Container(
          height: spaceHeight * 0.19,
          width: incorrectRecallList.length > 2 ? spaceWidth : spaceWidth / 2,
          child: KanjiBlockRow(incorrectRecallList),
        ),
        RaisedButton(
          child: Text('Return to home page'),
          textColor: Colors.blue,
          onPressed: resetHandler,
        ),
      ],
    );
  }
}
