import 'package:flutter/material.dart';

class ShowAnswerButton extends StatelessWidget {
  final Function selectHandler;

  ShowAnswerButton(this.selectHandler);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height * 0.35;
    return Container(
      width: double.infinity,
      height: screenHeight,
      child: ElevatedButton(
        child: Text(
          "Show Answer",
          style: TextStyle(
            fontSize: screenHeight / 6,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: selectHandler,
      ),
    );
  }
}
