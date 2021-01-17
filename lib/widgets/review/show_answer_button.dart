import 'package:flutter/material.dart';

class ShowAnswerButton extends StatelessWidget {
  final Function selectHandler;

  ShowAnswerButton({
    @required this.selectHandler,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.38,
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        border: Border.all(
          color: Colors.black,
          width: 3,
        ),
      ),
      child: FlatButton(
        textColor: Colors.black,
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
