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

    final children = <Widget>[
      SizedBox(height: spaceHeight * 0.05),
      wrapUpButton(spaceWidth),
      SizedBox(height: spaceHeight * 0.05),
      Text(
        'Your session score is ${scoreToDisplay.toString()}',
        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: spaceHeight * 0.05),
      textContainer('Recalled Correctly', Colors.green),
    ];

    updateChildren(children, correctRecallList, spaceHeight, spaceWidth);
    children.add(textContainer('Recalled Incorrectly', Colors.red));
    updateChildren(children, incorrectRecallList, spaceHeight, spaceWidth);

    return SingleChildScrollView(
      child: Column(children: children),
    );
  }

  void updateChildren(
      List<Widget> children, List<String> list, double schigt, double sWdth) {
    for (int index = 0; index <= list.length; index++) {
      var reminder = index % 4;
      if (index > 0 && reminder == 0) {
        print('index is $index');
        children.add(
            kanjiRowContainer(schigt, sWdth, list.sublist(index - 4, index)));
      } else if (index == list.length) {
        print('index is $index');
        if (index % 4 == 3) {
          children.add(kanjiRowContainer(
              schigt, sWdth * 0.7, list.sublist((index - reminder), index)));
        } else if (index % 4 == 2) {
          children.add(kanjiRowContainer(
              schigt, sWdth * 0.5, list.sublist((index - reminder), index)));
        } else if (index % 4 == 1) {
          children.add(kanjiRowContainer(
              schigt, sWdth * 0.25, list.sublist((index - reminder), index)));
        }
      }
    }
  }

  Widget wrapUpButton(double spaceWidth) {
    return ButtonTheme(
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

  Widget kanjiRowContainer(double schigt, double sWdth, List<String> list) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        width: sWdth,
        height: schigt * 0.19,
        child: KanjiBlockRow(list),
      ),
    );
  }
}
