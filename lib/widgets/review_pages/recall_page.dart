import 'package:flutter/material.dart';

class RecallPage extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function hideRecallButton;

  RecallPage({
    @required this.questions,
    @required this.questionIndex,
    @required this.hideRecallButton,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          topRow(context),
          SizedBox(height: 35),
          infoBox(context),
          SizedBox(height: 35),
          recallButtonWidget(context)
        ],
      ),
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
            '1/10',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        kanjiPicture(context),
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

  Widget kanjiPicture(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.5,
      width: MediaQuery.of(context).size.width / 2,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            questions[questionIndex]['kanjiPicture'],
          ),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget infoBox(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 3,
        ),
        color: Colors.red,
      ),
      padding: EdgeInsets.all(10),
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
      height: MediaQuery.of(context).size.height / 3,
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
