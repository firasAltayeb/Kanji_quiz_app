import 'package:Kanji_quiz_app/widgets/shared/kanji_interactive_row.dart';
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
    double screenHeight = MediaQuery.of(context).size.height;

    final children = <Widget>[
      wrapUpButton(context, screenHeight),
      Text(
        'Your session score is ${scoreToDisplay.toString()}',
        style: TextStyle(
          fontSize: screenHeight * 0.05,
          fontWeight: FontWeight.bold,
        ),
      ),
      Expanded(child: SizedBox()),
      textContainer(
        'Recalled Correctly',
        Colors.green,
        screenHeight,
      ),
    ];

    correctRecallList.length > 0
        ? children.add(KanjiInteractiveRow(
            widgetHeight: screenHeight * 0.2,
            kanjiAddresses: correctRecallList,
            selectHandler: null,
          ))
        : children.add(SizedBox(height: screenHeight * 0.24));

    children.add(textContainer(
      'Recalled Incorrectly',
      Colors.red,
      screenHeight,
    ));

    incorrectRecallList.length > 0
        ? children.add(KanjiInteractiveRow(
            widgetHeight: screenHeight * 0.2,
            kanjiAddresses: incorrectRecallList,
            selectHandler: null,
          ))
        : children.add(SizedBox(height: screenHeight * 0.24));

    return Column(children: children);
  }

  Widget wrapUpButton(BuildContext context, double screenHeight) {
    return Container(
      padding: EdgeInsets.only(
        top: screenHeight * 0.05,
        bottom: screenHeight * 0.03,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
            side: BorderSide(color: Colors.black, width: 2),
          ),
        ),
        child: Text(
          ' Wrap up session ',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: wrapSession,
      ),
    );
  }

  Widget textContainer(String txt, Color backColor, double height) {
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
          fontSize: height * 0.035,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
