import 'package:kanji_quiz_app/model/progress_model.dart';
import 'package:flutter/material.dart';

class KanjiInteractiveRow extends StatelessWidget {
  final double widgetHeight;
  final List<String> itemIds;
  final Function selectHandler;
  final List<Progress> kanjiList;

  KanjiInteractiveRow({
    @required this.kanjiList,
    @required this.widgetHeight,
    @required this.itemIds,
    @required this.selectHandler,
  });

  String determineTemplateAddress(itemId) {
    var itemIndex =
        kanjiList.indexWhere((element) => element.characterLook == itemId);
    switch (kanjiList[itemIndex].itemType) {
      case "Radical":
        return "assets/images/blue_badge_template.png";
      case "Primitive":
        return kanjiList[itemIndex].characterLook;
      default:
        return "assets/images/red_badge_template.png";
    }
  }

  bool isPrimitiveType(itemId) {
    var itemIndex =
        kanjiList.indexWhere((element) => element.characterLook == itemId);
    return kanjiList[itemIndex].itemType == "Primitive";
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widgetHeight,
      child: GridView.builder(
          itemCount: itemIds.length,
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
                        itemIds[i],
                      ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Ink(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          determineTemplateAddress(itemIds[i]),
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  if (!isPrimitiveType(itemIds[i]))
                    Container(
                      height: widgetHeight * 0.65,
                      child: Text(
                        itemIds[i],
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
