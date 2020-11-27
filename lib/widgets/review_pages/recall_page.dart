import 'package:flutter/material.dart';

class RecallPage extends StatelessWidget {
  final List<Map<String, Object>> questionQueue;
  final int questionIndex;

  final Function hideRecallButton;

  RecallPage({
    @required this.questionQueue,
    @required this.questionIndex,
    @required this.hideRecallButton,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        topRow(context),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        infoBox(context),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Expanded(
          child: recallButtonWidget(context),
        )
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
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 3,
        ),
        color: Colors.red,
      ),
      padding: const EdgeInsets.all(10),
      child: Text(
        'Can you recall this character?',
        style: TextStyle(fontSize: 25),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget recallButtonWidget(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
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
}
