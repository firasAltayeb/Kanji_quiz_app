import 'package:flutter/material.dart';

class BadgesContainer extends StatelessWidget {
  final int queueIndex;
  final List<Map<String, Object>> learnQueue;

  final Function nextKanji;
  final Function previousKanji;
  final mnemonicController = TextEditingController();

  BadgesContainer({
    @required this.learnQueue,
    @required this.queueIndex,
    @required this.nextKanji,
    @required this.previousKanji,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        topRow(context),
        keywordArea(context),
        buildBlockRow(context),
      ],
    );
  }

  Widget topRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FlatButton(
          padding: const EdgeInsets.fromLTRB(0, 10, 40, 0),
          textColor: Colors.black,
          child: Text(
            "Prev",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          onPressed: previousKanji,
        ),
        kanjiPicture(
          context: context,
          photoAddress: learnQueue[queueIndex]['photoAddress'],
          requestedwidth: 0.4,
          requestedheight: 0.3,
        ),
        FlatButton(
          padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
          textColor: Colors.black,
          child: Text(
            "Next",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          onPressed: nextKanji,
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

  Widget keywordArea(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 3.0, color: Colors.black),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Text(
        'Keyword: ' + learnQueue[queueIndex]['keyword'],
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget buildBlockRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Building blocks: ',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          kanjiPicture(
            context: context,
            photoAddress: learnQueue[queueIndex]['buildingBlockOne'],
            requestedwidth: 0.19,
            requestedheight: 0.19,
          ),
          kanjiPicture(
            context: context,
            photoAddress: learnQueue[queueIndex]['buildingBlockTwo'],
            requestedwidth: 0.19,
            requestedheight: 0.19,
          ),
        ],
      ),
    );
  }
}
