import 'package:flutter/material.dart';

class CornerWidget extends StatelessWidget {
  final String passedText;
  final double height;
  final int flexInt;

  CornerWidget({
    @required this.passedText,
    @required this.height,
    this.flexInt = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flexInt,
      child: Container(
        padding: EdgeInsets.only(top: height * 0.03),
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
