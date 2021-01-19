import 'package:flutter/material.dart';

class TopKanjiRow extends StatelessWidget {
  final String leftWidgetText;
  final String rightWidgetText;
  final Function leftWidgetHandler;
  final Function rightWidgetHandler;
  final String kanjiSpriteAddress;

  TopKanjiRow({
    @required this.leftWidgetText,
    @required this.rightWidgetText,
    @required this.leftWidgetHandler,
    @required this.rightWidgetHandler,
    @required this.kanjiSpriteAddress,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        leftWidgetText == 'Prev'
            ? cornerButton(leftWidgetText, leftWidgetHandler)
            : cornerWidget(leftWidgetText, 'left'),
        kanjiPicture(
          kanjiSpriteAddress,
          MediaQuery.of(context).size.height * 0.3,
        ),
        (rightWidgetText == 'Undo' || rightWidgetText == 'Next')
            ? cornerButton(rightWidgetText, rightWidgetHandler)
            : cornerWidget(rightWidgetText, 'right'),
      ],
    );
  }

  Widget cornerButton(String passedText, Function handler) {
    return Expanded(
      flex: 3,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.only(top: 20),
        ),
        child: Text(
          passedText,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: handler,
      ),
    );
  }

  Widget kanjiPicture(String address, double height) {
    return Expanded(
      flex: 4,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(address),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  Widget cornerWidget(String passedText, String area) {
    double paddingRight = area == 'right' ? 0 : 0;
    double paddingLeft = area == 'left' ? 0 : 0;
    return Expanded(
      flex: 3,
      child: Container(
        padding: EdgeInsets.fromLTRB(paddingLeft, 20, paddingRight, 0),
        child: Text(
          passedText,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
