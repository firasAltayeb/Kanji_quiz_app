import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanji_quiz_app/model/kanji_model.dart';
import 'package:flutter/material.dart';

class TopKanjiRow extends ConsumerWidget {
  final Kanji targetKanji;
  final String leftWidgetText;
  final String rightWidgetText;
  final Function leftWidgetHandler;
  final Function rightWidgetHandler;

  TopKanjiRow({
    @required this.targetKanji,
    @required this.leftWidgetText,
    @required this.rightWidgetText,
    @required this.leftWidgetHandler,
    @required this.rightWidgetHandler,
  });

  String determineTemplateAddress(Kanji targetkanji) {
    switch (targetkanji.itemType) {
      case "Radical":
        return "assets/images/blue_badge_template.png";
      case "Primitive":
        return targetkanji.characterLook;
      default:
        return "assets/images/red_badge_template.png";
    }
  }

  Widget build(BuildContext context, ScopedReader watch) {
    var screenHeight = MediaQuery.of(context).size.height * 0.275;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        leftWidgetText == 'Prev'
            ? cornerButton(leftWidgetText, leftWidgetHandler, screenHeight)
            : cornerWidget(leftWidgetText, screenHeight),
        kanjiPicture(screenHeight),
        (rightWidgetText == 'Undo' || rightWidgetText == 'Next')
            ? cornerButton(rightWidgetText, rightWidgetHandler, screenHeight)
            : cornerWidget(rightWidgetText, screenHeight),
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
                  determineTemplateAddress(targetKanji),
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
          if (targetKanji.itemType != "Primitive")
            Container(
              height: height * 0.65,
              child: Text(
                targetKanji.characterLook,
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

  Widget cornerWidget(String passedText, double height) {
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
