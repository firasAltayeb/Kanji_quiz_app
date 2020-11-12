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
          mnemonicField(context),
          SizedBox(height: 10),
          submitFetchMnemonic(context),
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

  Widget mnemonicField(BuildContext context) {
    String keyword = learnQueue[queueIndex]['keyword'];
    String intialText =
        'Please create a mnemonic for the above kanji $keyword' +
            ' using its bulidng blocks a and b';
    mnemonicController.text = intialText;
    bool textCleared = false;
    return Container(
      width: MediaQuery.of(context).size.width - 30,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 3,
        ),
      ),
      padding: EdgeInsets.all(10),
      child: TextField(
        keyboardType: TextInputType.multiline,
        maxLines: null,
        controller: mnemonicController,
        onChanged: (value) {
          if (textCleared == false) {
            mnemonicController.clear();
            textCleared = true;
          }
        },
      ),
    );
  }

  Widget submitFetchMnemonic(context) {
    return Container(
      width: MediaQuery.of(context).size.width - 30,
      height: MediaQuery.of(context).size.height / 7,
      decoration: BoxDecoration(
        color: Colors.yellow,
        border: Border(
          top: BorderSide(width: 3.0, color: Colors.black),
          right: BorderSide(width: 3.0, color: Colors.black),
          left: BorderSide(width: 3.0, color: Colors.black),
          bottom: BorderSide(width: 5, color: Colors.black),
        ),
      ),
      child: FlatButton(
        textColor: Colors.black,
        child: Text(
          "Fetch From KanjiKoohii",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: null,
      ),
    );
  }
}
