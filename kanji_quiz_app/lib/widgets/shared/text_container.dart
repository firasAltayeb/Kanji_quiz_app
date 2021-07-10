import 'package:flutter/material.dart';

class TextContainer extends StatelessWidget {
  final String passedText;
  final double widgetHeight;
  final MaterialColor widgetColor;

  TextContainer({
    @required this.passedText,
    @required this.widgetHeight,
    this.widgetColor = Colors.orange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            widgetColor[300],
            widgetColor[700],
          ],
        ),
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
