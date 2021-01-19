import 'package:Kanji_quiz_app/widgets/shared/kanji_interactive_row.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final int scoreToDisplay;
  final Function wrapSession;
  final List<String> correctRecallList;
  final List<String> incorrectRecallList;

  ResultScreen({
    @required this.wrapSession,
    @required this.scoreToDisplay,
    @required this.correctRecallList,
    @required this.incorrectRecallList,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    final children = <Widget>[
      wrapUpButton(context),
      Text(
        'Your session score is ${scoreToDisplay.toString()}',
        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      ),
      Expanded(child: SizedBox()),
      textContainer('Recalled Correctly', Colors.green),
    ];

    //if correct answers exists, create sprites
    correctRecallList.length > 0
        ? children.add(KanjiInteractiveRow(
            widgetHeight: screenHeight * 0.24,
            kanjiAddresses: correctRecallList,
            selectHandler: null,
          ))
        : children.add(SizedBox(height: screenHeight * 0.24));

    children.add(textContainer('Recalled Incorrectly', Colors.red));

    //if incorrect answers exists, create sprites
    incorrectRecallList.length > 0
        ? children.add(KanjiInteractiveRow(
            widgetHeight: screenHeight * 0.24,
            kanjiAddresses: incorrectRecallList,
            selectHandler: null,
          ))
        : children.add(SizedBox(height: screenHeight * 0.24));

    return Column(children: children);
  }

  Widget wrapUpButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.05,
        bottom: MediaQuery.of(context).size.height * 0.03,
      ),
      width: MediaQuery.of(context).size.width * 0.8,
      child: RaisedButton(
        child: Text(
          'Wrap up session',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: wrapSession,
        splashColor: Colors.green,
        color: Theme.of(context).accentColor,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0),
          side: BorderSide(color: Colors.black, width: 2),
        ),
      ),
    );
  }

  Widget textContainer(String txt, Color backColor) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 3,
        ),
        color: backColor,
      ),
      padding: const EdgeInsets.all(10),
      child: Text(
        txt,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
