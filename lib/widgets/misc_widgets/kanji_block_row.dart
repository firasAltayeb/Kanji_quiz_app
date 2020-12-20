import 'package:flutter/material.dart';

class KanjiBlockRow extends StatelessWidget {
  final List<dynamic> kanjiAddresses;

  KanjiBlockRow(this.kanjiAddresses);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ...(kanjiAddresses)
            .map(
              (blockAddress) => widgetListItem(blockAddress),
            )
            .toList()
      ],
    );
  }

  Widget widgetListItem(var blockAddress) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(blockAddress),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
