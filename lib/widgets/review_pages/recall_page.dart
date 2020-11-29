import 'package:flutter/material.dart';

class RecallPage extends StatelessWidget {
  final List<Map<String, Object>> questionQueue;
  final int questionIndex;

  final Function hideRecallButton;
  final Function selectHandler;
  final bool recallButtonVisible;

  RecallPage({
    @required this.selectHandler,
    @required this.questionQueue,
    @required this.questionIndex,
    @required this.hideRecallButton,
    @required this.recallButtonVisible,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        topRow(context),
        infoBox(context),
        Expanded(child: SizedBox()),
        recallButtonVisible
            ? recallButtonWidget(context)
            : Row(
                children: [
                  answerButton(context, Colors.green, "Correct", true),
                  answerButton(context, Colors.red, "Incorrect", false),
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
          address: questionQueue[questionIndex]['colorPhotoAddress'],
          width: 0.4,
          height: 0.35,
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
      {BuildContext context, String address, double width, double height}) {
    return Container(
      width: MediaQuery.of(context).size.width * width,
      height: MediaQuery.of(context).size.height * height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(address),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget infoBox(BuildContext context) {
    var keyword = questionQueue[questionIndex]['keyword'];
    var infoText = recallButtonVisible
        ? 'Can you recall this character?'
        : 'The correct keyword is: $keyword' +
            '. \n Did you remember correctly?';

    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      height: MediaQuery.of(context).size.height * 0.125,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 3,
        ),
        color: recallButtonVisible ? Colors.red : Colors.yellow,
      ),
      padding: const EdgeInsets.all(10),
      child: FittedBox(
        fit: recallButtonVisible ? BoxFit.fitWidth : BoxFit.fill,
        child: Text(infoText, textAlign: TextAlign.center),
      ),
    );
  }

  Widget recallButtonWidget(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.38,
      decoration: BoxDecoration(
        color: Colors.yellow,
        border: Border.all(
          color: Colors.black,
          width: 3,
        ),
      ),
      child: FlatButton(
        textColor: Colors.black,
        child: Text(
          "Show Answer",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: hideRecallButton,
      ),
    );
  }

  Widget answerButton(
      BuildContext context, Color color, String label, bool answer) {
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
        onPressed: () => selectHandler(answer),
      ),
    );
  }
}
