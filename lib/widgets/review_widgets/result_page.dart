import 'package:Kanji_quiz_app/widgets/misc_widgets/kanji_interactive_row.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final int scoreToDisplay;
  final Function wrapSession;
  final List<String> correctRecallList;
  final List<String> incorrectRecallList;

  ResultPage({
    @required this.wrapSession,
    @required this.scoreToDisplay,
    @required this.correctRecallList,
    @required this.incorrectRecallList,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final children = <Widget>[
      wrapUpButton(screenHeight, screenWidth),
      Text(
        'Your session score is ${scoreToDisplay.toString()}',
        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      ),
      Expanded(child: SizedBox()),
      textContainer('Recalled Correctly', Colors.green),
    ];

    correctRecallList.length > 0
        ? children.add(KanjiInteractiveRow(
            widgetHeight: screenHeight * 0.24,
            kanjiAddresses: correctRecallList,
          ))
        : children.add(SizedBox(height: screenHeight * 0.24));

    children.add(textContainer('Recalled Incorrectly', Colors.red));

    incorrectRecallList.length > 0
        ? children.add(KanjiInteractiveRow(
            widgetHeight: screenHeight * 0.24,
            kanjiAddresses: incorrectRecallList,
          ))
        : children.add(SizedBox(height: screenHeight * 0.24));

    return Column(children: children);
  }

  Widget wrapUpButton(double height, double width) {
    return Container(
      padding: EdgeInsets.only(
        top: height * 0.05,
        bottom: height * 0.03,
      ),
      width: width * 0.8,
      child: RaisedButton(
        child: Text(
          'Wrap up session',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: wrapSession,
        color: Colors.yellow,
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
