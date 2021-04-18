import 'package:kanji_quiz_app/widgets/shared/kanji_interactive_row.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../main_providers.dart';

class ResultPage extends ConsumerWidget {
  final Function wrapSession;
  final Function undoLastAnswer;

  ResultPage({
    @required this.wrapSession,
    @required this.undoLastAnswer,
  });

  Widget build(BuildContext bldCtx, ScopedReader watch) {
    final incorrectRecallList = watch(incorrectRecallListProvider).state;
    final correctRecallList = watch(correctRecallListProvider).state;
    final sessionScore = watch(sessionScoreProvider).state;
    final screenHeight = MediaQuery.of(bldCtx).size.height;

    return Column(children: [
      SizedBox(height: screenHeight * 0.03),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(),
          Text(
            'Your session score is $sessionScore',
            style: TextStyle(
              fontSize: screenHeight * 0.035,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            child: Text(
              "Undo",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: screenHeight * 0.035,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: undoLastAnswer,
          ),
        ],
      ),
      SizedBox(height: screenHeight * 0.05),
      textContainer(
        'Recalled Correctly',
        Colors.green,
        screenHeight,
      ),
      if (correctRecallList.length > 0)
        KanjiInteractiveRow(
          kanjiList: correctRecallList,
          widgetHeight: screenHeight * 0.175,
          selectHandler: null,
        ),
      if (correctRecallList.length == 0)
        SizedBox(
          height: screenHeight * 0.175,
        ),
      textContainer(
        'Recalled Incorrectly',
        Colors.red,
        screenHeight,
      ),
      if (incorrectRecallList.length > 0)
        KanjiInteractiveRow(
          kanjiList: incorrectRecallList,
          widgetHeight: screenHeight * 0.175,
          selectHandler: null,
        ),
      if (incorrectRecallList.length == 0)
        SizedBox(
          height: screenHeight * 0.175,
        ),
      wrapUpButton(screenHeight),
    ]);
  }

  Widget wrapUpButton(double screenHeight) {
    return Container(
      padding: EdgeInsets.only(top: screenHeight * 0.08),
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
            fontSize: screenHeight * 0.05,
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
