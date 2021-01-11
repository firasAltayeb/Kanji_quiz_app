import 'package:flutter/material.dart';

class KanjiInteractiveRow extends StatelessWidget {
  final double widgetHeight;
  final List<String> kanjiAddresses;

  KanjiInteractiveRow({
    @required this.widgetHeight,
    @required this.kanjiAddresses,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widgetHeight,
      child: GridView(
        children: (kanjiAddresses)
            .map(
              (blockAddress) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(blockAddress),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            )
            .toList(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 1.25,
        ),
        scrollDirection: Axis.horizontal,
      ),
    );
    ;
  }
}
