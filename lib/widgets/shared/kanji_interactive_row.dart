import 'package:flutter/material.dart';

class KanjiInteractiveRow extends StatelessWidget {
  final double widgetHeight;
  final List<String> kanjiAddresses;
  final Function selectHandler;

  KanjiInteractiveRow({
    @required this.widgetHeight,
    @required this.kanjiAddresses,
    @required this.selectHandler,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widgetHeight,
      child: GridView.builder(
          itemCount: kanjiAddresses.length,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: widgetHeight,
            childAspectRatio: 1.25,
          ),
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, i) {
            return InkWell(
              onTap: selectHandler == null
                  ? null
                  : () => selectHandler(
                        context,
                        kanjiAddresses[i],
                      ),
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
