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
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: spaceHeight * 0.05),
          ButtonTheme(
            minWidth: spaceWidth * 0.6,
            splashColor: Colors.green,
            child: RaisedButton(
              child: Text(
                'Wrap up session',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: resetHandler,
              color: Colors.yellow,
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
                side: BorderSide(color: Colors.black, width: 2),
              ),
            ),
          ),
          SizedBox(height: spaceHeight * 0.05),
          Text(
            'Your session score is ${scoreToDisplay.toString()}',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: spaceHeight * 0.05),
          Container(
            width: spaceWidth,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 3,
              ),
              color: Colors.green,
            ),
            padding: const EdgeInsets.all(10),
            child: Text(
              'Recalled Correctly',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            height: spaceHeight * 0.19,
            width: correctRecallList.length > 2 ? spaceWidth : spaceWidth / 2,
            child: KanjiBlockRow(correctRecallList),
          ),
          SizedBox(
            height: spaceHeight * 0.1,
          ),
          Container(
            height: spaceHeight * 0.19,
            width: incorrectRecallList.length > 2 ? spaceWidth : spaceWidth / 2,
            child: KanjiBlockRow(incorrectRecallList),
          ),
        ],
      ),
    );
  }
}
