import 'package:flutter/material.dart';

class TextContainer extends StatelessWidget {
  final String passedText;

  TextContainer({@required this.passedText});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 3,
        ),
        color: Theme.of(context).accentColor,
      ),
      padding: const EdgeInsets.all(5),
      child: Text(
        passedText,
        style: TextStyle(
          fontSize: screenHeight * 0.04,
          fontFamily: 'Anton',
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
