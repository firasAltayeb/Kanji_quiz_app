import 'package:kanji_quiz_app/model/kanji_model.dart';
import 'package:flutter/material.dart';

class TopKanjiRow extends StatelessWidget {
  final String kanjiId;
  final List<Kanji> kanjiList;

  final String leftWidgetText;
  final String rightWidgetText;
  final Function leftWidgetHandler;
  final Function rightWidgetHandler;

  TopKanjiRow({
    @required this.kanjiId,
    @required this.kanjiList,
    @required this.leftWidgetText,
    @required this.rightWidgetText,
    @required this.leftWidgetHandler,
    @required this.rightWidgetHandler,
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
    var screenHeight = MediaQuery.of(context).size.height * 0.275;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        leftWidgetText == 'Prev'
            ? cornerButton(leftWidgetText, leftWidgetHandler, screenHeight)
            : cornerWidget(leftWidgetText, 'left', screenHeight),
        kanjiPicture(screenHeight),
        (rightWidgetText == 'Undo' || rightWidgetText == 'Next')
            ? cornerButton(rightWidgetText, rightWidgetHandler, screenHeight)
            : cornerWidget(rightWidgetText, 'right', screenHeight),
      ],
    );
  }

  Widget cornerButton(String passedText, Function handler, double height) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: EdgeInsets.only(top: height * 0.075),
        child: TextButton(
          child: Text(
            passedText,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: height * 0.15,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: handler,
        ),
      ),
    );
  }

  Widget kanjiPicture(double height) {
    return Expanded(
      flex: 3,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  determineTemplateAddress(kanjiId),
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
          if (!isPrimitiveType(kanjiId))
            Container(
              height: height * 0.65,
              child: Text(
                kanjiId,
                style: TextStyle(
                  fontSize: height * 0.4,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget cornerWidget(String passedText, String area, double height) {
    return Expanded(
      flex: 2,
      child: Container(
        padding: EdgeInsets.fromLTRB(0, height * 0.1, 0, 0),
        child: Text(
          passedText,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: height * 0.15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
