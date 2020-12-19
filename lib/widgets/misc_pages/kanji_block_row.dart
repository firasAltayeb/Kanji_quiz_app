import 'package:flutter/material.dart';

class KanjiBlockRow extends StatelessWidget {
  final List<dynamic> kanjiAddresses;

  KanjiBlockRow(this.kanjiAddresses);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        if (kanjiAddresses.length == 1)
          widgetListItem(
            kanjiAddresses[0],
            MediaQuery.of(context).size.height * 0.19,
          ),
        if (kanjiAddresses.length > 1)
          ...(kanjiAddresses)
              .map(
                (blockAddress) =>
                    Expanded(child: widgetListItem(blockAddress, null)),
              )
              .toList()
      ],
    );
  }

  Widget widgetListItem(var blockAddress, var providedWidth) {
    // print('buildBlockAddress is $blockAddress');
    return Container(
      width: providedWidth,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(blockAddress),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
