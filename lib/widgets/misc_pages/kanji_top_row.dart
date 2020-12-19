import 'package:flutter/material.dart';

class KanjiTopRow extends StatelessWidget {
  final String leftWidgetText;
  final String rightWidgetText;
  final Function leftWidgerHandler;
  final Function rightWidgerHandler;
  final String kanjiSpriteAddress;

  KanjiTopRow({
    @required this.leftWidgetText,
    @required this.rightWidgetText,
    @required this.leftWidgerHandler,
    @required this.rightWidgerHandler,
    @required this.kanjiSpriteAddress,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        leftWidgetText == 'Prev'
            ? FlatButton(
                padding: const EdgeInsets.fromLTRB(0, 10, 40, 0),
                textColor: Colors.black,
                child: Text(
                  leftWidgetText,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
                onPressed: leftWidgerHandler,
              )
            : Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 40, 0),
                child: Text(
                  leftWidgetText,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
        kanjiPicture(
          context: context,
          address: kanjiSpriteAddress,
          width: 0.4,
          height: 0.3,
        ),
        FlatButton(
          padding: const EdgeInsets.fromLTRB(30, 5, 0, 0),
          textColor: Colors.black,
          child: Text(
            rightWidgetText,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          onPressed: rightWidgerHandler,
        ),
      ],
    );
  }

  Widget kanjiPicture(
      {BuildContext context, String address, double width, double height}) {
    return Container(
      width: MediaQuery.of(context).size.width * width,
      height: MediaQuery.of(context).size.height * height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(address),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
