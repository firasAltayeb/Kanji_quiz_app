import 'package:Kanji_quiz_app/widgets/lesson_pages/fetch_button.dart';
import 'package:Kanji_quiz_app/widgets/lesson_pages/mnemonic_field.dart';
import 'package:flutter/material.dart';

class MnemonicPage extends StatelessWidget {
  final int queueIndex;
  final List<Map<String, Object>> learnQueue;

  final Function nextKanji;
  final Function previousKanji;
  final mnemonicController = TextEditingController();

  MnemonicPage({
    @required this.learnQueue,
    @required this.queueIndex,
    @required this.nextKanji,
    @required this.previousKanji,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          topRow(context),
          keywordBox(context),
          buildBlockRow(context),
          MnemonicField(
              learnQueue: learnQueue,
              queueIndex: queueIndex,
              nextKanji: nextKanji),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          FetchButton(
            learnQueue: learnQueue,
            queueIndex: queueIndex,
          ),
        ],
      ),
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
        kanjiPicture(context, learnQueue[queueIndex]['photoAddress'], 2.5, 3),
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

  Widget kanjiPicture(BuildContext context, String photoAddress,
      double requestedwidth, double requestedheight) {
    return Container(
      width: MediaQuery.of(context).size.width / requestedwidth,
      height: MediaQuery.of(context).size.height / requestedheight,
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

  Widget keywordBox(BuildContext context) {
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
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Building blocks: ',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          kanjiPicture(
              context, learnQueue[queueIndex]['buildingBlockOne'], 5, 6),
          kanjiPicture(
              context, learnQueue[queueIndex]['buildingBlockTwo'], 5, 6),
        ],
      ),
    );
  }
}
