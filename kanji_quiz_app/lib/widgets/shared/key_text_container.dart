import 'package:flutter/material.dart';

class KeyTextContainer extends StatelessWidget {
  final String textToDisplay;
  final double widgetHeight;

  KeyTextContainer({
    @required this.textToDisplay,
    this.widgetHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: widgetHeight,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 3.0,
            color: Colors.black,
          ),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
      child: FittedBox(
        child: Text(
          textToDisplay,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
