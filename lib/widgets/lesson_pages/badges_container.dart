import 'package:Kanji_quiz_app/widgets/misc_pages/kanji_top_row.dart';
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
    var spriteAddress = learnQueue[queueIndex]['greyPhotoAddress'];

    return Column(
      children: [
        KanjiTopRow(
          kanjiSpriteAddress: spriteAddress,
          leftWidgetText: "Prev",
          rightWidgetText: "Next",
          leftWidgerHandler: previousKanji,
          rightWidgerHandler: nextKanji,
        ),
        keywordArea(context),
        buildBlockRow(context),
      ],
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
    var buildBlockOne = learnQueue[queueIndex]['buildingBlockOne'];
    var buildBlockTwo = learnQueue[queueIndex]['buildingBlockTwo'];
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Building blocks: ',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Container(
            width: MediaQuery.of(context).size.width * desiredWidth,
            height: MediaQuery.of(context).size.height * desiredheight,
            decoration: buildBlockOne == ''
                ? null
                : BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        buildBlockOne,
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * desiredWidth,
            height: MediaQuery.of(context).size.height * desiredheight,
            decoration: buildBlockTwo == ''
                ? null
                : BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        buildBlockTwo,
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
