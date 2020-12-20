import 'package:Kanji_quiz_app/widgets/misc_pages/kanji_block_row.dart';
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
      ),
    );
  }

  Widget buildBlockRow(BuildContext context) {
    List<dynamic> blockAddresses = learnQueue[queueIndex]['buildBlocksAddress'];
    print('blockAddresses length is ${blockAddresses.length}');
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Building blocks: ',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          blockAddresses.length == 1
              ? widgetListItem(blockAddresses[0], context)
              : Container(
                  height: MediaQuery.of(context).size.height * 0.19,
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: KanjiBlockRow(blockAddresses),
                ),
        ],
      ),
    );
  }

  Widget widgetListItem(var blockAddress, var context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.19,
      width: MediaQuery.of(context).size.width * 0.25,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(blockAddress),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
