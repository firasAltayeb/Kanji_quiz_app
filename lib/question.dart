import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final String questionText;

  Question(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.0,
      width: 200.0,
      margin: const EdgeInsets.only(
        top: 50,
        bottom: 100,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(questionText),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
