import 'package:flutter/material.dart';

class CornerWidget extends StatelessWidget {
  final String passedText;
  final double height;

  CornerWidget({
    @required this.passedText,
    @required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        padding: EdgeInsets.fromLTRB(0, height * 0.03, 0, 0),
        child: Text(
          passedText,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: height * 0.04,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
