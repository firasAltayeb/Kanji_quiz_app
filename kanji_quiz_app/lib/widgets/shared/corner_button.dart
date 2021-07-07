import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CornerButton extends StatelessWidget {
  final String passedText;
  final Function handler;
  final double height;
  final int flexInt;

  CornerButton({
    @required this.passedText,
    @required this.handler,
    @required this.height,
    this.flexInt = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flexInt,
      child: Padding(
        padding: EdgeInsets.only(top: height * 0.02),
        child: TextButton(
          child: Text(
            passedText,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: height * 0.04,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            HapticFeedback.vibrate();
            handler();
          },
        ),
      ),
    );
  }
}
