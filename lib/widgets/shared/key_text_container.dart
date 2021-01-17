import 'package:flutter/material.dart';

class KeyTextContainer extends StatelessWidget {
  final String passedText;
  final double fontSize;
  final TextAlign alignment;

  KeyTextContainer({
    @required this.passedText,
    this.fontSize = 30,
    this.alignment = TextAlign.left,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 3.0,
            color: Colors.black,
          ),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Text(
        passedText,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
        textAlign: alignment,
      ),
    );
  }
}
