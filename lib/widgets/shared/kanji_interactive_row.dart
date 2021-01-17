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
      child: GridView.builder(
          itemCount: kanjiAddresses.length,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 1.25,
          ),
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, i) {
            return InkWell(
              onTap: () {},
              child: Ink(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(kanjiAddresses[i]),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            );
          }),
    );
  }
}
