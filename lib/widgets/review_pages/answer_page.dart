import 'package:flutter/material.dart';

class AnswerPage extends StatelessWidget {
  final Function selectHandler;
  final String kanjiAnswer;

  final List<Map<String, Object>> questionQueue;
  final int questionIndex;

  AnswerPage({
    @required this.selectHandler,
    @required this.kanjiAnswer,
    @required this.questionIndex,
    @required this.questionQueue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        topRow(context),
        infoBox(context),
        Expanded(child: SizedBox()),
        Row(
          children: [
            answerButton(context, Colors.green, "Correct", 5),
            answerButton(context, Colors.red, "Incorrect", 0),
          ],
        ),
      ],
    );
  }

  Widget topRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 40, 0),
          child: Text(
            (questionIndex + 1).toString() + '/ ${questionQueue.length}',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        kanjiPicture(
          context: context,
          photoAddress: questionQueue[questionIndex]['photoAddress'],
          requestedwidth: 0.4,
          requestedheight: 0.35,
        ),
        FlatButton(
          padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
          textColor: Colors.black,
          child: Text(
            "Undo",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          onPressed: null,
        ),
      ],
    );
  }

  Widget kanjiPicture(
      {BuildContext context,
      String photoAddress,
      double requestedwidth,
      double requestedheight}) {
    return Container(
      width: MediaQuery.of(context).size.width * requestedwidth,
      height: MediaQuery.of(context).size.height * requestedheight,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            photoAddress,
          ),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget infoBox(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      height: MediaQuery.of(context).size.height * 0.125,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 3,
        ),
        color: Colors.yellow,
      ),
      padding: const EdgeInsets.all(10),
      child: FittedBox(
        fit: BoxFit.fill,
        child: Text(
          'The correct keyword is: $kanjiAnswer' +
              '. \n Did you remember correctly?',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget answerButton(
      BuildContext context, Color color, String label, int resultModifier) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.height * 0.38,
      decoration: BoxDecoration(
        color: color,
        border: Border(
          top: BorderSide(width: 3.0, color: Colors.black),
          left: BorderSide(width: 1.0, color: Colors.black),
          right: BorderSide(width: 1.0, color: Colors.black),
          bottom: BorderSide(width: 3.0, color: Colors.black),
        ),
      ),
      child: FlatButton(
        textColor: Colors.white,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () => selectHandler(resultModifier),
      ),
    );
  }
}
