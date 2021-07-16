import 'package:flutter/material.dart';

class ColoredTextContainer extends StatelessWidget {
  final double widgetHeight;
  final String passedText;
  final Color widgetColor;

  ColoredTextContainer({
    @required this.passedText,
    @required this.widgetHeight,
    this.widgetColor = const Color(0xfffbc02d),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: Colors.black),
        ),
        color: widgetColor,
      ),
      padding: const EdgeInsets.all(10),
      child: Text(
        passedText,
        style: TextStyle(
          fontSize: widgetHeight,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }
}
