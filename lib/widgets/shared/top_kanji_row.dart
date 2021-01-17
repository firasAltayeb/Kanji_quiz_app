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
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        leftWidgetText == 'Prev'
            ? Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 30, 0),
                child: cornerButton(leftWidgetText, leftWidgetHandler),
              )
            : cornerWidget(leftWidgetText),
        kanjiPicture(
          kanjiSpriteAddress,
          MediaQuery.of(context).size.width * 0.4,
          MediaQuery.of(context).size.height * 0.3,
        ),
        (rightWidgetText == 'Undo' || rightWidgetText == 'Next')
            ? Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 0, 0),
                child: cornerButton(rightWidgetText, rightWidgetHandler),
              )
            : cornerWidget(rightWidgetText),
      ],
    );
  }

  Widget cornerButton(String passedText, Function handler) {
    return FlatButton(
      textColor: Colors.black,
      child: Text(
        passedText,
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: handler,
    );
  }

  Widget kanjiPicture(String address, double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(address),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget cornerWidget(String passedText) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Text(
          passedText,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
