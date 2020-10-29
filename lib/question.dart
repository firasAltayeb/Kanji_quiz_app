import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final String questionText;

  Question(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      width: 150.0,
      margin: const EdgeInsets.only(top: 50, bottom: 50),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(questionText),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
