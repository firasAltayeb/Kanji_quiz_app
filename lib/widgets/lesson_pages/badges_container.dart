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
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.19,
            child: buildBlockRow(context),
          ),
        ),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          'Building blocks: ',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        ...(learnQueue[queueIndex]['buildingBlocks'] as List<dynamic>)
            .map((blockAddress) {
          print('blockAddress is $blockAddress');
          return blockAddress = Container(
            width: MediaQuery.of(context).size.width * 0.19,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(blockAddress),
                fit: BoxFit.fill,
              ),
            ),
          );
        }).toList()
      ],
    );
  }
}
