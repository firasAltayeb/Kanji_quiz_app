import 'package:flutter/material.dart';

class KeyTextContainer extends StatelessWidget {
  final passedText;

  KeyTextContainer(this.passedText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 3.0, color: Colors.black),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Text(
        passedText,
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );
  }
}
