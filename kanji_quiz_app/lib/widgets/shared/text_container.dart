import 'package:flutter/material.dart';

class TextContainer extends StatelessWidget {
  final String passedText;
  final Color widgetColor;
  final double widgetHeight;

  TextContainer({
    this.widgetColor,
    @required this.passedText,
    @required this.widgetHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 3,
        ),
        color: widgetColor,
      ),
      padding: const EdgeInsets.all(5),
      child: Text(
        passedText,
        style: TextStyle(
          fontSize: widgetHeight,
          fontFamily: 'Anton',
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
