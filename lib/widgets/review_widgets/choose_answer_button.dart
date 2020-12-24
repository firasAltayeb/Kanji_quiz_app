import 'package:flutter/material.dart';

class ChooseAnswerButton extends StatelessWidget {
  final Color buttonColor;
  final String buttonText;
  final bool selectChoice;
  final Function showRecallButton;
  final Function answerQuestion;

  ChooseAnswerButton({
    @required this.buttonColor,
    @required this.buttonText,
    @required this.selectChoice,
    @required this.showRecallButton,
    @required this.answerQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.height * 0.38,
      decoration: BoxDecoration(
        color: buttonColor,
        border: Border(
          top: BorderSide(width: 3.0, color: Colors.black),
          left: BorderSide(width: 1.0, color: Colors.black),
          right: BorderSide(width: 1.0, color: Colors.black),
          bottom: BorderSide(width: 3.0, color: Colors.black),
        ),
      ),
      child: FlatButton(
        textColor: Colors.white,
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          showRecallButton();
          return answerQuestion(selectChoice, context);
        },
      ),
    );
  }
}
