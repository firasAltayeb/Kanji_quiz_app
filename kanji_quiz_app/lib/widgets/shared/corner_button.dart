import 'package:flutter/material.dart';

class CornerButton extends StatelessWidget {
  final String passedText;
  final Function handler;
  final double height;

  CornerButton({
    @required this.passedText,
    @required this.handler,
    @required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
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
          onPressed: handler,
        ),
      ),
    );
  }
}
