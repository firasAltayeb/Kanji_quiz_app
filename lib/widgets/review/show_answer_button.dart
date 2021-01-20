import 'package:flutter/material.dart';

class ShowAnswerButton extends StatelessWidget {
  final Function selectHandler;

  ShowAnswerButton(this.selectHandler);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.38,
      child: ElevatedButton(
        child: Text(
          "Show Answer",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: selectHandler,
      ),
    );
  }
}
