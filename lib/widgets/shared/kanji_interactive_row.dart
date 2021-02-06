import 'package:flutter/material.dart';

class KanjiInteractiveRow extends StatelessWidget {
  final double widgetHeight;
  final List<String> kanjiIds;
  final Function selectHandler;

  KanjiInteractiveRow({
    @required this.widgetHeight,
    @required this.kanjiIds,
    @required this.selectHandler,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widgetHeight,
      child: GridView.builder(
          itemCount: kanjiIds.length,
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
                        kanjiIds[i],
                      ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Ink(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:
                            AssetImage("assets/images/Colored_template_xl.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                    height: widgetHeight * 0.65,
                    child: Text(
                      kanjiIds[i],
                      style: TextStyle(
                        fontSize: widgetHeight * 0.4,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
