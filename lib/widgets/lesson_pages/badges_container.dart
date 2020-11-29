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
          address: learnQueue[queueIndex]['greyPhotoAddress'],
          width: 0.4,
          height: 0.3,
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
    var desiredWidth = 0.19;
    var desiredheight = 0.19;
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Building blocks: ',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          learnQueue[queueIndex]['buildingBlockOne'] == ''
              ? SizedBox(
                  width: MediaQuery.of(context).size.width * desiredWidth,
                  height: MediaQuery.of(context).size.height * desiredheight,
                )
              : kanjiPicture(
                  context: context,
                  address: learnQueue[queueIndex]['buildingBlockOne'],
                  width: desiredWidth,
                  height: desiredheight,
                ),
          learnQueue[queueIndex]['buildingBlockTwo'] == ''
              ? SizedBox(
                  width: MediaQuery.of(context).size.width * desiredWidth,
                  height: MediaQuery.of(context).size.height * desiredheight,
                )
              : kanjiPicture(
                  context: context,
                  address: learnQueue[queueIndex]['buildingBlockTwo'],
                  width: desiredWidth,
                  height: desiredheight,
                ),
        ],
      ),
    );
  }
}
